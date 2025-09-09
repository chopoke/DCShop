package com.spring.DCShop.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface MainlistService {
	public void getlist(HttpServletRequest request, HttpServletResponse response, Model model);
}
