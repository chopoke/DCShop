package com.spring.DCShop.join.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface EmailValidationService {

	/** 코드 발송 후 세션에 저장, 반환값은 발송된 코드(테스트용). */
	public void sendValidationCode(HttpServletRequest request);

	/** 입력 코드 검증(true면 성공). */
	public Map<String, Object> verifyCode(HttpServletRequest request);
}
