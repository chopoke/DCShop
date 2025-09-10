package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.shop.dto.ShopDTO;
import com.spring.DCShop.user.dto.UserDTO;

public interface AdminDAO {

	// 회원목록-최신가입자5건조회
	public List<UserDTO> adminUserList1();
	
	// 회원목록 - 펫통계
	public Map<String, Object> adminUserPet();
	
	// 게시판목록
	public List<BoardDTO> adminBoardList(Map<String, Object> params);
	
	// 게시판 총 개수
	public int adminBoardCount(Map<String, Object> params);
	
	// 게시판 선택 삭제 - 부모
	public int adminBoardDelete(List<Integer> ids);
	
	// 게시판 선택 삭제 - 추천(자식)
	public int adminBoardRecommentDelete(List<Integer> ids);
	
	// 게시판 선택 삭제 - 댓글(자식)
	public int adminBoardCommentDelete(List<Integer> ids);
	
	// 상품관리 - 건수
	public int adminProductCount(Map<String, Object> param);
	
	// 상품관리 - 목록
	public List<ShopDTO> adminProductList(Map<String, Object> param);
	
	// 상품관리 - 상태
	public int adminProductStatus(Map<String, Object> param);
	
	// 상품관리 - 삭제
	public int adminProductDelete(List<Integer> ids);
	// 상품관리 - 자식삭제(리뷰삭제)
	public int adminProductReviewDelete(List<Integer> ids);
	// 상품관리 - 자식삭제(qna삭제)
	public int adminProductQnaDelete(List<Integer> ids);
	
	// 상품관리 - 등록
	public int adminProductInsert(ShopDTO dto);
	
	// 상품관리 - 수정폼
	public ShopDTO adminProductUpdateForm(int pdId);
	
	// 상품관리 - 수정처리
	public int adminProductUpdate(ShopDTO dto);
	
	
}
