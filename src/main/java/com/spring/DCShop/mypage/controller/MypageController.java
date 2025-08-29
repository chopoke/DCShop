package com.spring.DCShop.mypage.controller;

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

import com.spring.DCShop.board.service.BoardServiceImpl;
import com.spring.DCShop.mypage.service.MypageServiceImpl;



@Controller
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
		
	@Autowired
	private MypageServiceImpl service;
	
	@RequestMapping("mypage_main.do")
	public String mypage_main() {
		logger.info("=== url -> mypage_main ===");
		
		return "/mypage/mypage_main";
	}
	
	//게시판관리
	//게시판 목록
	@RequestMapping("mypage_admin_board")
	public String mypage_admin_board(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("=== url -> mypage_admin_board ===");
		service.mypageAdminBoardList(request, response, model);
		return "/mypage/mypage_admin_board";
	}
	
	@RequestMapping("mypage_admin_order")
	public String mypage_admin_order() {
		logger.info("=== url -> mypage_admin_order ===");
		
		return "/mypage/mypage_admin_order";
	}
	
	@RequestMapping("mypage_admin_product")
	public String mypage_admin_product() {
		logger.info("=== url -> mypage_admin_product ===");
		
		return "/mypage/mypage_admin_product";
	}
	
	@RequestMapping("mypage_admin_qna")
	public String mypage_admin_qna() {
		logger.info("=== url -> mypage_admin_qna ===");
		
		return "/mypage/mypage_admin_qna";
	}
	
	@RequestMapping("mypage_admin_review")
	public String mypage_admin_review() {
		logger.info("=== url -> mypage_admin_review ===");
		
		return "/mypage/mypage_admin_review";
	}
	
	@RequestMapping("mypage_admin_user")
	public String mypage_admin_user(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("=== url -> mypage_admin_user ===");
		
		service.mypageAdminUser(request, response, model);
		return "/mypage/mypage_admin_user";
	}
	
}
