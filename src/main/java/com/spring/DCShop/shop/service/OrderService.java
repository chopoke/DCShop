package com.spring.DCShop.shop.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;

public interface OrderService {

	// 결제자 정보
	public void orderUserAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	// 결제내역 저장
	public void orderInsertAction(@RequestBody String jsonBody, JSONObject jsonObject, HttpServletRequest request) throws Exception;

}
