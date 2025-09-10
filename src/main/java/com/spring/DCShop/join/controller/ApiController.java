package com.spring.DCShop.join.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.DCShop.join.service.EmailValidationService;

@RestController
public class ApiController {

	private static final Logger logger = LoggerFactory.getLogger(ApiController.class);

	@Autowired
	private EmailValidationService service;

	@RequestMapping(value = "/sendCode.do", produces = "application/json; charset=UTF-8")
	public Map<String, Object> sendCode(HttpServletRequest request) 
			throws ServletException, IOException {
		// 결과를 보내기 위한 Map
		Map<String, Object> res = new HashMap<String, Object>();
		
		logger.info("ApiController = > sendCode()");
		String result = service.sendValidationCode(request);
		System.out.println("결과" + result);
		if(result.equals("1")) {
			System.out.println("들어옴");
			res.put("ok", false);
			res.put("duplicate", "duplicate");
			
			return res;
		}
		
		Object expAttr = request.getSession().getAttribute("EMAIL_CODE_EXPIRE");
		Long expireAt = (expAttr instanceof Long) ? (Long) expAttr : null;

		long now = System.currentTimeMillis();
		long ttlSec = (expireAt != null) ? Math.max(0, (expireAt - now) / 1000) : 0;

		
		res.put("ok", true);
		res.put("ttlSec", ttlSec);

		return res;
	}

	@RequestMapping(value = "/verify.do", produces = "application/json; charset=UTF-8")
	public Map<String, Object> verify(HttpServletRequest request)
			throws ServletException, IOException {
		Map<String, Object> res = service.verifyCode(request);

		return res;
	}

}
