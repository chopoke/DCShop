package com.spring.DCShop.shop.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.border.EmptyBorder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.DCShop.shop.dto.QuestDTO;
import com.spring.DCShop.shop.service.QnaService;


@Controller
public class QnaController {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired
	private QnaService service;
	
	//[문의 작성 처리]
	@RequestMapping("/question_insert.qa")
	public String comment_insert(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("<<< url ==> /question_insert.qa >>>");
		
		service.addQuestion(request, response, model);
		
		return null;
	}
	
	//[문의 목록]
	@RequestMapping("/quest_list.qa")
	public String quest_list(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("<<< url ==> /quest_list.qa >>>");
		
		service.questListAction(request, response, model);
		
		return "shop/quest_list";
	}
	
}

