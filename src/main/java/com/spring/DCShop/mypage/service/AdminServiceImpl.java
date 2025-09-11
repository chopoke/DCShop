package com.spring.DCShop.mypage.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.board.page.Paging;
import com.spring.DCShop.mypage.dao.AdminDAO;
import com.spring.DCShop.shop.dto.ShopDTO;
import com.spring.DCShop.user.dto.UserDTO;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDAO dao;

	// 관리자메인
	@Override
	public void adminMain(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("AdminServiceImpl - adminMain()");
		int boardCount = dao.countBoard();
		int orderCount = dao.countOrder();
		int productCount = dao.countProduct();
		int qnaCount = dao.countQna();
		int reviewCount = dao.countReview();
		int userCount = dao.countUser();
		
		model.addAttribute("boardCount", boardCount);
		model.addAttribute("orderCount", orderCount);
		model.addAttribute("productCount", productCount);
		model.addAttribute("qnaCount", qnaCount);
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("userCount", userCount);
	}
	
	// 회원목록-최신가입자5건
	@Override
	public void adminUser(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("AdminServiceImpl - adminUser()");
		List<UserDTO> list = dao.adminUserList1();
		model.addAttribute("list", list);
	}
	
	// 회원목록 - 펫통계
	@Override
	public void adminUserPet(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		Map<String, Object> stats = dao.adminUserPet();
		int dogCount = ((Number)stats.getOrDefault("dog_count",0)).intValue();
		int catCount = ((Number)stats.getOrDefault("cat_count",0)).intValue();
		int maleCount = ((Number)stats.getOrDefault("male_count",0)).intValue();
		int femaleCount = ((Number)stats.getOrDefault("female_count",0)).intValue();
		int neuteredCount = ((Number)stats.getOrDefault("neutered_count",0)).intValue();
		
		model.addAttribute("dogCount", dogCount);
		model.addAttribute("catCount", catCount);
		model.addAttribute("maleCount", maleCount);
		model.addAttribute("femaleCount", femaleCount);
		model.addAttribute("neuteredCount", neuteredCount);
	}

	// 게시판목록
	@Override
	public void adminBoardList(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("AdminServiceImpl - adminBoardList()");
		
		// 1) 파라미터 수집
        String category = trimOrNull(request.getParameter("category")); // 자유/팁/리뷰/질문
        String from = trimOrNull(request.getParameter("from"));     // YYYY-MM-DD
        String to = trimOrNull(request.getParameter("to"));       // YYYY-MM-DD
        String q = trimOrNull(request.getParameter("q"));        // 검색어(제목/내용/작성자)

        // 2) 페이징 셋업 (pageNum)
        String pageNum = request.getParameter("pageNum");
        Paging paging = new Paging(pageNum);

        // 3) 총 건수 조회 (필터 동일 적용)
        Map<String, Object> countParam = new HashMap<>();
        countParam.put("category", category);
        countParam.put("from",     from);
        countParam.put("to",       to);
        countParam.put("q",        q);

        int totalCount = dao.adminBoardCount(countParam);
        paging.setTotalCount(totalCount); // 내부에서 startRow/endRow 계산

        // 4) 목록 조회 파라미터
        Map<String, Object> listParam = new HashMap<>();
        listParam.put("category", category);
        listParam.put("from",     from);
        listParam.put("to",       to);
        listParam.put("q",        q);
        listParam.put("startRow", paging.getStartRow());
        listParam.put("endRow",   paging.getEndRow());

        // 5) 목록 조회
        List<BoardDTO> boardList = dao.adminBoardList(listParam);

        // 6) 모델 바인딩
        model.addAttribute("boardList", boardList);
        model.addAttribute("paging",    paging);
        
    }

    // ---------- 내부 유틸 ----------
    private String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
    // -----------------------------------------------------------------------------
    
    // 게시판 선택 삭제
	@Override
	public void adminBoardDelete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		String[] raw = request.getParameterValues("b_nums");
	    if (raw == null || raw.length == 0) {
	        model.addAttribute("deletedCount", 0);
	        return;
	    }

	    List<Integer> ids = new ArrayList<>(raw.length);
	    for (String s : raw) {
	        if (s == null || s.trim().isEmpty()) continue;
	        try {
	            ids.add(Integer.parseInt(s.trim()));
	        } catch (NumberFormatException ignore) {
	            // 잘못된 값은 스킵
	        }
	    }
	    if (ids.isEmpty()) {
	        model.addAttribute("deletedCount", 0);
	        return;
	    }

	    // 1) 자식 먼저 삭제 (FK 방지)
	    dao.adminBoardRecommentDelete(ids); // 추천
	    dao.adminBoardCommentDelete(ids);   // 댓글 (없으면 내부에서 0건 처리)

	    // 2) 부모 삭제
	    int deleted = dao.adminBoardDelete(ids);

	    model.addAttribute("deletedCount", deleted);
	}

	// 상품관리 - 목록/검색/필터
	@Override
	public void adminProductList(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		// 1) 파라미터로 받아오기
		String status = request.getParameter("status");
		String category = request.getParameter("category");
		String q = request.getParameter("q");
		String pageNum = request.getParameter("pageNum");
		String pageSizeStr = request.getParameter("pageSize");
		
		// 2) 카테고리 분류 방법
		Integer catFrom = null;
		Integer catTo = null;
		if(category != null && category.matches("\\d+")) {
			int code = Integer.parseInt(category);
			if(code % 100 == 0) {
				catFrom = code;
				catTo = code + 99;
			}else {
				catFrom = code;
				catTo = code;
			}
		}
		
		// 3) 검색/필터 맵 구성 객체지향
		Map<String, Object> param = new HashMap<>();
		param.put("status", status);
		param.put("q", q);
		param.put("catFrom", catFrom);
		param.put("catTo", catTo);
		
		// 4) 페이징 처리
		int totalCount = dao.adminProductCount(param);
		Paging paging = new Paging(pageNum);
		paging.setTotalCount(totalCount);
		
		param.put("start", paging.getStartRow());
		param.put("end", paging.getEndRow());
		
		// 5) 목록 조회
		List<ShopDTO> list = dao.adminProductList(param);
		
		// 6) 키값 보내기
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("param_status", status);
		model.addAttribute("param_category", category);
		model.addAttribute("param_q", q);
	}

	// 상품관리 - 선택 일괄 상태변경 (품절/활성/입고대기)
	@Override
	public void adminProductStatus(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		String to = request.getParameter("to");
		String ids = request.getParameter("ids");
		
		if(!isValidStatus(to)) {
			model.addAttribute("error", "허용되지 않는 상태 값입니다.ㅠㅜ");
			return;
		}
		
		List<Integer> idList = parseIdCsv(ids);
		if (idList.isEmpty()) {
			model.addAttribute("error", "선택된 상품이 없습니다.");
			return;
		}
		
		Map<String, Object> param = new HashMap<>();
		param.put("to", to);
		param.put("ids", idList);
		
		int updated = dao.adminProductStatus(param);
		model.addAttribute("updateCount", updated);
		
	}

	// 상품관리 - 선택 일괄 삭제
	@Override
	public void adminProductDelete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		
		String ids = request.getParameter("ids");
		List<Integer> idList = parseIdCsv(ids);
		
		if(idList.isEmpty()) {
			model.addAttribute("error", "선택된 상품이 없습니다.");
			return;
		}
		
		dao.adminProductReviewDelete(idList); //리뷰자식테이블삭제
		dao.adminProductQnaDelete(idList);	//qna자식테이블삭제
		int deleted = dao.adminProductDelete(idList);
		model.addAttribute("deletedCount", deleted);
	}

//	// 상품관리 - 상품등록처리
//	@Override
//	public void adminProductInsert(HttpServletRequest request, HttpServletResponse response, Model model)
//			throws ServletException, IOException {
//		model.addAttribute("statusList", Arrays.asList("ON", "OFF", "WAIT"));
//	}
	// 상품관리 - 상품등록처리
	@Override
	public void adminProductInsert(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		
		ShopDTO dto = new ShopDTO();
		dto.setPd_name(request.getParameter("pd_name"));
		dto.setPd_description(request.getParameter("pd_description"));
		dto.setPd_price(Integer.parseInt(request.getParameter("pd_price")));
		dto.setPd_stock(Integer.parseInt(request.getParameter("pd_stock")));
		dto.setPd_category(Integer.parseInt(request.getParameter("pd_category")));
		dto.setPd_brand(request.getParameter("pd_brand"));
		dto.setPd_image_url(request.getParameter("pd_image_url"));
		dto.setPd_shipping_fee(Integer.parseInt(request.getParameter("pd_shipping_fee")));
		dto.setPd_discount_rate(Integer.parseInt(request.getParameter("pd_discount_rate")));
		dto.setPd_status(request.getParameter("pd_status"));
		dto.setPd_option(request.getParameter("pd_option"));
		dto.setPd_pet_category(Integer.parseInt(request.getParameter("pd_pet_category")));
		dto.setPd_subcategory(Integer.parseInt(request.getParameter("pd_subcategory")));
		dao.adminProductInsert(dto);
		
		
	}
		
	
	// 내부유틸 --------------------
	private boolean isValidStatus(String s) {
        return "ON".equalsIgnoreCase(s) || "OFF".equalsIgnoreCase(s) || "WAIT".equalsIgnoreCase(s);
    }

    private List<Integer> parseIdCsv(String csv) {
        if (csv == null || csv.trim().isEmpty()) return Collections.emptyList();
        String[] arr = csv.split(",");
        List<Integer> list = new ArrayList<>(arr.length);
        for (String a : arr) {
            if (a == null) continue;
            String t = a.trim();
            if (t.isEmpty()) continue;
            try { list.add(Integer.parseInt(t)); } catch (NumberFormatException ignore) {}
        }
        return list;
    }
    // ---------------------------------

    // 상품관리 - 상품수정폼
    @Override
	public void adminProductUpdateForm(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		int pdId = Integer.parseInt(request.getParameter("pd_id"));
		
		ShopDTO dto = dao.adminProductUpdateForm(pdId);
		
		model.addAttribute("dto", dto);
		
	}
    
    // 상품관리 - 상품수정처리
	@Override
	public void adminProductUpdate(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		int pdId = Integer.parseInt(request.getParameter("pd_id"));
		if (pdId <= 0) {
			model.addAttribute("result", "잘못된 요청입니다. (pd_id 누락)");
			return;
		}
		
		String name = request.getParameter("pd_name");
		String brand = request.getParameter("pd_brand");
		String desc = request.getParameter("pd_description");
		String imageUrl = request.getParameter("pd_image_url");
		String option = request.getParameter("pd_option");
		int price = Integer.parseInt(request.getParameter("pd_price"));
		int stock = Integer.parseInt(request.getParameter("pd_stock"));
		int shippingFee = Integer.parseInt(request.getParameter("pd_shipping_fee"));
		int discountRate = Integer.parseInt(request.getParameter("pd_discount_rate"));
		int category = Integer.parseInt(request.getParameter("pd_category"));
		int petCategory = Integer.parseInt(request.getParameter("pd_pet_category"));
		int subcategory = Integer.parseInt(request.getParameter("pd_subcategory"));
		
		String status = request.getParameter("pd_status");
		if (!("판매중".equals(status) || "품절".equals(status) || "재입고대기".equals(status))) {
            status = "판매중";
        }
		
		// DTO 구성
		ShopDTO dto = new ShopDTO();
		dto.setPd_id(pdId);
        dto.setPd_name(name);
        dto.setPd_description(desc);
        dto.setPd_price(price);
        dto.setPd_stock(stock);
        dto.setPd_category(category);
        dto.setPd_brand(brand);
        dto.setPd_image_url(imageUrl);
        dto.setPd_shipping_fee(shippingFee);
        dto.setPd_discount_rate(discountRate);
        dto.setPd_status(status);
        dto.setPd_option(option);
        dto.setPd_pet_category(petCategory);
        dto.setPd_subcategory(subcategory);
        
        // db 값 수정
        int updated = dao.adminProductUpdate(dto);
        
        model.addAttribute("result", updated);
	}

	// 주문관리 - 목록
	@Override
	public void adminOrderList(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String oStatus = request.getParameter("o_status");
		String oPayment = request.getParameter("o_payment");
		String field = request.getParameter("field");
		String keyword = request.getParameter("keyword");
		
		String pageNum = request.getParameter("pageNum");
		
		// 숫자 검색(o_num, pd_id) 대비: 숫자일 때만 equal 조건을 적용
	    Long keywordNum = null;
	    if (("o_num".equals(field) || "pd_id".equals(field)) && keyword != null && keyword.matches("\\d+")) {
	        keywordNum = Long.valueOf(keyword);
	    }
		
		Map<String, Object> sc = new HashMap<>();
		sc.put("from", from);
		sc.put("to", to);
		sc.put("oStatus", oStatus);
		sc.put("oPayment", oPayment);
		sc.put("keywordText", keyword); // LIKE 등에 사용
	    sc.put("keywordNum", keywordNum); // 숫자 equal에만 사용
		
		Paging paging = new Paging(pageNum);
		int totalCount = dao.adminCountOrder(sc);
		paging.setTotalCount(totalCount);
		
		sc.put("startRow", paging.getStartRow());
		sc.put("endRow", paging.getEndRow());
		List<Map<String, Object>> list = dao.findOrder(sc);
		
		model.addAttribute("list", list);
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("pageNum",    paging.getPageNum());
        pagingMap.put("pageSize",   paging.getPageSize());
        pagingMap.put("totalCount", paging.getCount());
        pagingMap.put("startPage",  paging.getStartPage());
        pagingMap.put("endPage",    paging.getEndPage());
        pagingMap.put("prev",       paging.getPrev());
        pagingMap.put("next",       paging.getNext());
        model.addAttribute("paging", pagingMap);
		
        // 페이지 링크 보존 쿼리
        model.addAttribute("pageQuery", buildPageQuery(from, to, oStatus, oPayment, field, keyword));
	}
	
	private String enc(String s) {
        if (s == null) return "";
        return URLEncoder.encode(s, StandardCharsets.UTF_8);
    }

    private String buildPageQuery(String from, String to, String oStatus, String oPayment, String field, String keyword) {
        List<String> parts = new ArrayList<>();
        if (from     != null && !from.isEmpty())     parts.add("from="     + enc(from));
        if (to       != null && !to.isEmpty())       parts.add("to="       + enc(to));
        if (oStatus  != null && !oStatus.isEmpty())  parts.add("o_status=" + enc(oStatus));
        if (oPayment != null && !oPayment.isEmpty()) parts.add("o_payment="+ enc(oPayment));
        if (field    != null && !field.isEmpty())    parts.add("field="    + enc(field));
        if (keyword  != null && !keyword.isEmpty())  parts.add("keyword="  + enc(keyword));
        return String.join("&", parts);
    }

    // -----------------------------------------------------------------------
	

	// 주문관리 - 상세
	@Override
	public void adminOrderDetail(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		String oNumStr = request.getParameter("o_num");
		String pdIdStr = request.getParameter("pd_id");
		if(oNumStr == null || pdIdStr == null) {
			model.addAttribute("dto", null);
			return;
		}
		long oNum = Long.parseLong(oNumStr);
		long pdId = Long.parseLong(pdIdStr);
		
		Map<String, Object> dto = dao.findOrderDetail(oNum, pdId);
		model.addAttribute("dto", dto);
	}

	// 주문관리 - 상태변경
	@Override
	public void adminOrderStatus(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		String toStatus = request.getParameter("to");
		String orderKey = request.getParameter("order_keys");
		

		 // trim + 빈 값 체크 (isEmpty() 사용 안 함)
	    if (toStatus != null)  toStatus  = toStatus.trim();
	    if (orderKey != null) orderKey = orderKey.trim();
	    if (toStatus == null || toStatus.length() == 0
	     || orderKey == null || orderKey.length() == 0) {
	        return;
	    }

	    // "o_num:pd_id,o_num:pd_id,..." -> List<Map{oNum,pdId}>
	    List<Map<String, Object>> keys = new ArrayList<>();

	    int i = 0;
	    int n = orderKey.length();
	    while (i < n) {
	        // 콤마까지 토큰 자르기
	        int j = orderKey.indexOf(',', i);
	        String token = (j == -1) ? orderKey.substring(i) : orderKey.substring(i, j);

	        // trim (간단히)
	        token = token.trim();
	        if (token.length() > 0) {
	            // 콜론 위치 찾기
	            int c = token.indexOf(':');
	            if (c > 0 && c < token.length() - 1) {
	                String left  = token.substring(0, c).trim();
	                String right = token.substring(c + 1).trim();
	                try {
	                    long oNum = Long.parseLong(left);
	                    long pdId = Long.parseLong(right);
	                    Map<String, Object> m = new HashMap<>();
	                    m.put("oNum", oNum);
	                    m.put("pdId", pdId);
	                    keys.add(m);
	                } catch (NumberFormatException ignore) {
	                    // 숫자 아님 → 스킵
	                }
	            }
	        }

	        if (j == -1) break; // 마지막 토큰 처리 끝
	        i = j + 1;          // 다음 토큰 시작
	    }

	    if (keys.size() > 0) {
	        Map<String, Object> param = new HashMap<>();
	        param.put("toStatus", toStatus);
	        param.put("keys", keys);
	        dao.adminOrderStatus(param);
	    }
        
	}
	

	

	

	
	
}
