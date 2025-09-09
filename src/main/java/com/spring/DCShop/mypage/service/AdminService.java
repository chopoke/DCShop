package com.spring.DCShop.mypage.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface AdminService {
	
	// 회원관리 - 회원목록-가입자5건조회
	public void adminUser(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 게시판관리 - 게시판목록
	public void adminBoardList(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 게시판관리 - 게시판 선택 삭제
	public void adminBoardDelete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 상품관리 - 목록/검색/필터
	public void adminProductList(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 상품관리 - 선택 일괄 상태변경 (품절/활성/입고대기)
	public void adminProductStatus(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
	// 상품관리 - 선택 일괄 삭제
	public void adminProductDelete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
	// 상품관리 - 상품등록폼
	public void adminProductInsert(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
}
