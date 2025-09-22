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
		// 목록 조회: 카테고리/페이징 파라미터 수집 → DAO 조회 → Model 담기
		System.out.println("NoticeServiceImpl - noticeListAction()");
		
		// 화면에서 입력받은 값을 가져오기
		String pageNum = request.getParameter("pageNum");
		String category = request.getParameter("category"); // 공지, 이벤트
		if (category == null || category.trim().isEmpty()) {
			category = "전체";
		}
		// 전체 게시글 갯수 카운트
		Paging paging = new Paging(pageNum);
		int total = noticeDAO.noticeListTotal(category);
		System.out.println("notice total : " + total);
		
		paging.setTotalCount(total);
		// 게시글 목록 조회
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);
		
		List<BoardDTO> list = noticeDAO.noticeListAction(map);
		System.out.println("notice list : " + list);

		//jsp로 처리결과 전달
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);
	}
	
	// 공지/이벤트 상세페이지
	@Override
	public void noticeDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		// 상세 조회: 목록 클릭 시에만 조회수 증가(listClick=1) → 본문/추천여부 Model 담기
		System.out.println("NoticeServiceImpl - noticeDetailAction()");
		// 화면에서 입력받은 값을 가져오기
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		String u_id = (String)request.getSession().getAttribute("sessionid");
		// 조회수 증가 - 목록에서 클릭했을시에만 증가하도록
		int listClick = Integer.parseInt(request.getParameter("listClick")); 
		if(listClick == 1) { //목록에서 클릭했을 경우에만 조회수 증가
			noticeDAO.noticeViewsUpdateAction(b_num);
		}
		// 게시판 상세페이지 가져오기
		BoardDTO board = noticeDAO.noticeDetailAction(b_num);
		model.addAttribute("board", board);
		//  로그인 사용자가 추천 여부 확인
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
		// 1. 세션에서 로그인 아이디 가져오기
		String u_id = (String)request.getSession().getAttribute("sessionid");
		// 2. DAO 호출 → 닉네임 조회
		String u_nickname = noticeDAO.selectU_nicknameAction(u_id);
		// 3. Model에 담기
		model.addAttribute("u_nickname", u_nickname);
	}
	
	// 공지/이벤트 등록
	@Override
	public int noticeInsertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		// 등록: 로그인 회원 식별 → 파일 업로드 처리(선택) → DAO insert → 생성 번호 반환
		System.out.println("NoticeServiceImpl - noticeInsertAction()");

		MultipartFile file = request.getFile("b_image");
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		int b_num = 0;
		
		try { // 1. DTO 생성 및 값 세팅
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
				// 2. 파일 업로드 처리
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
		// 수정 폼 로드: 글 번호로 기존 데이터 조회 → Model 전달
		System.out.println("NoticeServiceImpl - noticeUpdateDTOAction()");
		
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		// 1. DB에서 기존 데이터 조회
		BoardDTO board = noticeDAO.noticeDetailAction(b_num);
		// 2. Model에 담아 View로 전달
		model.addAttribute("board", board);
	}
	
	// 공지/이벤트 수정
	@Override
	public int noticeUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		// 수정: 제목/내용/카테고리 업데이트, 파일 변경 시 재업로드 처리 → DAO update
		System.out.println("NoticeServiceImpl - noticeUpdateAction()");
		
		MultipartFile file = request.getFile("b_image");
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		try {// 1. 파라미터 추출
			int b_num = Integer.parseInt(request.getParameter("b_num"));
			String b_title = request.getParameter("b_title");
			String b_contents = request.getParameter("b_contents");
			String b_category = request.getParameter("b_category");
			// 2. DTO 생성
			BoardDTO dto = new BoardDTO();
			dto.setB_num(b_num);
			dto.setB_title(b_title);
			dto.setB_contents(b_contents);
			dto.setB_category(b_category);
			// 3. 파일 업로드 처리
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
			// 4. DB update 실행 (DAO 호출)
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
		/*
		 * 공지/이벤트 삭제 처리
		 * - 권한 체크: 관리자만 삭제 가능
		 * - FK 무결성: 부모(공지/이벤트) 삭제 전에 자식(추천, 댓글 등) 선삭제 필요
		 * - 트랜잭션: @Transactional로 전체 작업 단위 보장
		 *   주의) 체크예외(ServletException)만 던지면 기본설정에서 롤백되지 않을 수 있음
		 *        필요 시 RuntimeException 사용 또는 @Transactional(rollbackFor=Exception.class) 권장
		 */
		int b_num = Integer.parseInt(request.getParameter("b_num"));
	    
		// 로그인 사용자 확인
		String loginId = (String) request.getSession().getAttribute("sessionID");
		if (loginId == null) {
			loginId = (String) request.getSession().getAttribute("sessionid");
		}
		// 권한 체크: admin만 가능
		if (!"admin".equals(loginId)) {
			// 실무 팁: 롤백을 확실히 하려면 RuntimeException을 던지는 방식도 고려
			throw new ServletException("권한이 없습니다.");
		}
		
		// 추천(자식) 데이터 선삭제
		noticeDAO.deleteRecommendsByNotice(b_num);

		// 공지/이벤트 삭제(부모)
		int deleteCnt = noticeDAO.noticeDeleteAction(b_num);
		model.addAttribute("deleteCnt", deleteCnt);
		// 주의: deleteCnt == 0 이면 이미 삭제되었거나 없는 글 → 프론트에서 처리
	}
		
	
	// 공지/이벤트 추천 클릭
	@Override
	public Map<String, Object> noticeRecommendClickAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		/*
		 * 공지/이벤트 추천 클릭 처리
		 * - click=1: 추천 추가(insert), click=0: 추천 취소(delete)
		 * - 그 후 게시글의 추천수(b_recommend)를 DB에서 원자적으로 갱신
		 *   (UPDATE ... SET b_recommend = (SELECT COUNT(*) ...))
		 * - 동시성: DB에서 COUNT기반 갱신으로 정합성 확보
		 */
		System.out.println("NoticeServiceImpl - noticeRecommendClickAction()");
		// 1) 파라미터 추출
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		int click = Integer.parseInt(request.getParameter("click"));
		// 2) 로그인 사용자 정보
		String u_id = (String)request.getSession().getAttribute("sessionid");
		int u_member_id = noticeDAO.selectU_member_id(u_id);
		// 3) DAO 호출
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("b_num", b_num);
		map.put("u_member_id", u_member_id);
		if(click == 1) {
			noticeDAO.noticeRecommendAddAction(map);
		} else {
			noticeDAO.noticeRecommendRemoveAction(map);
		}
		// 4) 추천수 갱신 및 결과 구성
		int success = noticeDAO.noticeRecommendUpdateAction(b_num);
		Map<String, Object> result = new HashMap<String, Object>();
		if(success == 1) {
			int b_recommend = noticeDAO.noticeSelectB_recommend(b_num);
			result.put("b_recommend", b_recommend);
		}
		result.put("success", success);
		return result;
	}
	
	
}
