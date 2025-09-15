package com.spring.DCShop.mypage.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.spring.DCShop.shop.dto.QuestDTO;

public interface AdminService {
	
	// 관리자메인
	public void adminMain(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 게시판관리 - 게시판목록
	public void adminBoardList(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 게시판관리 - 게시판 선택 삭제
	public void adminBoardDelete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 상품관리 - 목록/검색/필터
	public void adminProductList(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 상품관리 - 선택 일괄 상태변경 (품절/활성/입고대기)
	public void adminProductStatus(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
	// 상품관리 - 선택 일괄 삭제
	public void adminProductDelete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
	// 상품관리 - 상품등록처리
	public void adminProductInsert(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;

	// 상품관리 - 상품수정폼
	public void adminProductUpdateForm(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
	// 상품관리 - 상품수정처리
	public void adminProductUpdate(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 문의관리 - 문의 리스트
	public void adminQnaList(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// qna 답변 페이지
	public QuestDTO adminQnaDetail(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException;
	
	public void answerSubmitAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException;
	// 주문관리 - 목록
	public void adminOrderList(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 주문관리 - 상세
	public void adminOrderDetail(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 주문관리 - 주문상태변경
	public void adminOrderStatus(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 주문관리 - 배송상태변경
	public void adminOrderDelivery(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 리뷰관리 - 목록/검색/필터
	public void adminReviewList(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 리뷰관리 - 상세
	public void adminReviewDetail(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 리뷰관리 - 선택 일괄 삭제
	public void adminReviewDelete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 회원관리 - 회원목록-가입자5건조회
	public void adminUser(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 회원관리 - 펫통계
	public void adminUserPet(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
	// 회원관리 - 회원목록-탈퇴자5건조회
	public void adminUserDelete(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
		
}


