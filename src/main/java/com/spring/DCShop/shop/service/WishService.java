package com.spring.DCShop.shop.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;


public interface WishService {
	
	// 찜 목록 불러오기
	public void getWishList(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException;
	
	// 상품 찜 여부
	public void serIsWish(HttpServletRequest req,HttpServletResponse res, Model model)
			throws ServletException, IOException;
	
	// 상품당 찜 갯수
	public void serPdWishCount(HttpServletRequest req,HttpServletResponse res, Model model)
			throws ServletException, IOException;
	
	// 상품 찜
	public int serAddWish(HttpServletRequest req,HttpServletResponse res, Model model)
			throws ServletException, IOException;
	
	// 찜 삭제
	public int serRemoveWish(HttpServletRequest req,HttpServletResponse res, Model model)
			throws ServletException, IOException;
	
	// 찜 갯수 바로 반응용 메서드
	public int getPdWishCount(int pdId);
}
