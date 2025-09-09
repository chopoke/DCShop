package com.spring.DCShop.mypage.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface MypageService {

	public void getCartAndOrderList(HttpServletRequest request, HttpServletResponse response, Model model);
	
	// 정보수정 진입 전, 비밀번호 체크
	public int passwordCheck(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 정보수정 페이지 user정보 get
	public void findById(String loginId, Model model);
	
	// 정보 수정 처리
	public void setUserInfo(HttpServletRequest request, HttpServletResponse response, Model model);
	
	// 프로필 사진 수정
	public void profileUpdate(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
}
