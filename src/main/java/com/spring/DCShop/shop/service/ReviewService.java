package com.spring.DCShop.shop.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;


@Service
public interface ReviewService {
	
	// 리뷰 목록
	public String reviewListAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 리뷰 상세 화면
	public void reviewDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// [리뷰 수정삭제 버튼] 클릭시 - 회원번호 인증처리
	public int review_chkAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 리뷰 수정 화면
	public void reviewEditForm(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException; 
	
	// 리뷰 수정처리
	public void reviewUpdateAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 리뷰 삭제 처리
	public void reviewDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
	
	// 리뷰 작성 화면
	public String reviewInsertForm(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 리뷰 작성 처리
	public String reviewInsertAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException;
}
