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
	
	// 통합 게시판 목록 (공지/이벤트/커뮤니티)
	public List<BoardDTO> unifiedBoardListAction(Map<String, Object> map);
	
	// 통합 게시판 전체 개수
	public int unifiedBoardListTotal(String category);
	
	// 카테고리별 게시판 목록
	public List<BoardDTO> categoryBoardListAction(Map<String, Object> map);
	
	// 카테고리별 게시판 전체 개수
	public int categoryBoardListTotal(String category);
	
	// 공지/이벤트 통합 목록 (공지+이벤트)
	public List<BoardDTO> noticeUnifiedListAction(Map<String, Object> map);
	
	// 공지/이벤트 통합 전체 개수 (공지+이벤트)
	public int noticeUnifiedListTotal();

	// 회원 번호 조회
	int selectU_member_id(String u_id);
	// 작성자 닉네임 조회
	String selectU_nicknameAction(String u_id);

	
}
