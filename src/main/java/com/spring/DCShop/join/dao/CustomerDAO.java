package com.spring.DCShop.join.dao;

import com.spring.DCShop.join.dto.CustomerDTO;

public interface CustomerDAO {

	/**
	 * @purpose 회원가입 처리
	 */
	public int insertCustomer(CustomerDTO dto);
	
	/**
	 * @purpose ID 중복확인 처리
	 */
	public int useridCheck(String strId);
	
	/**
	 * @purpose NickName 중복확인 처리
	 */
	public int userNickNameCheck(String strNickName);
	
	/**
	 * @purpose Email 중복확인 처리
	 */
	public int userEmailCheck(String strEmail);
}
