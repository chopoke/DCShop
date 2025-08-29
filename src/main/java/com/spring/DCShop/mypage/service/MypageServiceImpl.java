package com.spring.DCShop.mypage.service;

import java.io.IOException;
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
import com.spring.DCShop.mypage.dao.MypageDAO;
import com.spring.DCShop.user.dto.UserDTO;

@Service
public class MypageServiceImpl implements MypageService{
	
	@Autowired
	private MypageDAO dao;

	// 관리자페이지-회원가입자5건조회
	@Override
	public void mypageAdminUser(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("MypageServiceImpl - mypageAdminUser()");
		List<UserDTO> list = dao.mypageAdminUserList1();
		model.addAttribute("list", list);
		
	}

	// 관리자페이지-게시판목록
	@Override
    public void mypageAdminBoardList(HttpServletRequest request, HttpServletResponse response, Model model)
            throws ServletException, IOException {

        // 1) 필터 파라미터
        String category = trimOrNull(request.getParameter("category"));
        String status   = trimOrNull(request.getParameter("status"));
        String from     = trimOrNull(request.getParameter("from"));
        String to       = trimOrNull(request.getParameter("to"));
        String q        = trimOrNull(request.getParameter("q"));

        // 2) 페이징 파라미터: Paging은 pageNum을 받도록 설계됨
        String pageNumParam = trimOrNull(request.getParameter("pageNum"));
        if (pageNumParam == null) pageNumParam = trimOrNull(request.getParameter("page")); // 호환
        Paging paging = new Paging(pageNumParam);

        // (선택) 페이지당 개수 변경 지원: 기본 10, 파라미터 있으면 덮어씀
        String sizeParam = trimOrNull(request.getParameter("pageSize"));
        if (sizeParam == null) sizeParam = trimOrNull(request.getParameter("size")); // 호환
        if (sizeParam != null) {
            try { paging.setPageSize(Integer.parseInt(sizeParam)); } catch (Exception ignore) {}
        }

        // 3) 카운트용 파라미터 맵 (필터 동일 적용)
        Map<String,Object> countParam = new HashMap<>();
        countParam.put("category", category);
        countParam.put("status",   status);
        countParam.put("from",     from);
        countParam.put("to",       to);
        countParam.put("q",        q);

        // 4) 전체 개수 조회 + 페이징 계산
        int total = dao.adminBoardCount(countParam);
        paging.setTotalCount(total);  // 내부에서 startRow/endRow/pageBlock 등 계산

        // 5) 리스트 조회 파라미터 (startRow/endRow 사용)
        Map<String,Object> listParam = new HashMap<>(countParam);
        listParam.put("startRow", paging.getStartRow());
        listParam.put("endRow",   paging.getEndRow());

        // 6) 목록 조회
        List<BoardDTO> list = dao.adminBoardList(listParam);

        // 7) 모델 바인딩 (JSP는 paging.* 로 접근)
        model.addAttribute("boardList", list);
        model.addAttribute("paging", paging);
        model.addAttribute("paramCategory", category); // 선택: 필터 유지용
        model.addAttribute("paramStatus",   status);
        model.addAttribute("paramFrom",     from);
        model.addAttribute("paramTo",       to);
        model.addAttribute("paramQ",        q);
    }

    // helpers
    private static String trimOrNull(String s) {
        return (s == null) ? null : (s.trim().isEmpty() ? null : s.trim());
    }
	
}
