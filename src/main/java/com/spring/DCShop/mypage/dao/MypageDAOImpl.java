package com.spring.DCShop.mypage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.MyPetDTO;
import com.spring.DCShop.mypage.dto.MypageDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;

@Repository
public class MypageDAOImpl implements MypageDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<OrderDTO> getOrderList(Map<String, Object> productListInfo) {
		
		System.out.println("MypageDAOImpl => getOrderList");
		
		List<OrderDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.getOrderList", productListInfo);
		
		return list;
		
	}

	@Override
	public List<CartDTO> getCartList(Map<String, Object> productListInfo) {

		System.out.println("MypageDAOImpl => getCartList");
		
		List<CartDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.getCartList", productListInfo);
		
		return list;
	}
	
	
	@Override
	public int pwdcheck(Map<String, Object> map) {
		int result = sqlSession.selectOne("com.spring.DCShop.mypage.dao.MypageDAO.pwdcheck", map);
		return result;
	}

	// 유저 정보 가져오기
	@Override
	public MypageDTO getUserInfo(String loginId) {
		MypageDTO dto = sqlSession.selectOne("com.spring.DCShop.mypage.dao.MypageDAO.getUserInfo", loginId);
		return dto;
	}
	// 수정된 유저 정보 
	@Override
	public int setUserInfo(Map<String, Object> map) {
		int updateCnt = sqlSession.update("com.spring.DCShop.mypage.dao.MypageDAO.setUserInfo", map);
		return updateCnt;
	}

	// 플필사진업뎃
	@Override
	public int profileupdate(Map<String, Object> map) {
		int pfupdateCnt = sqlSession.update("com.spring.DCShop.mypage.dao.MypageDAO.profileupdate", map);
		return pfupdateCnt;
	}
	
	
	// 기존 펫 정보가져오기
	@Override
	public List<MyPetDTO> getPetList(int u_member_id) {
		List<MyPetDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.MypageDAO.getPetList", u_member_id);
		return list;
	}
	
	// 동물정보 인서트
	@Override
	public int petInfoInsert(MyPetDTO dto) {
		int insertCnt = sqlSession.insert("com.spring.DCShop.mypage.dao.MypageDAO.petInfoInsert", dto);
		return insertCnt;
	}
	
	// 동물정보 업데이트
	@Override
	public int petInfoUpdate(MyPetDTO dto) {
		int updateCnt = sqlSession.update("com.spring.DCShop.mypage.dao.MypageDAO.petInfoUpdate", dto);
		return updateCnt;
	}
	
	// 동물 정보 삭제
	@Override
	public int petInfoDelete(Map<String, Object> map) {
		int deleteCnt = sqlSession.update("com.spring.DCShop.mypage.dao.MypageDAO.petInfoDelete", map);
		return deleteCnt;
	}
	
}
