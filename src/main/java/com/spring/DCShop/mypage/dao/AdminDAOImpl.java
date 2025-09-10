package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.shop.dto.ShopDTO;
import com.spring.DCShop.user.dto.UserDTO;

@Repository
public class AdminDAOImpl implements AdminDAO{
	
	@Autowired
	private SqlSession sqlSession;

	// 회원목록-최신가입자5건조회
	@Override
	public List<UserDTO> adminUserList1() {
		List<UserDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.AdminDAO.adminUserList1");
		return list;
	}
	
	// 회원목록 - 펫통계
	@Override
	public Map<String, Object> adminUserPet() {
		Map<String, Object> map = sqlSession.selectOne("com.spring.DCShop.mypage.dao.AdminDAO.adminUserPet");
		return map;
	}

	// 게시판목록
	@Override
	public List<BoardDTO> adminBoardList(Map<String, Object> param) {
		List<BoardDTO> list = sqlSession.selectList("com.spring.DCShop.mypage.dao.AdminDAO.adminBoardList", param);
		return list;
	}

	// 게시판 총 개수
	@Override
	public int adminBoardCount(Map<String, Object> param) {
		int countCnt = sqlSession.selectOne("com.spring.DCShop.mypage.dao.AdminDAO.adminBoardCount", param);
		return countCnt;
	}

	// 게시판 선택 삭제 - 부모
	@Override
	public int adminBoardDelete(List<Integer> ids) {
		int boardDeleteCnt = sqlSession.delete("com.spring.DCShop.mypage.dao.AdminDAO.adminBoardDelete", ids);
		return boardDeleteCnt;
	}

	// 게시판 선택 삭제 - 추천(자식)
	@Override
	public int adminBoardRecommentDelete(List<Integer> ids) {
		int boardRecommentDeleteCnt = sqlSession.delete("com.spring.DCShop.mypage.dao.AdminDAO.adminBoardRecommentDelete", ids);
		return boardRecommentDeleteCnt;
	}

	// 게시판 선택 삭제 - 댓글(자식)
	@Override
	public int adminBoardCommentDelete(List<Integer> ids) {
		int boardCommentDeleteCnt = sqlSession.delete("com.spring.DCShop.mypage.dao.AdminDAO.adminBoardCommentDelete", ids);
		return boardCommentDeleteCnt;
	}

	// 상품관리 - 건수
	@Override
	public int adminProductCount(Map<String, Object> param) {
		int productCnt = sqlSession.selectOne("com.spring.DCShop.mypage.dao.AdminDAO.adminProductCount", param);
		return productCnt;
	}

	// 상품관리 - 목록
	@Override
	public List<ShopDTO> adminProductList(Map<String, Object> param) {
		List<ShopDTO> dto = sqlSession.selectList("com.spring.DCShop.mypage.dao.AdminDAO.adminProductList", param);
		return dto;
	}

	// 상품관리 - 상태
	@Override
	public int adminProductStatus(Map<String, Object> param) {
		int productStatusCnt = sqlSession.update("com.spring.DCShop.mypage.dao.AdminDAO.adminProductStatus", param);
		return productStatusCnt;
	}

	// 상품관리 - 삭제
	@Override
	public int adminProductDelete(List<Integer> ids) {
		int productdeleteCnt = sqlSession.delete("com.spring.DCShop.mypage.dao.AdminDAO.adminProductDelete", ids);
		return productdeleteCnt;
	}
	// 상품관리 - 자식삭제(리뷰)
	@Override
	public int adminProductReviewDelete(List<Integer> ids) {
		int productreviewdeleteCnt = sqlSession.delete("com.spring.DCShop.mypage.dao.AdminDAO.adminProductReviewDelete", ids);
		return productreviewdeleteCnt;
	}
	// 상품관리 - 자식삭제(qna)
	@Override
	public int adminProductQnaDelete(List<Integer> ids) {
		int productqnadeleteCnt = sqlSession.delete("com.spring.DCShop.mypage.dao.AdminDAO.adminProductQnaDelete", ids);
		return productqnadeleteCnt;
	}

	// 상품관리 - 등록
	@Override
	public int adminProductInsert(ShopDTO dto) {
		int productinsertCnt = sqlSession.insert("com.spring.DCShop.mypage.dao.AdminDAO.adminProductInsert", dto);
		return productinsertCnt;
	}

	// 상품관리 - 수정폼
	@Override
	public ShopDTO adminProductUpdateForm(int pdId) {
		ShopDTO dto = sqlSession.selectOne("com.spring.DCShop.mypage.dao.AdminDAO.adminProductUpdateForm", pdId);
		return dto;
	}
	
	// 상품관리 - 수정처리
	@Override
	public int adminProductUpdate(ShopDTO dto) {
		int productupdateCnt = sqlSession.update("com.spring.DCShop.mypage.dao.AdminDAO.adminProductUpdate", dto);
		return productupdateCnt;
	}

	

	
	
	

}
