package com.spring.DCShop.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.board.dto.CommentDTO;
import com.spring.DCShop.user.dto.UserDTO;

public interface BoardDAO {

	// 게시판 목록
	public List<BoardDTO> boardListAction(Map<String, Object> map);
	
	// 게시글 전체 개수
	public int boardListTotal();
	
	// 게시판 상세페이지
	public BoardDTO boardDetailAction(int b_num);
	
	// 조회수 증가
	public void viewsUpdateAction(int b_num);
	
	// 추천 여부
	public int isRecommended(Map<String, Object> map);
	
	// 추천 추가 클릭
	public void recommendAddAction(Map<String, Object> map);
	
	// 추천 삭제 클릭
	public void recommendRemoveAction(Map<String, Object> map);
	
	// 추천수 변경
	public int recommendUpdateAction(int b_num);
	
	// 추천수
	public int selectB_recommend(int b_num);
	
	// 작성자
	public String selectU_nicknameAction(String u_id);
	
	// 게시판 등록
	public int boardInsertAction(BoardDTO dto);
	
	// 회원 번호 
	public int selectU_member_id(String u_id);
	
	// 게시글 번호
	public int selectB_num(int u_member_id);
	
	// 게시판 수정 정보
	public BoardDTO boardUpdateDTOAction(int b_num);
	
	// 게시판 수정 등록
	public int boardUpdateAction(BoardDTO dto);
	
	// 게시판 삭제
	public int boardDeleteAction(int b_num);

	// 게시글의 추천 삭제 (자식 선삭제)
	public int deleteRecommendsByBoard(int b_num);

	// 게시글의 댓글 삭제 (자식 선삭제)
	public int deleteCommentsByBoard(int b_num);

	// 게시글 작성자 아이디 조회
	public String selectBoardAuthorId(int b_num);
	
	// 댓글 목록
	public List<CommentDTO> commentListAction(int b_num);
	
	// 댓글 등록
	public void commentInsertAction(CommentDTO dto);
	
	// 댓글 수정
	public int commentUpdateAction(CommentDTO dto);
			
	// 댓글 삭제
	public int commentDeleteAction(int c_num);
	
	// 검색
	public List<BoardDTO> searchAction(String b_category);
	
}
