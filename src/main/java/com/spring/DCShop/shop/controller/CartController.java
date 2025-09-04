package com.spring.DCShop.shop.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.DCShop.shop.dto.CartDTO;
import com.spring.DCShop.shop.dto.CartItemRequest;
import com.spring.DCShop.shop.dto.CheckoutRequest;
import com.spring.DCShop.shop.service.CartService;


@Controller
public class CartController {

	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService cartservice;
	
	/**
	 * 
	 * @purpose 장바구니에 추가하기
	 * 
	*/
	@RequestMapping("/cart.do")
	public String cart(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> cart ===");
		
		String sessionid = (String)request.getSession().getAttribute("sessionid");
		
		if(sessionid == null) {
			return "user/login/login_main";
		}
		cartservice.addProductList(request, response, model);
		return "redirect:/cartListShow.do";
	}
	
	/**
	 * 
	 * @purpose 장바구니 리스트로 가기
	 * 
	*/
	@RequestMapping("/cartListShow.do")
	public String cartListShow(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> cartListShow ===");
		
		
		
		return "redirect:/cartgo.do";
	}
	
	@RequestMapping("/cartgo.do")
	public String cartgo(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> cart ===");
		
		cartservice.getProductList(request, response, model);
		
		return "shop/cart";
	}
	
	@RequestMapping("/incQty.do")
	@ResponseBody
	public Map<String, Object> incQty(@RequestBody Map<String, Object> map, HttpServletRequest request) {
		logger.info("=== url -> incQty ===");
		
		int qty = cartservice.increaseProductCount(request, map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", "ok");
		resultMap.put("qty", qty);
		
		return resultMap;
	}
	
	@RequestMapping("/dicQty.do")
	@ResponseBody
	public Map<String, Object> dicQty(@RequestBody Map<String, Object> map, HttpServletRequest request) {
		logger.info("=== url -> dicQty ===");
		
		int qty = cartservice.dicreaseProductCount(request, map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", "ok");
		resultMap.put("qty", qty);
		
		return resultMap;
	}
	
	@RequestMapping("/decQty.do")
	@ResponseBody
	public Map<String, Object> decQty(@RequestBody Map<String, Object> map, HttpServletRequest request) {
		logger.info("=== url -> decQty ===");
		
		int qty = cartservice.deleteProductFromCart(request, map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", "ok");
		resultMap.put("qty", qty);
		
		return resultMap;
	}
	
	@RequestMapping(value="/onCQty.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> onCQty(@RequestBody Map<String, Object> map, HttpServletRequest request) {
		logger.info("=== url -> onCQty ===");
		
		int qty = cartservice.changeProductFromCart(request, map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", "ok");
		resultMap.put("qty", qty);
		
		return resultMap;
	}
	
	@RequestMapping(value="/payQty.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> payQty(@RequestBody MultiValueMap<String, String> body, HttpServletRequest request) throws JsonMappingException, JsonProcessingException {
		logger.info("=== url -> payQty ===");
		ObjectMapper om = new ObjectMapper();
		String payload = body.getFirst("_payload");
		String fixed = new String(payload.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
		CheckoutRequest req = om.readValue(fixed, CheckoutRequest.class);
		
		System.out.println(req.getTotalClient()); // 토탈 가격
		List<CartItemRequest> item = req.getItems();
		
		for(int i = 0; i < item.size(); i++) {
			System.out.println(item.get(i).getPdName());
			System.out.println(item.get(i).getPdPrice()); // 가격
			System.out.println(item.get(i).getPdId()); // 상품 번호
			System.out.println(item.get(i).getQty()); // 갯수
		}
		
		
		return null;
	}
}
