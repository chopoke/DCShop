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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.DCShop.shop.dto.ProductDTO;
import com.spring.DCShop.shop.service.ProductService;
import com.spring.DCShop.shop.service.ReviewServiceImpl;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewServiceImpl service;
	
	// [특정리뷰 목록]
	@RequestMapping("/review_list.bc")
	public String review_list(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<< url => review_list.bc >>>");
		
		return service.reviewListAction(request, response, model);
	}
	
	// [리뷰 상세페이지]
	@RequestMapping("/review_detailAction.bc")
	public String review_detailAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<< url => review_detailAction.bc >>>");
		
		service.reviewDetailAction(request, response, model);
		
		// 서비스가 이미 응답을 보냈다면 더 이상 뷰를 리턴하면 안 되므로 null 반환(중복 렌더링 방지)
	    if (response.isCommitted()) {
	        return null; 
	    }
	    
		return "shop/review_detailAction";
	}
	
	// [리뷰 수정삭제 버튼] 클릭시 - 아이디, 리뷰번호 인증처리(로그인했으면 sessionId가 생겼을거니까) 
	@RequestMapping("/review_chkAction.bc")
	public String review_chkAction(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes)
		throws ServletException, IOException{
		logger.info("<<< url => review_chkAction.bc >>>");
		
		// 서비스에서 인증/권한 체크 결과를 받음
		int result = service.review_chkAction(request, response, model); // 1 = 통과 | 2 = 실패
		
		// r_num 파라미터(이름 혼용 대비)
	    String p = request.getParameter("hidden_r_num");
	    if (p == null || p.isBlank()) p = request.getParameter("r_num");
	    int r_num = (p != null && p.matches("\\d+")) ? Integer.parseInt(p) : 0;

	    // RedirectAttributes: 리다이렉트 시 쿼리스트링으로 붙여줌
	    // 통과면: r_num + ra.addAttribute("edit","1") 붙여서 상세로 리다이렉트
	    // 실패면: message=error 달아서 상세로 리다이렉트
	    if (result != 0) {
	        redirectAttributes.addAttribute("r_num", r_num);
	        redirectAttributes.addAttribute("edit", "1"); 
	        return "redirect:/review_detailAction.bc";
	    } else {
	        redirectAttributes.addAttribute("r_num", r_num);
	        redirectAttributes.addAttribute("message", "error");
	        return "redirect:/review_detailAction.bc";
	    }
	}
	
	// 리뷰 수정 폼 열기 (GET)
	@RequestMapping("/review_editForm.bc")
	public String review_editForm(HttpServletRequest request, HttpServletResponse response, Model model)
	        throws ServletException, IOException {
	    service.reviewEditForm(request, response, model); 
	    return "shop/review_edit"; 
	}
	
	// [리뷰 수정처리]
	@RequestMapping("/review_updateAction.bc")
	public String review_updateAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<< url => review_updateAction.bc >>>");
		
		service.reviewUpdateAction(request, response, model);
		String rnum = request.getParameter("r_num");
	    return "redirect:/review_detailAction.bc?r_num=" + rnum;
	}
	
	// [리뷰 삭제처리]
	@RequestMapping("/review_deleteAction.bc")
	public String review_deleteAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<< url => review_deleteAction.bc >>>");
		
		
		service.reviewDeleteAction(request, response, model);
		return "redirect:/review_list.bc";
	}
	
	// [리뷰 작성화면]
	@RequestMapping("/review_insert.bc")
	public String review_insert(HttpServletRequest request, HttpServletResponse response, Model model)
	        throws ServletException, IOException {
	    logger.info("<<< url => review_insert.bc >>>");

	    return service.reviewInsertForm(request, response, model);
	}

	
	// [리뷰 작성처리]
	@RequestMapping("/review_insertAction.bc")
	public String review_insertAction(HttpServletRequest request, HttpServletResponse response, Model model)
		throws ServletException, IOException{
		logger.info("<<< url => review_insertAction.bc >>>");
		

		return service.reviewInsertAction(request, response, model);
		
	}

}
