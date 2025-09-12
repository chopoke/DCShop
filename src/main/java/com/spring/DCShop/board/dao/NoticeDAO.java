package com.spring.DCShop.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.board.dto.BoardDTO;

public interface NoticeDAO {

	// 공지/이벤트 목록
	public List<BoardDTO> noticeListAction(Map<String, Object> map);
	
	// 공지/이벤트 전체 개수
	public int noticeListTotal(String category);
	
	// 공지/이벤트 상세페이지
	public BoardDTO noticeDetailAction(int b_num);
	
	// 공지/이벤트 등록
	public int noticeInsertAction(BoardDTO dto);
	
	// 공지/이벤트 수정
	public int noticeUpdateAction(BoardDTO dto);

	// 공지/이벤트 삭제
	public int noticeDeleteAction(int b_num);
	
	//추천 삭제 (자식 선삭제)
	public void deleteRecommendsByNotice(int b_num);
	
	// 공지/이벤트 조회수 증가
	public void noticeViewsUpdateAction(int b_num);
	
	// 공지/이벤트 추천 여부
	public int noticeIsRecommended(Map<String, Object> map);
	
	
	
	// 공지/이벤트 추천 추가
	public void noticeRecommendAddAction(Map<String, Object> map);
	
	// 공지/이벤트 추천 삭제
	public void noticeRecommendRemoveAction(Map<String, Object> map);

	// 공지/이벤트 추천수 변경
	public int noticeRecommendUpdateAction(int b_num);
	
	// 공지/이벤트 추천수 조회 
	public int noticeSelectB_recommend(int b_num);
	
	// 공지/이벤트 작성자 아이디 조회
	public String noticeSelectBoardAuthorId(int b_num);
	
	// 회원 번호 조회
	int selectU_member_id(String u_id);
	// 작성자 닉네임 조회
	String selectU_nicknameAction(String u_id);

	// 카테고리별 게시판 목록 (구분별 조회: 공지/이벤트)
	List<BoardDTO> categoryBoardListAction(Map<String, Object> map);
	// 카테고리별 전체 개수
	int categoryBoardListTotal(String category);

	// 카테고리별 최신 글 N건 조회 (메인용)
	List<BoardDTO> selectLatestByCategory(Map<String, Object> map);

	
}
