package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;
import com.spring.DCShop.shop.dto.QuestDTO;

public interface MypageDAO {
	
	public List<OrderDTO> getOrderList(Map<String, Object> productListInfo);
	
	public List<CartDTO> getCartList(Map<String, Object> productListInfo);
	
	
	
	// mypage 문의목록 - 갯수
	public int myQnaCnt(Map<String, Object> map);
	
	// mypage 문의목록 - 리스트 
	public List<QuestDTO> myQnaList(Map<String, Object> param);
	
}
