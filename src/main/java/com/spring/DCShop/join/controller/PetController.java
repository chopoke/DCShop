package com.spring.DCShop.join.controller;

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

import com.spring.DCShop.join.service.CustomerService;
import com.spring.DCShop.join.service.PetService;

@Controller
public class PetController {
	
	@Autowired
	private PetService pService;
	
	@Autowired
	private CustomerService custService;
	
	private static final Logger logger = LoggerFactory.getLogger(PetController.class);
	
	
	@RequestMapping("/insertPet.do")
	public String insertPet(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException{
		logger.info("PetController - insertPet.do");

		custService.signInAction(request, response, model);
		
		return "pet/insert";
	}
	
	@RequestMapping("/insertAction.do")
	public String insertAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		logger.info("PetController - insertAction.do");
		
		boolean ok = pService.insertAction(request, response, model);
	    model.addAttribute("joinSuccess", ok);
		return "pet/insertAction";
	}

}
