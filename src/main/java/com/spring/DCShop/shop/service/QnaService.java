package com.spring.DCShop.shop.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.spring.DCShop.shop.dto.QuestDTO;

public interface QnaService {
	//[문의 작성 처리]
	public void addQuestion(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	//[문의 목록]
	public void questListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	public QuestDTO qnaDetail(int q_num);
}
