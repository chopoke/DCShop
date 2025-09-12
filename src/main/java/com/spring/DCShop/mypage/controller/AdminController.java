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
import com.spring.DCShop.shop.dto.QuestDTO;

@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminServiceImpl service;
	
	//관리자 마이페이지
	@RequestMapping("admin_main")
	public String admin_main(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("=== url -> admin_main ===");
		service.adminMain(request, response, model);
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
	
	// 주문관리 - 주문목록
	@RequestMapping("admin_order")
	public String admin_order(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_order ===");
		service.adminOrderList(request, response, model);
		return "admin/admin_order";
	}
	
	// 주문관리 - 주문상세
	@RequestMapping("admin_order_detail")
	public String admin_order_detail(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_order_detail ===");
		service.adminOrderDetail(request, response, model);
		return "admin/admin_order_detail";
	}
	
	// 주문관리 - 주문상태변경
	@RequestMapping("admin_order_status")
	public String admin_order_status(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_order_status ===");
		service.adminOrderStatus(request, response, model);
		return "redirect:/admin_order_detail";
	}
	
	// 주문관리 - 배송상태변경
	@RequestMapping("admin_order_delivery")
	public String admin_order_delivery(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_order_delivery ===");
		service.adminOrderDelivery(request, response, model);
		return "redirect:/admin_order_detail";
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
	
	// 문의 리스트
	@RequestMapping("admin_qna")
	public String admin_qna(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_qna ===");
		
		service.adminQnaList(request, response, model);
		
		return "admin/admin_qna";
	}
	
	// 답변페이지로 이동
	@RequestMapping("qna_answer")
	public String qna_answer(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_qna ===");
		
		QuestDTO dto = service.adminQnaDetail(request, response, model);
		
		model.addAttribute("dto", dto);
		
		return "admin/qna_answer";
	}
	
	//adminAnswer
	//답변 작성
	@RequestMapping("qna_answerSubmitAction")
	public String qna_answerAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_qna ===");
		
		service.answerSubmitAction(request, response, model);
		
		return "admin/admin_qna";
	}
		
	
	// 리뷰관리 - 목록/검색/필터
	@RequestMapping("admin_review")
	public String admin_review(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_review ===");
		
		service.adminReviewList(request, response, model);
		return "admin/admin_review";
	}
	
	// 리뷰관리 - 상세
	@RequestMapping("admin_review_detail")
	public String admin_review_detail(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_review_detail ===");
		
		service.adminReviewDetail(request, response, model);
		return "admin/admin_review_detail";
	}
		
	// 리뷰관리 - 선택 일괄 삭제
	@RequestMapping("admin_review_delete")
	public String admin_review_delete(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("=== url -> admin_review_delete ===");
		
		service.adminReviewDelete(request, response, model);
		return "redirect:/admin_review";
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
