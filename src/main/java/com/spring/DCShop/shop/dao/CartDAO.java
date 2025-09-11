package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.shop.dto.CartDTO;
import com.spring.DCShop.shop.dto.UserDTO;


public interface CartDAO {

	public int upsertCart(CartDTO dto);
	
	public UserDTO getUserInfo(String sessiongId);

	public List<CartDTO> getProductList(String uMemberId);

	public int increaseProductCount(Map<String, Object> increaseInfo);

	public int dicreaseProductCount(Map<String, Object> increaseInfo);
	
	public CartDTO getProductCount(Map<String, Object> increaseInfo);
	
	public int deleteProductFromCart(Map<String, Object> increaseInfo);
	
	public int deleteProductsFromCart(Map<String, Object> increaseInfo);
	
	public int changeProductFromCart(Map<String, Object> deleteInfo);
}
