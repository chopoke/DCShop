package com.spring.DCShop.shop.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;

import com.spring.DCShop.shop.dto.DeleteReq;

public interface CartService {

	public void addProductList(HttpServletRequest request, HttpServletResponse response, Model model);
	
	public void addProductListForGoPay(HttpServletRequest request, HttpServletResponse response, Model model);
	
	public void getProductList(HttpServletRequest request, HttpServletResponse response, Model model);
	
	public int increaseProductCount(HttpServletRequest request, Map<String, Object> map);
	
	public int dicreaseProductCount(HttpServletRequest request, Map<String, Object> map);
	
	public int deleteProductsFromCart(HttpServletRequest request, DeleteReq req);
	
	public int deleteProductFromCart(HttpServletRequest request, Map<String, Object> deleteInfo);
	
	public int changeProductFromCart(HttpServletRequest request, Map<String, Object> map);
}
