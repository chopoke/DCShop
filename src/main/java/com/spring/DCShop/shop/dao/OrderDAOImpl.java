package com.spring.DCShop.shop.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.shop.dto.OrderDTO;
import com.spring.DCShop.user.dto.UserDTO;

@Repository
public class OrderDAOImpl implements OrderDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	// 결제자 정보
	public UserDTO orderUserAction(int u_member_id) {
		System.out.println("DAO - orderUserAction()");
		
		UserDTO dto = sqlSession.selectOne("com.spring.DCShop.shop.dao.OrderDAO.orderUserAction", u_member_id);
		
		return dto;
	}

	// 결제내역 저장
	public void orderInsertAction(OrderDTO dto) {
		System.out.println("DAO - orderInsertAction()");
		
		sqlSession.insert("com.spring.DCShop.shop.dao.OrderDAO.orderInsertAction", dto);
	}
	
	// 재고수량 업데이트
	public void productStockUpdate(Map<String, Object> map) {
		System.out.println("DAO - productStockUpdate()");
		
		sqlSession.update("com.spring.DCShop.shop.dao.OrderDAO.productStockUpdate", map);
	}
	
	// 장바구니 체크
	public int cartCheck(int u_member_id) {
		System.out.println("DAO - cartCheck()");
		
		int selectCnt = sqlSession.selectOne("com.spring.DCShop.shop.dao.OrderDAO.cartCheck", u_member_id);
		
		return selectCnt;
	}
	
	// 장바구니 삭제
	public void cartDelete(Map<String, Object> map) {
		System.out.println("DAO - cartDelete()");
		
		sqlSession.delete("com.spring.DCShop.shop.dao.OrderDAO.cartDelete", map);
	}
}
