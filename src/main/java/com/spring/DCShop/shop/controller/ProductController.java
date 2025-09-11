package com.spring.DCShop.shop.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.DCShop.shop.service.ProductServiceImpl;
import com.spring.DCShop.shop.service.WishServiceImpl;

@Controller
public class ProductController {
	
	@Autowired
	private ProductServiceImpl service;
	
	@Autowired
	private WishServiceImpl wishser;
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	// 상품 상세페이지
	@RequestMapping("/ad_shop_detailAction.pd")
	public String ad_shop_detailAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		logger.info("<<< url ==> ad_shop_detailAction >>>");
		
		service.productDetailAction(request, response, model);
		wishser.serPdWishCount(request, response, model);
		wishser.serIsWish(request, response, model);
		
		return "shop/shop_detailAction";
	}
}
