package com.spring.DCShop.shop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.DCShop.shop.service.ShopServiceImpl;
             
@Controller
public class ShopController {

	@Autowired
	private ShopServiceImpl service;
	
	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);
	
	@RequestMapping("shop_main.do")
	public String shop_main(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> shop_main ===");
		
		service.productListAction(request, response, model);
		
		return "shop/shop_main";
	}
	
	@RequestMapping("productList.do")
	public String productList(HttpServletRequest request, HttpServletResponse response, Model model) {
	    logger.info("=== url -> productList ===");
	    service.productListAction(request, response, model);
	    return "shop/productList"; 
	}
	
	@RequestMapping("eventproductList.do")
	public String eventproductList(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> eventproductList ===");
		return "shop/eventpage";
	}
}
