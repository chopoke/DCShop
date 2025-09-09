package com.spring.DCShop.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.board.dto.CommentDTO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	SqlSession sqlSession;

	// 게시판 목록
	@Override
	public List<BoardDTO> boardListAction(Map<String, Object> map) {
		
		List<BoardDTO> list = sqlSession.selectList("com.spring.DCShop.board.dao.BoardDAO.boardListAction", map);
		
		return list;
	}

	// 게시글 전체 개수
	@Override
	public int boardListTotal(Map<String, Object> countP) {
		System.out.println("BoardDAOImpl - boardListTotal()");

		int total = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.boardListTotal",countP);
		
		return total;
	}

	// 게시판 상세페이지
	@Override
	public BoardDTO boardDetailAction(int b_num) {
		System.out.println("BoardDAOImpl - boardInsertAction()");
		
		BoardDTO dto = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.boardDetailAction", b_num);
		
		return dto;
	}
	
	// 조회수 증가
	@Override
	public void viewsUpdateAction(int b_num) {
		System.out.println("BoardDAOImpl - viewsUpdateAction()");
		
		sqlSession.update("com.spring.DCShop.board.dao.BoardDAO.viewsUpdateAction", b_num);
	}
	
	// 추천 여부
	public int isRecommended(Map<String, Object> map) {
		System.out.println("BoardDAOImpl - isRecommended()");
		
		int count = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.isRecommended", map);
		
		return count;
	}
	
	// 추천 추가 클릭
	public void recommendAddAction(Map<String, Object> map) {
		System.out.println("BoardDAOImpl - recommendAddAction()");
		
		sqlSession.insert("com.spring.DCShop.board.dao.BoardDAO.recommendAddAction", map);
	}
	
	// 추천 삭제 클릭
	public void recommendRemoveAction(Map<String, Object> map) {
		System.out.println("BoardDAOImpl - recommendRemoveAction()");
		
		sqlSession.delete("com.spring.DCShop.board.dao.BoardDAO.recommendRemoveAction", map);
	}
	
	// 추천수 변경
	public int recommendUpdateAction(int b_num) {
		System.out.println("BoardDAOImpl - recommendUpdateAction()");
		
		int success = sqlSession.update("com.spring.DCShop.board.dao.BoardDAO.recommendUpdateAction", b_num);
		
		return success;
	}
	
	// 추천수
	public int selectB_recommend(int b_num) {
		System.out.println("BoardDAOImpl - selectB_recommend()");
		
		int b_recommend = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.selectB_recommend", b_num);
		
		return b_recommend;
	}
	// 작성자
	public String selectU_nicknameAction(String u_id) {
		System.out.println("BoardDAOImpl - selectU_nicknameAction()");
		
		String u_nickname = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.selectU_nicknameAction", u_id);
		
		return u_nickname;
	}

	// 게시판 등록
	@Override
	public int boardInsertAction(BoardDTO dto) {
		System.out.println("BoardDAOImpl - boardInsertAction()");
		
		sqlSession.insert("com.spring.DCShop.board.dao.BoardDAO.boardInsertAction", dto);
		
		return 0;
	}
	
	// 회원 번호 
	public int selectU_member_id(String u_id) {
		System.out.println("BoardDAOImpl - selectU_member_id()");
		int u_member_id = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.selectU_member_id",u_id);
		
		return u_member_id;
	}
	
	// 게시글 번호
	public int selectB_num(int u_member_id) {
		System.out.println("BoardDAOImpl - selectB_num()");
		
		int b_num = sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.selectB_num", u_member_id);
		
		return b_num;
	}

	// 게시판 수정 정보
	@Override
	public BoardDTO boardUpdateDTOAction(int b_num) {
		return sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.boardUpdateDTOAction", b_num);
	}
	// 게시판 수정 등록
	@Override
	public int boardUpdateAction(BoardDTO dto) {
		return sqlSession.update("com.spring.DCShop.board.dao.BoardDAO.boardUpdateAction", dto);
	}

	// 게시판 삭제
	@Override
	public int boardDeleteAction(int b_num) {
		return sqlSession.delete("com.spring.DCShop.board.dao.BoardDAO.boardDeleteAction", b_num);
	}

	// 게시글의 추천 삭제 (자식 선삭제)
	@Override
	public int deleteRecommendsByBoard(int b_num) {
		return sqlSession.delete("com.spring.DCShop.board.dao.BoardDAO.deleteRecommendsByBoard", b_num);
	}

	// 게시글의 댓글 삭제 (자식 선삭제)
	@Override
	public int deleteCommentsByBoard(int b_num) {
		return sqlSession.delete("com.spring.DCShop.board.dao.BoardDAO.deleteCommentsByBoard", b_num);
	}

	// 게시글 작성자 아이디 조회
	@Override
	public String selectBoardAuthorId(int b_num) {
		return sqlSession.selectOne("com.spring.DCShop.board.dao.BoardDAO.selectBoardAuthorId", b_num);
	}

	// 댓글 목록
	@Override
	public List<CommentDTO> commentListAction(int b_num) {
		System.out.println("BoardDAOImpl - commentListAction()");
		List<CommentDTO> list = sqlSession.selectList("com.spring.DCShop.board.dao.BoardDAO.commentListAction", b_num);
		// 5. list를 리턴
		return list;
	}

	// 댓글 등록
	@Override
	public void commentInsertAction(CommentDTO dto) {
		System.out.println("BoardDAOImpl - commentInsertAction()");
		System.out.println("dto"+ dto);
		sqlSession.insert("com.spring.DCShop.board.dao.BoardDAO.commentInsertAction", dto);
	}

	// 댓글 수정
	@Override
	public int commentUpdateAction(CommentDTO dto) {
		System.out.println("BoardDAOImpl - commentUpdateAction()");
		return sqlSession.update("com.spring.DCShop.board.dao.BoardDAO.commentUpdateAction", dto);
	}

	// 댓글 삭제
	@Override
	public int commentDeleteAction(int c_num) {
		System.out.println("BoardDAOImpl - commentDeleteAction()");
		return sqlSession.delete("com.spring.DCShop.board.dao.BoardDAO.commentDeleteAction", c_num);
	}
	

	// 검색
	@Override
	public List<BoardDTO> searchAction(String b_category) {
		return null;
	}

}
