package com.spring.DCShop.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.DCShop.mypage.service.MypageService;



@Controller
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private MypageService myService;
	
	
	@RequestMapping("mypage_main.do")
	public String mypage_main(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> mypage_main ===");
		
		// 주문 상품 리스트와 장바구니 리스트 가져와서 뿌려주기
		myService.getCartAndOrderList(request, response, model);;
		
		return "/mypage/mypage_main";
	}

}
