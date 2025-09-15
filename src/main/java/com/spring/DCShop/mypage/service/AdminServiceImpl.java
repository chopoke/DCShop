package com.spring.DCShop.mypage.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.board.page.Paging;
import com.spring.DCShop.mypage.dao.AdminDAO;
import com.spring.DCShop.shop.dto.QuestDTO;
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


		// 1) 파일 받기 (input name="pd_image")
	    String imageUrl = null;
	    if (request instanceof MultipartHttpServletRequest) {
	        MultipartHttpServletRequest mreq =
	            (MultipartHttpServletRequest) request;

	        MultipartFile file = mreq.getFile("pd_image");
	        if (file != null && !file.isEmpty()) {
	            // 2) 용량 제한(서버단) 보조 체크 (예: 10MB)
	            long MAX = 10L * 1024 * 1024;
	            if (file.getSize() > MAX) {
	                model.addAttribute("error", "이미지 파일은 10MB 이하만 업로드 가능합니다.");
	                return;
	            }

	            // 3) 저장 경로 만들기 (예: /resources/upload/product/yyyyMM/)
	            String yyyymm = new java.text.SimpleDateFormat("yyyyMM").format(new Date());
	            String relDir  = "/resources/upload/product/" + yyyymm; // 웹에서 접근할 상대경로
	            String absDir  = request.getServletContext().getRealPath(relDir);

	            File dir = new File(absDir);
	            if (!dir.exists()) dir.mkdirs();

	            // 4) 파일명 생성 (원본 확장자 유지)
	            String original = file.getOriginalFilename();
	            String ext = (original != null && original.lastIndexOf('.') != -1)
	                    ? original.substring(original.lastIndexOf('.') + 1)
	                    : null;

	            String saved = java.util.UUID.randomUUID().toString().replace("-", "");
	            if (ext != null && !ext.isEmpty()) saved += "." + ext.toLowerCase();

	            File dest = new File(dir, saved);

	            try {
	                file.transferTo(dest);
	                // 5) DB에는 URL(컨텍스트 기준 경로) 저장
	                imageUrl = relDir + "/" + saved;  // 예: /DCShop/resources/upload/product/202509/uuid.jpg
	            } catch (Exception e) {
	                model.addAttribute("error", "이미지 업로드 실패: " + e.getMessage());
	                return;
	            }
	        }
	    }

	    // 파일이 선택되었으면 파일 경로 우선, 없으면(선택 안함) null 유지
	    dto.setPd_image_url(imageUrl);

	    // 6) 저장
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

    // 리뷰관리 - 목록/검색/필터
	@Override
	public void adminReviewList(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("AdminServiceImpl - adminReviewList()");

        // 1) 파라미터
        String category = trimOrNull(request.getParameter("category"));  // dog / cat / null
        String rate     = trimOrNull(request.getParameter("rate"));      // "1"~"5" or null
        String from     = trimOrNull(request.getParameter("from"));      // YYYY-MM-DD or null
        String to       = trimOrNull(request.getParameter("to"));        // YYYY-MM-DD or null
        String q        = trimOrNull(request.getParameter("q"));         // 검색어 or null

        String pageNum  = request.getParameter("pageNum");               // 페이징 (문자)
        Paging paging   = new Paging(pageNum);

        // 2) 총 건수 조회용 파라미터
        Map<String, Object> countParam = new HashMap<>();
        countParam.put("category", category);
        countParam.put("rate",rate);
        countParam.put("from", from);
        countParam.put("to",to);
        countParam.put("q",q);

        int totalCount = dao.adminReviewCount(countParam);
        paging.setTotalCount(totalCount); // 내부에서 startRow/endRow 계산됨

        // 3) 목록 조회용 파라미터
        Map<String, Object> listParam = new HashMap<>();
        listParam.put("category", category);
        listParam.put("rate", rate);
        listParam.put("from", from);
        listParam.put("to", to);
        listParam.put("q", q);
        listParam.put("startRow", paging.getStartRow());
        listParam.put("endRow", paging.getEndRow());

        // 4) 목록 조회
        List<Map<String, Object>> reviewList = dao.adminReviewList(listParam);

        // 5) 모델 바인딩
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("paging",     paging);
		
	}

	// 리뷰관리 - 상세
	@Override
	public void adminReviewDetail(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		
		 // 목록에서 상세로 이동 시 r_num을 파라미터로 넘긴다고 가정
        // (현재 컨트롤러는 /admin_review_detail 로 매핑되어 있으니 ?r_num= 형태)
        String rnumStr = request.getParameter("r_num");
        if (rnumStr == null || rnumStr.trim().isEmpty()) {
            model.addAttribute("error", "리뷰 번호가 없습니다.");
            return;
        }

        int rNum;
        try {
            rNum = Integer.parseInt(rnumStr.trim());
        } catch (NumberFormatException e) {
            model.addAttribute("error", "리뷰 번호 형식이 올바르지 않습니다.");
            return;
        }

        Map<String, Object> detail = dao.adminReviewDetail(rNum); // Map으로 받으면 JSP에서 키만 맞추면 됨
        model.addAttribute("detail", detail);
		
	}

	// 리뷰관리 - 선택 일괄 삭제
	@Override
	public void adminReviewDelete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		 System.out.println("AdminServiceImpl - adminReviewDelete()");

	        // admin_review.jsp의 hidden(name="ids") CSV 를 받는다고 가정
	        String idsCsv = request.getParameter("ids");
	        if (idsCsv == null || idsCsv.trim().isEmpty()) {
	            model.addAttribute("deletedCount", 0);
	            model.addAttribute("error", "선택된 항목이 없습니다.");
	            return;
	        }

	        // CSV → List<Integer>
	        List<Integer> idList = new ArrayList<>();
	        for (String s : idsCsv.split(",")) {
	            if (s == null) continue;
	            String t = s.trim();
	            if (t.isEmpty()) continue;
	            try {
	                idList.add(Integer.parseInt(t));
	            } catch (NumberFormatException ignore) {}
	        }
	        if (idList.isEmpty()) {
	            model.addAttribute("deletedCount", 0);
	            model.addAttribute("error", "선택된 항목이 없습니다.");
	            return;
	        }

	        int deleted = dao.adminReviewDelete(idList);
	        model.addAttribute("deletedCount", deleted);
	}
	
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
		
		// ❗ 새 파일이 없으면 기존 이미지 유지
	    final String oldUrl = request.getParameter("pd_image_url_old"); // update.jsp의 hidden
	    String imageUrl = oldUrl;
	    
	    if (request instanceof MultipartHttpServletRequest) {
	        MultipartHttpServletRequest mreq =
	                (MultipartHttpServletRequest) request;

	        MultipartFile file = mreq.getFile("pd_image");
	        if (file != null && !file.isEmpty()) {
	            // 용량 보조 체크 (10MB)
	            long MAX = 10L * 1024 * 1024;
	            if (file.getSize() > MAX) {
	                model.addAttribute("error", "이미지 파일은 10MB 이하만 업로드 가능합니다.");
	                // 폼으로 되돌리고 싶다면 forward view 리턴; 현재 패턴 유지 위해 여기선 그냥 기존 이미지로 진행
	            } else {
	                // 저장 디렉터리: /resources/upload/product/yyyyMM
	                String yyyymm = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	                String relDir = "/resources/upload/product/" + yyyymm; // ★ DB엔 이 상대경로만 저장(컨텍스트 제외)
	                String absDir = request.getServletContext().getRealPath(relDir);

	                File dir = new File(absDir);
	                if (!dir.exists()) dir.mkdirs();

	                String original = file.getOriginalFilename();
	                String ext = (original != null && original.lastIndexOf('.') != -1)
	                        ? original.substring(original.lastIndexOf('.') + 1)
	                        : null;

	                String saved = java.util.UUID.randomUUID().toString().replace("-", "");
	                if (ext != null && !ext.isEmpty()) saved += "." + ext.toLowerCase();

	                File dest = new File(dir, saved);
	                try {
	                    file.transferTo(dest);
	                    // 컨텍스트 제외한 상대경로만 DB에 저장
	                    imageUrl = relDir + "/" + saved; // 예: /resources/upload/product/202509/uuid.jpg
	                } catch (Exception e) {
	                    model.addAttribute("error", "이미지 업로드 실패: " + e.getMessage());
	                    // 실패 시 기존 이미지 유지(imageUrl=old)
	                }
	            }
	        }
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
		String oNum = request.getParameter("o_num");
		if (oNum == null || oNum.trim().isEmpty()) {
	        oNum = (String) request.getSession().getAttribute("last_o_num"); // ★ 보정
	    }

	    if (oNum == null || oNum.trim().isEmpty()) {
	        model.addAttribute("info", null);
	        model.addAttribute("items", java.util.Collections.emptyList());
	        model.addAttribute("detailError", "주문번호가 없습니다.");
	        return;
	    }
		
		Map<String, Object> info = dao.adminOrderInfo(oNum);
		List<Map<String, Object>> items = dao.adminOrderProductList(oNum);
		
		String pdId = request.getParameter("pd_id");
		request.getSession().setAttribute("last_o_num", oNum);
		model.addAttribute("info", info);
		model.addAttribute("items", items);
		model.addAttribute("o_num", oNum);
		model.addAttribute("pd_id", pdId);
		
	}

	// 주문관리 - 주문상태변경
	@Override
	public void adminOrderStatus(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
        String newStatus = request.getParameter("new_status");
        String oNum = request.getParameter("o_num");
        
        int updated = dao.adminOrderStatus(oNum, newStatus);
        model.addAttribute("updatedCount", updated);
        request.getSession().setAttribute("last_o_num", oNum);
	}

	// 주문관리 - 배송상태변경
	@Override
	public void adminOrderDelivery(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		String oNum  = request.getParameter("o_num");
	    String state = request.getParameter("new_state");
	    
	    int updated = dao.adminOrderDelivery(oNum, state);
	    model.addAttribute("updatedShipCount", updated);
	    request.getSession().setAttribute("last_o_num", oNum);
		
	}
	

	

	

	
	
    // 문의관리 - 문의 리스트 
 	@Override
 	public void adminQnaList(HttpServletRequest request, HttpServletResponse response, Model model)
 			throws ServletException, IOException {
 		
 		//검색조건, user권한, paging에 대한 데이터를 담을 map.
 		Map<String, Object> map = new HashMap<String, Object>();
 		
 		//검색을 위한 검색 조건 체크.
 		String q_answer = request.getParameter("q_answer");
		String q_category = request.getParameter("q_category");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		
		// 문의목록 띄우기 전 조건의 null값을 체크. null이라면 map에 넣지 않음.
		if(q_answer != null){ map.put("q_answer", q_answer); }
		if(q_category != null){ map.put("q_category", q_category); }
		if(q_answer != null){ map.put("from", from); }
		if(q_answer != null){ map.put("to", to); }
		
		
		//페이지 요청 시 요청자의 권한 체크
		String u_role = (String)request.getSession().getAttribute(("session_u_role"));
		Integer sessionId = (Integer)(request.getSession().getAttribute(("session_u_member_id")));
		
		if(sessionId != null && u_role != null && ("USER"== u_role || "USER".equals(u_role))) {
			// 일반 회원이 관리자 페이지를 요청했다면 타인의 정보를 조회하지 못함.
			return;
		}
		else if(sessionId != null && u_role != null && (u_role=="ADMIN" || "ADMIN".equals(u_role))){
			//관리자 권한이 admin이라면 그냥 조회 ok 다음으로 넘어가기.
		}
		else {	//로그인을 안했다면 그냥 리턴
			return;
		}
		
		//페이징
		String pageNum = request.getParameter("pageNum");
		
		Paging paging = new Paging(pageNum);
		
		int total = dao.adminQnaCnt(map);			// paging을 위한 갯수 호출
		
		paging.setTotalCount(total);
		
		map.put("start", paging.getStartRow());
		map.put("end", paging.getEndRow());
		
		List<QuestDTO> list = dao.adminQnaList(map);//list 호출
		
		System.out.println("list => "+list);
		
 		model.addAttribute("list", list);
 		model.addAttribute("paging", paging);
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
 	
 	// 회원목록 - 탈퇴회원5건
	@Override
	public void adminUserDelete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		List<UserDTO> list2 = dao.adminUserList2();
		model.addAttribute("list2", list2);
	}
}