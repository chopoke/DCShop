package com.spring.DCShop.mypage.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;


public interface MypageService {
	
	//관리자페이지-가입자5건조회
	public void mypageAdminUser(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;

	//관리자페이지-게시판목록
	public void mypageAdminBoardList(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
}
