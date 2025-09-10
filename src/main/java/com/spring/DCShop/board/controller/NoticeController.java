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

	// 공지/이벤트 목록 (단일 카테고리 혹은 통합)
	@RequestMapping("notice_list")
	public String notice_list(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_list >>>");

		noticeService.noticeListAction(request, response, model);

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
	
	// 공지/이벤트 작성
	@RequestMapping("notice_insert")
	public String notice_insert(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_insert >>>");

		noticeService.selectU_nicknameAction(request, response, model);

		return "board/notice_insert";
	}
	
	// 공지/이벤트 등록
	@RequestMapping("notice_insertAction")
	public void notice_insertAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_insertAction >>>");

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

		noticeService.noticeUpdateDTOAction(request, response, model);

		return "board/notice_update";
	}
	
	// 공지/이벤트 수정 등록
	@RequestMapping("notice_updateAction")
	public void notice_updateAction(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_updateAction >>>");

		int b_num = noticeService.noticeUpdateAction(request, response, model);

		String viewPage = request.getContextPath() + "/notice_detail?b_num=" + b_num + "&listClick=0";
		response.sendRedirect(viewPage);
	}
	
	// 공지/이벤트 삭제
	@RequestMapping("notice_delete")
	public void notice_delete(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_delete >>>");

		noticeService.noticeDeleteAction(request, response, model);
		String viewPage = request.getContextPath() + "/notice_list?delete=success";
		response.sendRedirect(viewPage);
	}
	
	// 공지/이벤트 추천 클릭
	@RequestMapping("notice_recommend")
	@ResponseBody
	public Map<String, Object> notice_recommend_click(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => notice_recommend >>>");

		Map<String, Object> result = noticeService.noticeRecommendClickAction(request, response, model);

		return result;
	}
	
	// 통합 게시판 목록 (공지/이벤트/커뮤니티)
	@RequestMapping("unified_board_list")
	public String unified_board_list(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => unified_board_list >>>");

		noticeService.unifiedBoardListAction(request, response, model);

		return "board/unified_board_list";
	}
	
	// 카테고리별 게시판 목록
	@RequestMapping("category_board_list")
	public String category_board_list(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => category_board_list >>>");

		noticeService.categoryBoardListAction(request, response, model);

		return "board/category_board_list";
	}
}
