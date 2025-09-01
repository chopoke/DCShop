package com.spring.DCShop.board.service;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService {

	// 게시판 목록
	public void boardListAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 게시판 상세페이지
	public void boardDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 게시판 추천 클릭
	public Map<String, Object> recommendClickAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 작성자
	public void selectU_nicknameAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 게시판 등록
	public int boardInsertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 게시판 수정 정보
	public void boardUpdateDTOAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 게시판 수정 등록
	public int boardUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 게시판 삭제
	public void boardDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 댓글 목록
	public void commentListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 댓글 등록
	public void commentInsertAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 댓글 수정
	public void commentUpdateAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 댓글 삭제
	public void commentDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 검색
	public void searchAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
}
