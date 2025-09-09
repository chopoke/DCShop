package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.MypageDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;

public interface MypageDAO {
	
	public List<OrderDTO> getOrderList(Map<String, Object> productListInfo);
	
	public List<CartDTO> getCartList(Map<String, Object> productListInfo);
	
	public int pwdcheck(Map<String, Object> map);
	
	public MypageDTO getUserInfo(String loginId);
	
	// 수정된 유저 정보 
	public int setUserInfo(Map<String, Object> map);
	
	// 프로필 수정
	public int profileupdate(Map<String, Object> map);
	
}
