package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.shop.dto.QuestDTO;
import com.spring.DCShop.shop.dto.ShopDTO;
import com.spring.DCShop.user.dto.UserDTO;

public interface AdminDAO {

	// 관리자메인 - 게시판건수
	public int countBoard();
	// 관리자메인 - 주문건수
	public int countOrder();
	// 관리자메인 - 상품건수
	public int countProduct();
	// 관리자메인 - 문의건수
	public int countQna();
	// 관리자메인 - 리뷰건수
	public int countReview();
	// 관리자메인 - 회원건수
	public int countUser();
	
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
	
	// 주문관리 - 목록검색
	public List<Map<String, Object>> findOrder(Map<String, Object> sc);
	
	// 주문관리 - 건수
	public int adminCountOrder(Map<String,  Object> sc);
	
	// 주문관리 - 상세_정보
	public Map<String, Object> adminOrderInfo(String oNum);
	// 주문관리 - 상세_상품목록
	public List<Map<String, Object>> adminOrderProductList(String oNum);
	
	// 주문관리 - 주문상태변경
	public int adminOrderStatus(String oNum, String newStatus);
	
	// 주문관리 - 배송상태변경
	public int adminOrderDelivery(String oNum, String newStatus);
	
	// 문의관리 - 갯수
	public int adminQnaCnt(Map<String, Object> map);
	
	// 문의관리 - 리스트 
	public List<QuestDTO> adminQnaList(Map<String, Object> param);
	
	// 문의관리 - 답변 페이지
	public QuestDTO questDetail(int q_num);
	
	// 문의관리 - 답변
	public void updateAnswer(QuestDTO dto);
	
	// 리뷰관리 - 총 개수
	public int adminReviewCount(Map<String, Object> param);
	
	// 리뷰관리 - 목록 조회
	public List<Map<String, Object>> adminReviewList(Map<String, Object> param);
	
	// 리뷰관리 - 상세 조회
	public Map<String, Object> adminReviewDetail(int rNum);
	
	// 리뷰관리 - 선택 삭제
	public int adminReviewDelete(List<Integer> ids);
	// 회원목록-최신가입자5건조회
	public List<UserDTO> adminUserList1();
	
	// 회원목록 - 펫통계
	public Map<String, Object> adminUserPet();
	
	// 회원목록 - 탈퇴회원5건조회
	public List<UserDTO> adminUserList2();
}
