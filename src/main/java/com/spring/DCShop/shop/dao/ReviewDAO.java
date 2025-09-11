package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.shop.dto.ReviewDTO;

public interface ReviewDAO {
	
	// 리뷰 목록
	public List<ReviewDTO> reviewList(Map<String, Object> map);
	
	// 리뷰 개수 구하기
	public int reviewCnt(int pd_id);
	
	// 리뷰 상세 처리
	public ReviewDTO getReviewDetail(int r_num);
	
	public List<ReviewDTO> recentReviews(int pd_id);
	
	// 평균별점
	public Double avgScoreByProduct(int pd_id);
	
	// 리뷰 수정삭제 버튼 클릭시 - 회원번호 인증처리
	public int review_chk(Map <String, Object> map);
	
	// 리뷰 수정 처리
	public void updateReview(ReviewDTO dto);
	
	// 리뷰 삭제 처리
	public void deleteReview(int r_num);
	
	// 리뷰 작성 처리
	public void insertReview(ReviewDTO dto);
	
	// 구매 여부 체크 
	public int hasPurchased(Map<String,Object> param);
	
	// 중복 리뷰 체크
	public int alreadyReviewed(Map<String,Object> param);
	
	
	public int myReviewCount(int uMemberId);
	
	public List<Map<String,Object>> myReviewList(Map<String,Object> param);
	
}
