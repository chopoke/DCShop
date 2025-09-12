package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.shop.dto.WishDTO;

@Repository
public class WishDAOImpl implements WishDAO{

	
	@Autowired
	private SqlSession sqlSession;
	
	
	// 찜 목록 불러오기
	@Override
	public List<WishDTO> getWishList(Integer u_member_id) {
		List<WishDTO> list = sqlSession.selectList("com.spring.DCShop.shop.dao.WishDAO.getWishList", u_member_id);
		return list;
	}

	// 찜 여부
	@Override
	public int isWish(Map<String, Object> map) {
		int iswish = sqlSession.selectOne("com.spring.DCShop.shop.dao.WishDAO.isWish", map);
		return iswish;
	}
	
	// 상품당 찜 갯수
	@Override
	public int pdWishCount(int pd_id) {
		int result = sqlSession.selectOne("com.spring.DCShop.shop.dao.WishDAO.pdWishCount", pd_id);
		return result;
	}

	// 찜 추가
	@Override
	public int addWish(Map<String, Object> map) {
		int addcnt = sqlSession.insert("com.spring.DCShop.shop.dao.WishDAO.addWish", map);
		return addcnt;
	}
	
	// 찜 삭제
	@Override
	public int removeWish(Map<String, Object> map) {
		int removecnt = sqlSession.delete("com.spring.DCShop.shop.dao.WishDAO.removeWish", map);
		return removecnt;
	}



}
