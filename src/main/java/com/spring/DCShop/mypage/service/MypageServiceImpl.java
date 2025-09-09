package com.spring.DCShop.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.mypage.dao.MypageDAO;
import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private MypageDAO myDao;
	
	private int productCountSum;
	private int productTotalPrice;
	
	private int cartCountSum;
	private int cartTotalPrice;
	
	public void getCartAndOrderList(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		System.out.println("MypageServiceImpl => getCartAndOrderList");
		
		// 공통 영역
		int session_u_member_id = (Integer)request.getSession().getAttribute("session_u_member_id");
		
		Map<String, Object> productListInfo = new HashMap<String, Object>();
		
		productListInfo.put("u_member_id", session_u_member_id);
		
		/** 주문내역 **/
		List<OrderDTO> orderList = myDao.getOrderList(productListInfo);
		
		productCountSum = 0;
		orderList.forEach(i -> {
			productCountSum += i.getO_Count();
		});

		productTotalPrice = 0;
		orderList.forEach(i -> {
			i.getProductDto().forEach(j -> {
				productTotalPrice += i.getO_Count() * j.getPdPrice();
			});
		});
		
		model.addAttribute("order", orderList);
		model.addAttribute("productCountSum", productCountSum);
		model.addAttribute("productTotalPrice", productTotalPrice);
		
		/** 장바구니 **/
		
		List<CartDTO> cartList = myDao.getCartList(productListInfo);

		System.out.println("cart" + cartList);
		
		cartCountSum = 0;
		cartList.forEach(i -> {
			cartCountSum += i.getCtQuantity();
		});

		cartTotalPrice = 0;
		cartList.forEach(i -> {
			i.getProductDto().forEach(j -> {
				cartTotalPrice += i.getCtQuantity() * j.getPdPrice();
			});
		});
		
		model.addAttribute("cart", cartList);
		model.addAttribute("cartCountSum", cartCountSum);
		model.addAttribute("cartTotalPrice", cartTotalPrice);
	}
	
}
