package com.spring.DCShop.join.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.DCShop.join.service.CustomerService;

@Controller
public class CustomerController {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);
	
	@Autowired
	private CustomerService service;
	
	//약관동의 페이지로 이동
	@RequestMapping("termsAgreement.do")
	public String termsAgreement(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException{
		logger.info("CustomerController - join.do");
		
		return "join/termsAgreement";
	}
	
	// 약관동의 완료 -> 회원가입 페이지로 이동
	@RequestMapping("join.do")
	public String join(HttpServletRequest request, HttpServletResponse response, Model model) 
		throws ServletException, IOException{
		logger.info("CustomerController - join.do");
		service.totalAgreement(request, response, model);
		
		return "join/join";
	}
	
	// -> 개랑 고양이 join페이지?
	
//	@RequestMapping("joinAction.do")
//	public String joinAction(HttpServletRequest request, HttpServletResponse response, Model model) 
//			throws ServletException, IOException{
//		
//		return "join/joinAction";
//	}
}
