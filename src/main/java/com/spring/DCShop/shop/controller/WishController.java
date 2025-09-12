package com.spring.DCShop.shop.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.DCShop.mypage.service.MypageServiceImpl;
import com.spring.DCShop.shop.service.WishServiceImpl;

@Controller
public class WishController {
	
	private static final Logger logger = LoggerFactory.getLogger(WishController.class);
	
	@Autowired
	private WishServiceImpl service;
	@Autowired
	private MypageServiceImpl myService;
	
	
	// 찜 목록 페이지
	@RequestMapping("wishList.do")
	public String wishList(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		
		HttpSession session = req.getSession(false);
	    if (session != null) {
	        String loginId = (String) session.getAttribute("sessionid");
	        if (loginId != null) {
	            myService.findById(loginId, model);
	        }
	    }
	    else {
	    	return "login_main.do";
	    }
        String loginId = (String) session.getAttribute("sessionid");
        myService.findById(loginId, model);
		
		service.getWishList(req, res, model);
		
		return "mypage/wishList";
	}
	
	// 찜 추가
	@RequestMapping("addWish.do")
	@ResponseBody
	public Map<String, Object> addWish(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		
		int addcnt = service.serAddWish(req, res, model);
		int pdId = Integer.parseInt(req.getParameter("pdId"));
		int cnt = service.getPdWishCount(pdId);		// 찜 갯수 바로 반응
		Map<String, Object> out = new HashMap<>();
	    out.put("success", addcnt);   // 1 or 0
	    out.put("wishCnt", cnt);  
		return out;
	}
	
}
