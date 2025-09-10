package com.spring.DCShop.shop.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WishController {
	
	private static final Logger logger = LoggerFactory.getLogger(WishController.class);
	
	
	@RequestMapping("wishList.do")
	public String wishList(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		
		return "mypage/wishList";
	}
	
}
