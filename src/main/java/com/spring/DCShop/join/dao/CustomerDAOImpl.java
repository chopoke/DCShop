package com.spring.DCShop.join.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.join.dto.CustomerDTO;

@Repository
public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 회원가입 처리
	 */
	@Override
	public int insertCustomer(CustomerDTO dto) {

		int insertCnt = 0;

		System.out.println("CustomerDAOImpl - insertCustomer()");

		insertCnt = sqlSession.insert("com.spring.DCShop.join.dao.CustomerDAO.insertCustomer", dto);

		return insertCnt;

	}
	/**
	 * 아이디 체크
	 */
	@Override
	public int useridCheck(String strId) {
		System.out.println("CustomerDAOImpl - useridCheck()");

		int selectCnt = sqlSession.selectOne("com.spring.DCShop.join.dao.CustomerDAO.useridCheck", strId);

		return selectCnt;
	}
	/**
	 * 닉네임 체크
	 */
	@Override
	public int userNickNameCheck(String strNickName) {
		System.out.println("CustomerDAOImpl - userNickNameCheck()");

		int selectCnt = sqlSession.selectOne("com.spring.DCShop.join.dao.CustomerDAO.userNickNameCheck", strNickName);

		return selectCnt;
	}
	
	/**
	 * 이메일 존재 여부
	 */
	@Override
	public int userEmailCheck(String strEmail) {
		System.out.println("CustomerDAOImpl - userEmailCheck()");

		int selectCnt = sqlSession.selectOne("com.spring.DCShop.join.dao.CustomerDAO.userEmailCheck", strEmail);

		return selectCnt;
	}

}
