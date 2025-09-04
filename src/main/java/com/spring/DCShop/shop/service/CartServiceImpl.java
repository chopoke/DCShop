package com.spring.DCShop.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.shop.dao.CartDAO;
import com.spring.DCShop.shop.dto.CartDTO;
import com.spring.DCShop.shop.dto.UserDTO;


@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDAO cartdao;

	@Override
	public void addProductList(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("CartServiceImpl => addProductList");
		
		int uMemberId = (Integer) request.getSession().getAttribute("session_u_member_id");
		
		System.out.println(request.getParameter("pdId"));
		
		int pdId = Integer.parseInt(request.getParameter("pdId"));
		int qty = Integer.parseInt(request.getParameter("qty"));

		CartDTO dto = new CartDTO();
		dto.setuMemberId(uMemberId);
		dto.setPdId(pdId);
		dto.setCtQuantity(qty);
		
		cartdao.upsertCart(dto);
	}
	
	@Override
	public void getProductList(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("CartServiceImpl => getProductList");

		// 세션 아이디 가져오기
		String sessionID = (String) request.getSession().getAttribute("sessionid");
		
		UserDTO userInfo = cartdao.getUserInfo(sessionID);
		
		// 로그인한 유저의 세션 정보
		int uMemberId = (Integer) request.getSession().getAttribute("session_u_member_id");
		
		List<CartDTO> productList = cartdao.getProductList(Integer.toString(uMemberId));

		System.out.println(productList);
		
		model.addAttribute("user", userInfo);
		model.addAttribute("cart", productList);
		
	}

	@Override
	public int increaseProductCount(HttpServletRequest request, Map<String, Object> map) {
		System.out.println("CartServiceImpl => increaseProductCount");
		
		// 세션 아이디 가져오기
		int uMemberId = (Integer) request.getSession().getAttribute("session_u_member_id");

		// 상품 아이디 가져오기
		String pdId = map.get("pdId").toString();
		
		Map<String, Object> increaseInfo = new HashMap<String, Object>();

		increaseInfo.put("uMemberId", uMemberId);
		increaseInfo.put("pdId", pdId);
		
		System.out.println(increaseInfo);

		// 상품 구입 갯수 증가[성공이면 1이상, 실패이면, 0]
		int upResult = cartdao.increaseProductCount(increaseInfo);
		int qty = 0;
		if(upResult > 0) {
			// 상품 구입 갯수 가져오기
			CartDTO cartdto = cartdao.getProductCount(increaseInfo);
			qty  = cartdto.getCtQuantity();
		}
		return qty;

	}

	@Override
	public int dicreaseProductCount(HttpServletRequest request, Map<String, Object> map) {
		System.out.println("CartServiceImpl => dicreaseProductCount");
		
		// 세션 아이디 가져오기
		int uMemberId = (Integer) request.getSession().getAttribute("session_u_member_id");

		// 상품 아이디 가져오기
		String pdId = map.get("pdId").toString();
		
		Map<String, Object> dicreaseInfo = new HashMap<String, Object>();

		dicreaseInfo.put("uMemberId", uMemberId);
		dicreaseInfo.put("pdId", pdId);

		// 상품 구입 갯수 감소
		int upResult = cartdao.dicreaseProductCount(dicreaseInfo);
		int qty = 0;
		// 상품 구입 갯수 가져오기
		CartDTO cartdto = cartdao.getProductCount(dicreaseInfo);
		if(upResult > 0) {
			qty  = cartdto.getCtQuantity();
		}
		return qty;
		
	}

	@Override
	public int deleteProductFromCart(HttpServletRequest request, Map<String, Object> map) {
		System.out.println("CartServiceImpl => deleteProductFromCart");
		
		// 세션 아이디 가져오기
		int uMemberId = (Integer) request.getSession().getAttribute("session_u_member_id");

		// 상품 아이디 가져오기
		String pdId = map.get("pdId").toString();
		
		Map<String, Object> deleteInfo = new HashMap<String, Object>();

		deleteInfo.put("uMemberId", uMemberId);
		deleteInfo.put("pdId", pdId);
		
		int deleteResult = cartdao.deleteProductFromCart(deleteInfo);
		return deleteResult;
	}
	
	@Override
	public int changeProductFromCart(HttpServletRequest request, Map<String, Object> map) {
		System.out.println("CartServiceImpl => deleteProductFromCart");
		
		// 세션 아이디 가져오기
		int uMemberId = (Integer) request.getSession().getAttribute("session_u_member_id");

		// 상품 아이디 가져오기
		String pdId = map.get("pdId").toString();
		
		String qty = map.get("qty").toString();
		
		Map<String, Object> changeInfo = new HashMap<String, Object>();

		changeInfo.put("uMemberId", uMemberId);
		changeInfo.put("pdId", pdId);
		changeInfo.put("qty", qty);
		
		int changeResult = cartdao.changeProductFromCart(changeInfo);
		return changeResult;
	}

}
