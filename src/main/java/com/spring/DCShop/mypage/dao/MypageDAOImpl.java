package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.user.dto.UserDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;


@Repository
public class MypageDAOImpl implements MypageDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<UserDTO> mypageAdminUserList1() {
		System.out.println("MypageDAOImpl - mypageAdminUserList1()");
		List<UserDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.mypageAdminUserList1");
		return list;
	}

	@Override
	public List<BoardDTO> adminBoardList(Map<String, Object> param) {
		System.out.println("MypageDAOImpl - adminBoardList()");
		List<BoardDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.adminBoardList", param);
		return list;
	}

	@Override
	public int adminBoardCount(Map<String, Object> param) {
		System.out.println("MypageDAOImpl - adminBoardCount()");
		int countCnt = sqlSession.selectOne("com.spring.DCShop.mypage.dao.MypageDAO.adminBoardCount", param);
		return countCnt;
	}
		
	public List<OrderDTO> getOrderList(Map<String, Object> productListInfo) {
		
		System.out.println("MypageDAOImpl => getCartList");
		
		List<OrderDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.getOrderList", productListInfo);
		
		System.out.println(list);
		
		return list;
		
	}
	
}
