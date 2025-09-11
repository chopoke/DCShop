package com.spring.DCShop.board.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.board.service.NoticeServiceImpl;

@Controller
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	NoticeServiceImpl noticeService;

	// 공지/이벤트 목록 조회
	@RequestMapping("notice_list")
	public String notice_list(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_list >>>");
		// 1. Service 호출 → DB에서 목록 가져오기
		noticeService.noticeListAction(request, response, model);
		// 2. 결과를 담아 View 페이지로 이동
		return "board/notice_list";
	}
	
	// 공지/이벤트 상세페이지
	@RequestMapping("notice_detail")
	public String notice_detail(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_detail >>>");

		noticeService.noticeDetailAction(request, response, model);

		return "board/notice_detail";
	}
	
	// 공지/이벤트 작성페이지 이동
	@RequestMapping("notice_insert")
	public String notice_insert(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_insert >>>");

		// 1. Service 호출 → 특정 게시글 상세정보 조회
		noticeService.selectU_nicknameAction(request, response, model);
		// 2. 결과를 담아 상세보기 페이지로 이동
		return "board/notice_insert";
	}
	
	// 공지/이벤트 등록
	@RequestMapping("notice_insertAction")
	public void notice_insertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_insertAction >>>");
		// 1. Service 호출 → 새 게시글 등록 후 생성된 글번호(b_num) 반환
		int b_num = noticeService.noticeInsertAction(request, response, model);

		// 등록 후 상세페이지로 이동 (board와 동일 흐름)
		String viewPage = request.getContextPath() + "/notice_detail?b_num=" + b_num + "&listClick=0";
		response.sendRedirect(viewPage);
	}
	
	// 공지/이벤트 수정 페이지 이동
	@RequestMapping("notice_update")
	public String notice_update(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_update >>>");
		// 1. Service 호출 → 수정할 데이터 조회
		noticeService.noticeUpdateDTOAction(request, response, model);
		
		return "board/notice_update";
	}
	
	// 공지/이벤트 수정 등록
	@RequestMapping("notice_updateAction")
	public void notice_updateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_updateAction >>>");
		// 1. Service 호출 → 게시글 수정 후 글번호 반환
		int b_num = noticeService.noticeUpdateAction(request, response, model);
		// 2. 수정 후 해당 글 상세보기로 redirect
		String viewPage = request.getContextPath() + "/notice_detail?b_num=" + b_num + "&listClick=0";
		response.sendRedirect(viewPage);
	}
	
	// 공지/이벤트 삭제(admin 전용)
	@RequestMapping("notice_delete")
	public void notice_delete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_delete >>>");
		
		String sessionid = (String) request.getSession().getAttribute("sessionid");
		// 1. Service 호출 → 삭제 실행
	    noticeService.noticeDeleteAction(request, response, model);
	 // 2. 삭제 완료 후 목록으로 redirect (쿼리파라미터로 성공여부 전달)
		String viewPage = request.getContextPath() + "/notice_list?delete=success";
		response.sendRedirect(viewPage);
	}
	
	// 공지/이벤트 추천 클릭
	@RequestMapping("notice_recommend")
	@ResponseBody
	public Map<String, Object> notice_recommend_click(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_recommend >>>");
		// 1. Service 호출 → 추천수 증가 및 결과 반환
		Map<String, Object> result = noticeService.noticeRecommendClickAction(request, response, model);
		// 2. JSON 형태로 응답 반환
		return result;
	}

	
}
