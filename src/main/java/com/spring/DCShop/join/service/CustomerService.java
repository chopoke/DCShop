package com.spring.DCShop.join.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface CustomerService {
	
	//약관 동의
	public void totalAgreement(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException;
	
	
}
