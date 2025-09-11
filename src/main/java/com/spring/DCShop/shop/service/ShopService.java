package com.spring.DCShop.shop.service;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;


public interface ShopService {

	public void productListAction(HttpServletRequest request, HttpServletResponse response, Model model);
	
	// 카테고리 갯수 가져오기
	public void getCategoryCnt(HttpServletRequest request, HttpServletResponse response, Model model);
}
