package com.spring.DCShop.notice.service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface NoticeService {
	
	// 공지 목록
	public void noticeListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, java.io.IOException;
	
	// 공지 상세페이지
	public void noticeDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, java.io.IOException;
	
	// 공지 등록
	public int noticeInsertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, java.io.IOException;
	
	// 공지 수정 정보
	public void noticeUpdateDTOAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, java.io.IOException;
	
	// 공지 수정 등록
	public int noticeUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, java.io.IOException;
	
	// 공지 삭제
	public void noticeDeleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, java.io.IOException;
}
