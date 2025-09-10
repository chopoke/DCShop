package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.shop.dto.ShopDTO;

public interface ShopDAO {
	
	// 상품 목록 조회
	public List<ShopDTO> productListAction(Map<String, Object> map);
	
	// 상품 갯수
	public int productCnt(Map<String, Object> countP);
	
	// 세부 카테고리 가져오기
	public List<Integer> getSubcategory(int category);
	
	// 카테고리 갯수
	public List<Map<String, Object>> getCateCnt();
}
