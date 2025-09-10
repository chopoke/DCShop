package com.spring.DCShop.board.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.board.dao.NoticeDAO;
import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.board.page.Paging;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;

	// 공지/이벤트 목록
	@Override
	public void noticeListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - noticeListAction()");
		
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category"); // 공지, 이벤트, 전체
		if (category == null || category.trim().isEmpty()) {
			category = "전체";
		}
		
		Paging paging = new Paging(pageNum);
		int total = noticeDAO.noticeListTotal(category);
		System.out.println("notice total : " + total);
		
		paging.setTotalCount(total);
		
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);
		
		List<BoardDTO> list = noticeDAO.noticeListAction(map);
		System.out.println("notice list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);
	}
	
	// 공지/이벤트 상세페이지
	@Override
	public void noticeDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - noticeDetailAction()");
		// 화면에서 입력받은 값을 가져오기
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		String u_id = (String)request.getSession().getAttribute("sessionid");
		// 조회수 증가 - 목록에서 클릭했을시에만 증가하도록
		int listClick = Integer.parseInt(request.getParameter("listClick"));
		if(listClick == 1) {
			noticeDAO.noticeViewsUpdateAction(b_num);
		}
		// 게시판 상세페이지 가져오기
		BoardDTO board = noticeDAO.noticeDetailAction(b_num);
		model.addAttribute("board", board);
		
		if (u_id != null) {
			int u_member_id = noticeDAO.selectU_member_id(u_id);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("u_member_id", u_member_id);
			map.put("b_num", b_num);
			
			int isRecommended = noticeDAO.noticeIsRecommended(map);
			model.addAttribute("isRecommended", isRecommended);
		} else {
			model.addAttribute("isRecommended", 0);
		}
	}
	
	// 공지/이벤트 작성자 정보
	@Override
	public void selectU_nicknameAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - selectU_nicknameAction()");
		
		String u_id = (String)request.getSession().getAttribute("sessionid");
		
		String u_nickname = noticeDAO.selectU_nicknameAction(u_id);
		
		model.addAttribute("u_nickname", u_nickname);
	}
	
	// 공지/이벤트 등록
	@Override
	public int noticeInsertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - noticeInsertAction()");

		MultipartFile file = request.getFile("b_image");
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		int b_num = 0;
		
		try {
			BoardDTO dto = new BoardDTO();
			String u_id = (String)request.getSession().getAttribute("sessionid");
			
			int u_member_id = noticeDAO.selectU_member_id(u_id);
			dto.setU_member_id(u_member_id);
			
			dto.setB_title(request.getParameter("b_title"));
			dto.setB_contents(request.getParameter("b_contents"));
			dto.setB_category(request.getParameter("b_category"));
			
			if(!file.isEmpty()) {
				ServletContext save = request.getSession().getServletContext();
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/board_upload/");
				String realDir = "D:\\DEV05\\workspace_DCshop\\DCShop\\src\\main\\webapp\\resources\\board_upload\\";
				
				file.transferTo(new File(saveDir + file.getOriginalFilename()));
				fis = new FileInputStream(saveDir + file.getOriginalFilename());
				fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				byte[] buffer = new byte[1024];
				int read;
				while((read = fis.read(buffer)) != -1) {
					fos.write(buffer, 0, read);
				}
				
				dto.setB_image(file.getOriginalFilename());
			}
			
			b_num = noticeDAO.noticeInsertAction(dto);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}
		
		return b_num;
	}
	
	// 공지/이벤트 수정 정보 가져오기
	@Override
	public void noticeUpdateDTOAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - noticeUpdateDTOAction()");
		
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		BoardDTO board = noticeDAO.noticeDetailAction(b_num);
		model.addAttribute("board", board);
	}
	
	// 공지/이벤트 수정
	@Override
	public int noticeUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - noticeUpdateAction()");
		
		MultipartFile file = request.getFile("b_image");
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		try {
			int b_num = Integer.parseInt(request.getParameter("b_num"));
			String b_title = request.getParameter("b_title");
			String b_contents = request.getParameter("b_contents");
			String b_category = request.getParameter("b_category");
			
			BoardDTO dto = new BoardDTO();
			dto.setB_num(b_num);
			dto.setB_title(b_title);
			dto.setB_contents(b_contents);
			dto.setB_category(b_category);
			
			if(!file.isEmpty()) {
				ServletContext save = request.getSession().getServletContext();
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/board_upload/");
				String realDir = "D:\\DEV05\\workspace_DCshop\\DCShop\\src\\main\\webapp\\resources\\board_upload\\";
				
				file.transferTo(new File(saveDir + file.getOriginalFilename()));
				fis = new FileInputStream(saveDir + file.getOriginalFilename());
				fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				byte[] buffer = new byte[1024];
				int read;
				while((read = fis.read(buffer)) != -1) {
					fos.write(buffer, 0, read);
				}
				
				dto.setB_image(file.getOriginalFilename());
			}
			
			noticeDAO.noticeUpdateAction(dto);
			return b_num;
			
		} catch(Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}
	}
	
	// 공지/이벤트 삭제
	@Override
	@Transactional
	public void noticeDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		
		String loginId = (String) request.getSession().getAttribute("sessionID");
		if (loginId == null) {
			loginId = (String) request.getSession().getAttribute("sessionid");
		}
		String authorId = noticeDAO.noticeSelectBoardAuthorId(b_num);
		if (loginId == null || authorId == null || !loginId.equals(authorId)) {
			throw new ServletException("권한이 없습니다.");
		}
		 // 추천(자식) 데이터 선삭제
	    noticeDAO.deleteRecommendsByNotice(b_num);

	    // 공지/이벤트 삭제
		int deleteCnt = noticeDAO.noticeDeleteAction(b_num);
		model.addAttribute("deleteCnt", deleteCnt);
	}
	
	// 공지/이벤트 추천 클릭
	@Override
	public Map<String, Object> noticeRecommendClickAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - noticeRecommendClickAction()");
		
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		int click = Integer.parseInt(request.getParameter("click"));
		
		String u_id = (String)request.getSession().getAttribute("sessionid");
		
		int u_member_id = noticeDAO.selectU_member_id(u_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("b_num", b_num);
		map.put("u_member_id", u_member_id);
		
		if(click == 1) {
			noticeDAO.noticeRecommendAddAction(map);
		} else {
			noticeDAO.noticeRecommendRemoveAction(map);
		}
		
		int success = noticeDAO.noticeRecommendUpdateAction(b_num);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(success == 1) {
			int b_recommend = noticeDAO.noticeSelectB_recommend(b_num);
			result.put("b_recommend", b_recommend);
		}
		
		result.put("success", success);
		
		return result;
	}
	
	// 공지/이벤트 목록 
	@Override
	public void unifiedBoardListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - unifiedBoardListAction()");
		
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category"); // 전체, 공지, 이벤트, 커뮤니티
		
		Paging paging = new Paging(pageNum);
		int total = noticeDAO.unifiedBoardListTotal(category);
		System.out.println("unified total : " + total);
		
		paging.setTotalCount(total);
		
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);
		
		List<BoardDTO> list = noticeDAO.unifiedBoardListAction(map);
		System.out.println("unified list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);
	}
	
	// 카테고리별 게시판 목록
	@Override
	public void categoryBoardListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("NoticeServiceImpl - categoryBoardListAction()");
		
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category");
		
		Paging paging = new Paging(pageNum);
		int total = noticeDAO.categoryBoardListTotal(category);
		System.out.println("category total : " + total);
		
		paging.setTotalCount(total);
		
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);
		
		List<BoardDTO> list = noticeDAO.categoryBoardListAction(map);
		System.out.println("category list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);
	}
	
}
