package com.spring.DCShop.shop.controller;

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

import com.spring.DCShop.mypage.service.MypageService;
import com.spring.DCShop.shop.dto.QuestDTO;
import com.spring.DCShop.shop.service.QnaService;


@Controller
public class QnaController {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired
	private QnaService service;
	
	@Autowired
	private MypageService my;
	
	//[문의 작성 처리]
	@RequestMapping("/question_insert.qa")
	public String quest_insert(HttpServletRequest request, HttpServletResponse response, Model model) 
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
	
	//[문의 업데이트 페이지]
	@RequestMapping("/question_update.qa")
	public String quest_update(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("<<< url ==> /question_update.qa >>>");
		
		
		String sessionid = (String)request.getSession().getAttribute("sessionid");
		int q_num = Integer.parseInt(request.getParameter("q_num"));
		logger.info("q_num"+q_num);
		
		QuestDTO dto = service.qnaDetail(q_num);
		
		if(dto.getU_member_id() != (Integer)request.getSession().getAttribute("session_u_member_id")) {
			return "redirect:/";	//글 작성자 본인이 아니라면 페이지 접근 불가.
		}
		
		my.findById(sessionid, model);
		model.addAttribute("qna", dto);
		
		return "shop/question_update";
	}
	
	//[문의 업데이트 처리]
	@RequestMapping("/question_updateAction.qa")
	public String quest_updateAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("<<< url ==> /question_updateAction.qa >>>");

		service.updateQuestion(request, response, model);
		
		return null;
	}
	
	@RequestMapping("/question_deleteAction.qa")
	public String quest_deleteAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("<<< url ==> /question_deleteAction.qa >>>");

		service.deleteQuest(request, response, model);
		
		return null;
	}
	
	@RequestMapping("/question_detailAction.qa")
	public String question_detailAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException {
		logger.info("<<< url ==> /question_detailAction.qa >>>");
		
		// 상세페이지를 요청한 사람의 권한, 또는 아이디 체크를 위한 데이터
		String u_role = (String)request.getSession().getAttribute("session_u_role");
		Integer id = (Integer)request.getSession().getAttribute("session_u_member_id");
		
		String sessionid = (String)request.getSession().getAttribute("sessionid");
		my.findById(sessionid, model);
		
		// 상세페이지에 띄울 데이터 요청
		int q_num = Integer.parseInt(request.getParameter("q_num"));
		QuestDTO dto = service.qnaDetail(q_num);
		if(u_role != null || id != null || ("ADMIN".equals(u_role) && "ADMIN" == u_role && dto.getU_member_id() == id)) {
			model.addAttribute("qna", dto);
			return "mypage/qna_detail";
		}
		return "redirect:/";
	}
}

