package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;

@Repository
public class MypageDAOImpl implements MypageDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<OrderDTO> getOrderList(Map<String, Object> productListInfo) {
		
		System.out.println("MypageDAOImpl => getOrderList");
		
		List<OrderDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.getOrderList", productListInfo);
		
		System.out.println("5:11" + list);
		
		return list;
		
	}

	@Override
	public List<CartDTO> getCartList(Map<String, Object> productListInfo) {

		System.out.println("MypageDAOImpl => getCartList");
		
		List<CartDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.getCartList", productListInfo);
		
		return list;
	}
	
}
