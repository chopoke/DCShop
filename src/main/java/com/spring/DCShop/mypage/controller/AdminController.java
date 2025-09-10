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

import com.spring.DCShop.mypage.service.AdminServiceImpl;

@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminServiceImpl service;
	
	//관리자 마이페이지
	@RequestMapping("admin_main")
	public String admin_main() {
		logger.info("=== url -> admin_main ===");
		
		return "admin/admin_main";
	}
	
	
	//게시판 목록
	@RequestMapping("admin_board")
	public String admin_board(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("=== url -> admin_board ===");
		service.adminBoardList(request, response, model);
		return "admin/admin_board";
	}
	
	// 게시글 선택 삭제
	@RequestMapping("admin_board_delete")
	public String deleteSelected(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
	    logger.info("=== url -> admin_board/delete ===");

	    service.adminBoardDelete(request, response, model);

	    return "redirect:/admin_board";
	}
	
	
	@RequestMapping("admin_order")
	public String admin_order() {
		logger.info("=== url -> admin_order ===");
		
		return "admin/admin_order";
	}
	
	
	// 상품관리 - 목록/검색/필터
	@RequestMapping("admin_product")
	public String admin_product(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product ===");
		service.adminProductList(request, response, model);
		return "admin/admin_product";
	}
	
	// 상품관리 - 선택 일괄 상태변경 (품절/활성/입고대기)
	@RequestMapping("admin_product_status")
	public String admin_product_status(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product_status ===");
		service.adminProductStatus(request, response, model);
		return "redirect:/admin_product";
	}
	
	// 상품관리 - 선택 일괄 삭제
	@RequestMapping("admin_product_delete")
	public String admin_product_delete(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product_delete ===");
		service.adminProductDelete(request, response, model);
		return "redirect:/admin_product";
	}
	
	// 상품관리 - 상품등록폼
	@RequestMapping("admin_product_insert")
	public String admin_product_insert(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product_insert ===");
		return "admin/admin_product_insert";
	}
	// 상품관리 - 상품등록처리
	@RequestMapping("admin_product_insertAction")
	public String admin_product_insertAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product_insertAction ===");
		service.adminProductInsert(request, response, model);
		return "redirect:/admin_product";
	}
	// 상품관리 - 상품수정폼
	@RequestMapping("admin_product_update")
	public String admin_product_update(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product_update ===");
		service.adminProductUpdateForm(request, response, model);
		return "admin/admin_product_update";
	}
	// 상품관리 - 상품수정처리
	@RequestMapping("admin_product_updateAction")
	public String admin_product_updateAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_product_insertAction ===");
		service.adminProductUpdate(request, response, model);
		return "redirect:/admin_product";
	}
	
	@RequestMapping("admin_qna")
	public String admin_qna() {
		logger.info("=== url -> admin_qna ===");
		
		return "admin/admin_qna";
	}
	
	@RequestMapping("admin_review")
	public String admin_review() {
		logger.info("=== url -> admin_review ===");
		
		return "admin/admin_review";
	}
	
	// 회원목록
	@RequestMapping("admin_user")
	public String admin_user(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("=== url -> admin_user ===");
		
		service.adminUser(request, response, model);
		service.adminUserPet(request, response, model);
		return "admin/admin_user";
	}
}
