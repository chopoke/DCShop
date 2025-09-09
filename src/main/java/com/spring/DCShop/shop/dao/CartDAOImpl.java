package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.shop.dto.CartDTO;
import com.spring.DCShop.shop.dto.UserDTO;


@Repository
public class CartDAOImpl implements CartDAO {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public int upsertCart(CartDTO dto) {
		System.out.println("CartDAOImpl => upsertCart");
		
		int insertResult = sqlSession.update("com.spring.DCShop.shop.dao.CartDAO.upsertCart", dto);
		
		return insertResult;
	}
	
	@Override
	public UserDTO getUserInfo(String sessionId) {
		System.out.println("CartDAOImpl => getUserInfo");

		UserDTO list = sqlSession.selectOne("com.spring.DCShop.shop.dao.CartDAO.getUserInfo", sessionId);

		return list;

	}

	/**
	 * @purpose 장바구니 상품 리스트 가져오기
	 */
	@Override
	public List<CartDTO> getProductList(String uMemberId) {
		System.out.println("CartDAOImpl => getProductList");
		
		List<CartDTO> list = sqlSession.selectList("com.spring.DCShop.shop.dao.CartDAO.getCartList", uMemberId);
		
		return list;
	}

	/**
	 * @purpose 상품 갯수 증가
	 */
	@Override
	public int increaseProductCount(Map<String, Object> increaseInfo) {
		System.out.println("CartDAOImpl => increaseProductCount");
		
		int upResult = sqlSession.update("com.spring.DCShop.shop.dao.CartDAO.increaseProductCount", increaseInfo);

		return upResult;
	}
	
	/**
	 * @purpose 상품 갯수 감소
	 */
	@Override
	public int dicreaseProductCount(Map<String, Object> dicreaseInfo) {
		System.out.println("CartDAOImpl => dicreaseProductCount");
		
		int upResult = sqlSession.update("com.spring.DCShop.shop.dao.CartDAO.dicreaseProductCount", dicreaseInfo);
		
		return upResult;
		
	}

	/**
	 * @purpose 상품 갯수 가져오기
	 */
	@Override
	public CartDTO getProductCount(Map<String, Object> cartinfo) {
		System.out.println("CartDAOImpl => getProductCount");
		
		CartDTO cartdto = sqlSession.selectOne("com.spring.DCShop.shop.dao.CartDAO.getProductCount", cartinfo);
		
		return cartdto;
	}

	/**
	 * @purpose 0개인 생품 삭제
	 */
	@Override
	public int deleteProductFromCart(Map<String, Object> deleteInfo) {
		System.out.println("CartDAOImpl => deleteProductFromCart");
		
		int deleteResult = sqlSession.delete("com.spring.DCShop.shop.dao.CartDAO.deleteProductFromCart", deleteInfo);
		
		return deleteResult;
	}
	
	/**
	 * @purpose 0개인 생품 삭제
	 */
	@Override
	public int changeProductFromCart(Map<String, Object> changeInfo) {
		System.out.println("CartDAOImpl => changeProductFromCart");
		
		int changeResult = sqlSession.update("com.spring.DCShop.shop.dao.CartDAO.changeProductFromCart", changeInfo);
		
		return changeResult;
	}

}
