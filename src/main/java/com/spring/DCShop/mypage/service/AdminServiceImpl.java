package com.spring.DCShop.mypage.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

	// 회원목록-최신가입자5건
	@Override
	public void adminUser(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("AdminServiceImpl - adminUser()");
		List<UserDTO> list = dao.adminUserList1();
		model.addAttribute("list", list);
		
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
		
		int deleted = dao.adminProductDelete(idList);
		model.addAttribute("deletedCount", deleted);
	}

	// 상품관리 - 상품등록폼
	@Override
	public void adminProductInsert(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		model.addAttribute("statusList", Arrays.asList("ON", "OFF", "WAIT"));
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
	
}
