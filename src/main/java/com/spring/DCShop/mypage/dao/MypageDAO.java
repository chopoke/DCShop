package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.MyPetDTO;
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
	
	
	// 기존 펫정보 가져오기
	public List<MyPetDTO> getPetList(int u_member_id);
	
	// 동물정보 인서트
	public int petInfoInsert(MyPetDTO dto);
	
	
	// 동물정보 업데이트
	public int petInfoUpdate(MyPetDTO dto);
	
	// 동물 정보 삭제
	public int petInfoDelete(Map<String, Object> map);
	
}
