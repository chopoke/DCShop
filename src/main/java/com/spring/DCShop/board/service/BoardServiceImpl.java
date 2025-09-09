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
import org.springframework.ui.Model;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.board.dao.BoardDAO;
import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.board.dto.CommentDTO;
import com.spring.DCShop.board.page.Paging;


@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO dao;

	// 게시판 목록
	@Override
	public void boardListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - boardListAction()");
		
		// 화면에서 입력받은 값을 가져오기
		String pageNum = request.getParameter("pageNum");
		
		
		// 전체 게시글 갯수 카운트
		Paging paging = new Paging(pageNum);
		int total = dao.boardListTotal();
		System.out.println("total : " + total);
		
		paging.setTotalCount(total);
		
		// 게시글 목록 조회
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<BoardDTO> list = dao.boardListAction(map);
		System.out.println("list : " + list);
		
		//jsp로 처리결과 전달
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
	}

	// 게시판 상세페이지
	@Override
	public void boardDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - boardDetailAction()");
		
		// 화면에서 입력받은 값을 가져오기
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		String u_id = (String)request.getSession().getAttribute("sessionid");
		
		// 조회수 증가 - 목록에서 클릭했을시에만 증가하도록
		int listClick = Integer.parseInt(request.getParameter("listClick"));
		if(listClick == 1) {
			dao.viewsUpdateAction(b_num);
		}
		
		// 게시판 상세페이지 가져오기
		BoardDTO board = dao.boardDetailAction(b_num);

		model.addAttribute("board", board);
		
		// 로그인한 사용자라면 해당 게시글을 추천한 사용자인지 확인
		if (u_id != null) {
			// 회원아이디에 맞는 회원번호 가져오기
			int u_member_id = dao.selectU_member_id(u_id);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("u_member_id", u_member_id);
			map.put("b_num", b_num);
			
			int isRecommended = dao.isRecommended(map);
			
			model.addAttribute("isRecommended", isRecommended);
		} else {
			model.addAttribute("isRecommended", 0);
		}
			
	}
	
	// 게시판 추천 클릭
	public Map<String, Object> recommendClickAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - recommendClickAction()");
		
		// 화면에서 입력받은 값을 가져오기
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		int click = Integer.parseInt(request.getParameter("click"));
		
		String u_id = (String)request.getSession().getAttribute("sessionid");
		
		// 회원아이디에 맞는 회원번호 가져오기
		int u_member_id = dao.selectU_member_id(u_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("b_num", b_num);
		map.put("u_member_id", u_member_id);
		
		if(click == 1) {
			dao.recommendAddAction(map);
		} else {
			dao.recommendRemoveAction(map);
		}
		
		// board_tbl에 추천수 반영
		int success = dao.recommendUpdateAction(b_num);
		
		// 추천 성공 시 현재 추천 수 가져오기
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(success == 1) {
			int b_recommend  = dao.selectB_recommend(b_num);
			result.put("b_recommend", b_recommend);
		}
		
		result.put("success", success);
		
		return result;
	}
	
	// 작성자
	public void selectU_nicknameAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - selectU_nicknameAction()");
		
		String u_id = (String)request.getSession().getAttribute("sessionid");
		
		String u_nickname = dao.selectU_nicknameAction(u_id);
		
		model.addAttribute("u_nickname", u_nickname);
	}

	// 게시판 등록
	@Override
	public int boardInsertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - boardInsertAction()");

		MultipartFile file = request.getFile("b_image");
		System.out.println("file : " + file);
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		int b_num = 0;
		
		try {
			//화면에서 입력받은 값 가져와서 dto에 setter로 담는다
			BoardDTO dto = new BoardDTO();
			String u_id = (String)request.getSession().getAttribute("sessionid");
			
			// 회원아이디에 맞는 회원번호 가져오기
			int u_member_id = dao.selectU_member_id(u_id);
			dto.setU_member_id(u_member_id);
			
			dto.setB_title(request.getParameter("b_title"));
			dto.setB_contents(request.getParameter("b_contents"));
			dto.setB_category(request.getParameter("b_category"));
			
			if(!file.isEmpty()) {
				ServletContext save = request.getSession().getServletContext();
				System.out.println(save);
				
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/board_upload/");
				System.out.println("saveDir : " + saveDir);
				
				String realDir = "D:\\DEV05\\workspace_DCshop\\DCShop\\src\\main\\webapp\\resources\\board_upload\\";
				System.out.println("realDir : " + realDir);
				
				file.transferTo(new File(saveDir + file.getOriginalFilename())); 	// import java.io.File
				fis = new FileInputStream(saveDir + file.getOriginalFilename());
				fos = new FileOutputStream(realDir + file.getOriginalFilename());
				
				int data = 0;
				while((data = fis.read())!= -1) {
					fos.write(data);
				}
				
				String b_image1 = "/DCShop_team/resources/board_upload/" + file.getOriginalFilename();
				System.out.println("p_img1 : " + b_image1);
				dto.setB_image(b_image1);
			} else {
				dto.setB_image(null);
			}
			
			
			// 게시글 작성 처리 후 컨트롤러에서 board_list로 이동
			int insertCnt = dao.boardInsertAction(dto);
			
			// jsp로 처리결과 전달
			model.addAttribute("insertCnt", insertCnt);
			
			b_num = dao.selectB_num(u_member_id);
			
			return b_num;
			
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}
		
		return b_num;
	}

	// 게시판 수정 정보
	@Override
	public void boardUpdateDTOAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		
		BoardDTO dto = dao.boardUpdateDTOAction(b_num);
		System.out.println(dto);
		model.addAttribute("board", dto);
		
	}
	

	// 게시판 수정 등록 및 상세페이지 이동
	@Override
	public int boardUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		int b_num = Integer.parseInt(request.getParameter("b_num"));
	    String b_title = request.getParameter("b_title");
	    String b_contents = request.getParameter("b_contents");
	    String b_category = request.getParameter("b_category");

	    if (b_title == null || b_title.trim().isEmpty() ||
	        b_contents == null || b_contents.trim().isEmpty() ||
	        b_category == null || b_category.trim().isEmpty()) {
	        throw new ServletException("필수 입력 항목이 비어 있습니다.");
	    }

	    BoardDTO dto = new BoardDTO();
	    dto.setB_num(b_num);
	    dto.setB_title(b_title);
	    dto.setB_contents(b_contents);
	    dto.setB_category(b_category);

	    dao.boardUpdateAction(dto);
	    return b_num;
	}

	// 게시판 삭제
	@Override
	@Transactional
	public void boardDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		int b_num = Integer.parseInt(request.getParameter("b_num"));

		// 본인 작성글인지 확인
		String loginId = (String) request.getSession().getAttribute("sessionID");
		if (loginId == null) {
			loginId = (String) request.getSession().getAttribute("sessionid");
		}
		String authorId = dao.selectBoardAuthorId(b_num);
		if (loginId == null || authorId == null || !loginId.equals(authorId)) {
			throw new ServletException("권한이 없습니다.");
		}

		// 자식 레코드 선삭제 (댓글, 추천)
		dao.deleteCommentsByBoard(b_num);
		dao.deleteRecommendsByBoard(b_num);

		int deleteCnt = dao.boardDeleteAction(b_num);
		model.addAttribute("deleteCnt", deleteCnt);
	}

	// 댓글 목록
	@Override
	public void commentListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - commentListAction()");
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		List<CommentDTO> list = dao.commentListAction(b_num);
		model.addAttribute("list", list);
	}

	// 댓글 등록
	@Override
	public void commentInsertAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - commentInsertAction()");
		Integer me = (Integer) request.getSession().getAttribute("session_u_member_id");
		System.out.println("me"+me);
		if (me == null || me == 0) { response.setStatus(401); return; } // 로그인 필요

		String b = request.getParameter("b_num");
		String content = request.getParameter("c_content");
		if (b == null || b.isBlank()) { response.sendError(400, "b_num required"); return; }
		int bnum; try { bnum = Integer.parseInt(b.trim()); } catch (NumberFormatException e) { response.sendError(400, "b_num invalid"); return; }
		if (content == null || content.trim().isEmpty()) { response.sendError(400, "content required"); return; }
		CommentDTO dto = new CommentDTO();
		dto.setB_num(bnum);
		dto.setU_member_id(me); 
		dto.setC_content(content.trim());
		dao.commentInsertAction(dto);
		
	}

	// 댓글 수정
	@Override
	public void commentUpdateAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - commentUpdateAction()");
		int c_num = Integer.parseInt(request.getParameter("c_num"));
	    String c_content = request.getParameter("c_content");

	    CommentDTO dto = new CommentDTO();
	    dto.setC_num(c_num);
	    dto.setC_content(c_content);

	    dao.commentUpdateAction(dto);
	}

	// 댓글 삭제
	@Override
	public void commentDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - commentDeleteAction()");
		
		int c_num = Integer.parseInt(request.getParameter("c_num"));
		dao.commentDeleteAction(c_num); // DELETE
	}

	// 검색
	@Override
	public void searchAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		
	}

}
