package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.shop.dto.WishDTO;

public interface WishDAO {
	
	// 찜 목록 불러오기
	public List<WishDTO> getWishList(Integer u_member_id);
	
	// 찜 여부
	public int isWish(Map<String, Object> map);

	// 상품당 찜 갯수
	public int pdWishCount(int pd_id);
	
	// 찜 추가
	public int addWish(Map<String, Object> map);
	
	// 찜 삭제
	public int removeWish(Map<String, Object> map);
	
}
