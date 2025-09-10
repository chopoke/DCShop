package com.spring.DCShop.mypage.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface MypageService {

	public void getCartAndOrderList(HttpServletRequest request, HttpServletResponse response, Model model);
	
	//mypage qna리스트.
	public void myQnaList(HttpServletRequest request, HttpServletResponse response, Model model)
 			throws ServletException, IOException;
}
