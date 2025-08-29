package com.spring.DCShop.mypage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
		
	//@Autowired
	
	@RequestMapping("mypage_main.do")
	public String mypage_main() {
		logger.info("=== url -> mypage_main ===");
		
		return "/mypage/mypage_main";
	}
	
	@RequestMapping("admin_main.do")
	public String admin_main() {
		logger.info("=== url -> mypage_main ===");
		
		return "/admin/admin_main";
	}
}
