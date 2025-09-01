package com.spring.DCShop.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.DCShop.user.service.LoginService;



@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
		
	@Autowired
	private LoginService service;
	
	@RequestMapping("main.do")
	public String main() {
		logger.info("=== url -> main ===");
		
		return "main";
	}
	
	@RequestMapping("login_main.do")
	public String login_main() {
		logger.info("=== url -> login_main ===");
		
		return "user/login/login_main";
	}
	
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }
	    return "main";
	}
	
	//로그인 처리 페이지
	@RequestMapping("loginaction.do")
	public String loginaction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> /loginaction.do ===");
		String id = (String)request.getSession().getAttribute("sessionid");
		if(id == null) {
			service.loginaction(request, response, model);
			
		}
		return "main";
	}
	
	@RequestMapping("comm_main.do")
	public String comm_main() {
		logger.info("=== url -> comm_main ===");
		
		return "comm/comm_main";
	}
	
		@RequestMapping("shopMain3.do")
	public String shopMain3() {
		logger.info("=== url -> comm_main ===");
		
		return "shop/shopMain3";
	}
	
	@RequestMapping("comm_CSD.do")
	public String comm_CSD() {
		logger.info("=== url -> comm_CSD ===");
		
		return "comm/comm_CSD";
	}
	
	@RequestMapping("cart.do")
	public String cart() {
		logger.info("=== url -> cart ===");
		
		return "shop/cart";
	}
	
	@RequestMapping("pay.do")
	public String pay() {
		logger.info("=== url -> pay ===");
		
		return "shop/pay";
	}
}
