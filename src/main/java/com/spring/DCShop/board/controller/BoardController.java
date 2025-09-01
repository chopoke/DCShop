package com.spring.DCShop.board.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.board.service.BoardServiceImpl;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardServiceImpl service;
	
	// 게시판 목록
	@RequestMapping("board_list")
	public String board_list(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => board_list >>>");
		
		service.boardListAction(request, response, model);
		
		return "board/board_list";
	}
	
	// 게시판 상세페이지
	@RequestMapping("board_detail")
	public String board_detail(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => board_detail >>>");
		
		service.boardDetailAction(request, response, model);
		
		return "board/board_detail";
	}
	
	// 게시판 추천 클릭
	@RequestMapping("recommend")
	@ResponseBody
	public Map<String, Object> recommend_click(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => recommend >>>");
		
		Map<String, Object> result = service.recommendClickAction(request, response, model);
		
		return result;
	}
	
	// 게시판 작성
	@RequestMapping("board_insert")
	public String board_insert(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => board_insert >>>");
		
		service.selectU_nicknameAction(request, response, model);
		
		return "board/board_insert";
	}
	
	// 게시판 등록
	@RequestMapping("board_insertAction")
	public void board_insertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => board_insertAction >>>");
		
		int b_num = service.boardInsertAction(request, response, model);
		
		String viewPage=request.getContextPath() + "/board_detail?b_num=" + b_num + "&listClick=0";
		response.sendRedirect(viewPage);
	}
	
	// 게시판 수정 페이지 이동
	@RequestMapping("board_update")
	public String board_update(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => board_update >>>");

		// 수정할 게시글 번호
		int b_num = Integer.parseInt(request.getParameter("b_num")); //b_num 파라미터가 숫자여야 하는데 "undefined" 문자열로 넘어옴

		// 게시판 수정 정보 가져오기
		service.boardUpdateDTOAction(request, response, model);

		return "board/board_update"; // 수정 화면

	}

	// 게시판 수정 등록 및 상세페이지 이동
	@RequestMapping("board_updateAction")
	public void board_updateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {

		logger.info("<<< url => board_updateAction >>>");

		// 수정후 상세페이지로 이동
		int b_num = service.boardUpdateAction(request, response, model);

		String viewPage = request.getContextPath() + "/board_detail?b_num=" + b_num + "&listClick=0";
		response.sendRedirect(viewPage);

	}
	
	// 게시판 삭제
	@RequestMapping("board_delete")
	public void board_delete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => board_delete >>>");

		// 서비스에서 삭제 실행
		service.boardDeleteAction(request, response, model);
		// 삭제 완료 여부를 표시하기 위해 쿼리 파라미터 붙여서 redirect
		String viewPage = request.getContextPath() + "/board_list?delete=success";
		response.sendRedirect(viewPage);
	}

	
	// 댓글 목록
	@RequestMapping("comment_list")
	public String comment_list(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<<url ==> /comment_list>>>");
		
		service.commentListAction(request, response, model);
		return "board/comment_list";
	}
	// 댓글 등록
	@RequestMapping("comment_insert")
	public ResponseEntity<Void> comment_insert(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<<url ==> /comment_insert>>>");
		
		service.commentInsertAction(request, response, model);
		return ResponseEntity.noContent().build();
	}
	// 댓글 수정
	@RequestMapping("comment_update")
	public ResponseEntity<Void> comment_update(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<<url ==> /comment_update>>>");
		
		service.commentUpdateAction(request, response, model);
		return ResponseEntity.noContent().build();
	}
	
	// 댓글 삭제
	@RequestMapping("comment_delete")
	public ResponseEntity<Void> comment_delete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<<url ==> /comment_delete>>>");
		
		service.commentDeleteAction(request, response, model);
		return ResponseEntity.noContent().build();
	}
	// 검색

}
