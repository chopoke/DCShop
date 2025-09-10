package com.spring.DCShop.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.board.dto.BoardDTO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	SqlSession sqlSession;

	// 공지/이벤트 목록
	@Override
	public List<BoardDTO> noticeListAction(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - noticeListAction()");
		
		List<BoardDTO> list = sqlSession.selectList("com.spring.DCShop.board.dao.NoticeDAO.noticeListAction", map);
		
		return list;
	}

	// 공지/이벤트 전체 개수
	@Override
	public int noticeListTotal(String category) {
		System.out.println("NoticeDAOImpl - noticeListTotal()");

		int total = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.noticeListTotal", category);
		
		return total;
	}

	// 공지/이벤트 상세페이지
	@Override
	public BoardDTO noticeDetailAction(int b_num) {
		System.out.println("NoticeDAOImpl - noticeDetailAction()");
		
		BoardDTO dto = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.noticeDetailAction", b_num);
		
		return dto;
	}
	
	// 공지/이벤트 등록
	@Override
	public int noticeInsertAction(BoardDTO dto) {
		System.out.println("NoticeDAOImpl - noticeInsertAction()");
		
		sqlSession.insert("com.spring.DCShop.board.dao.NoticeDAO.noticeInsertAction", dto);
		
		return dto.getB_num();
	}
	
	// 공지/이벤트 수정
	@Override
	public int noticeUpdateAction(BoardDTO dto) {
		System.out.println("NoticeDAOImpl - noticeUpdateAction()");
		
		return sqlSession.update("com.spring.DCShop.board.dao.NoticeDAO.noticeUpdateAction", dto);
	}
	
	// 공지/이벤트 삭제
	@Override
	public int noticeDeleteAction(int b_num) {
		System.out.println("NoticeDAOImpl - noticeDeleteAction()");
		
		return sqlSession.delete("com.spring.DCShop.board.dao.NoticeDAO.noticeDeleteAction", b_num);
	}
	
	// 공지/이벤트 조회수 증가
	@Override
	public void noticeViewsUpdateAction(int b_num) {
		System.out.println("NoticeDAOImpl - noticeViewsUpdateAction()");
		
		sqlSession.update("com.spring.DCShop.board.dao.NoticeDAO.noticeViewsUpdateAction", b_num);
	}
	
	// 공지/이벤트 추천 여부
	@Override
	public int noticeIsRecommended(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - noticeIsRecommended()");
		
		int count = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.noticeIsRecommended", map);
		
		return count;
	}
	
	// 공지/이벤트 추천 추가
	@Override
	public void noticeRecommendAddAction(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - noticeRecommendAddAction()");
		
		sqlSession.insert("com.spring.DCShop.board.dao.NoticeDAO.noticeRecommendAddAction", map);
	}
	
	// 공지/이벤트 추천 삭제
	@Override
	public void noticeRecommendRemoveAction(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - noticeRecommendRemoveAction()");
		
		sqlSession.delete("com.spring.DCShop.board.dao.NoticeDAO.noticeRecommendRemoveAction", map);
	}
	
	// 공지/이벤트 추천수 변경
	@Override
	public int noticeRecommendUpdateAction(int b_num) {
		System.out.println("NoticeDAOImpl - noticeRecommendUpdateAction()");
		
		int success = sqlSession.update("com.spring.DCShop.board.dao.NoticeDAO.noticeRecommendUpdateAction", b_num);
		
		return success;
	}
	
	// 공지/이벤트 추천수 조회
	@Override
	public int noticeSelectB_recommend(int b_num) {
		System.out.println("NoticeDAOImpl - noticeSelectB_recommend()");
		
		int b_recommend = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.noticeSelectB_recommend", b_num);
		
		return b_recommend;
	}
	
	// 공지/이벤트 작성자 아이디 조회
	@Override
	public String noticeSelectBoardAuthorId(int b_num) {
		System.out.println("NoticeDAOImpl - noticeSelectBoardAuthorId()");
		
		return sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.noticeSelectBoardAuthorId", b_num);
	}
	
	// 공지/이벤트 추천 삭제 (자식 선삭제)
	
	@Override
	public void deleteRecommendsByNotice(int b_num) {
		System.out.println("NoticeDAOImpl - deleteRecommendsByNotice()");
	    sqlSession.delete("com.spring.DCShop.board.dao.NoticeDAO.deleteRecommendByBoard", b_num);
	}
	
	public void deleteNotice(int b_num) {
    // 순서 중요: 추천 삭제 후 게시글 삭제
		deleteRecommendsByNotice(b_num);
    	sqlSession.delete("com.spring.DCShop.board.dao.NoticeDAO.noticeDeleteAction", b_num);
	}

	
	// 통합 게시판 목록 (공지/이벤트/커뮤니티)
	@Override
	public List<BoardDTO> unifiedBoardListAction(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - unifiedBoardListAction()");
		
		List<BoardDTO> list = sqlSession.selectList("com.spring.DCShop.board.dao.NoticeDAO.unifiedBoardListAction", map);
		
		return list;
	}
	
	// 통합 게시판 전체 개수
	@Override
	public int unifiedBoardListTotal(String category) {
		System.out.println("NoticeDAOImpl - unifiedBoardListTotal()");

		int total = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.unifiedBoardListTotal", category);
		
		return total;
	}
	
	// 카테고리별 게시판 목록
	@Override
	public List<BoardDTO> categoryBoardListAction(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - categoryBoardListAction()");
		
		List<BoardDTO> list = sqlSession.selectList("com.spring.DCShop.board.dao.NoticeDAO.categoryBoardListAction", map);
		
		return list;
	}
	
	// 카테고리별 게시판 전체 개수
	@Override
	public int categoryBoardListTotal(String category) {
		System.out.println("NoticeDAOImpl - categoryBoardListTotal()");

		int total = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.categoryBoardListTotal", category);
		
		return total;
	}
	
	// 회원 번호 조회
	@Override
	public int selectU_member_id(String u_id) {
		System.out.println("NoticeDAOImpl - selectU_member_id()");
		
		int u_member_id = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.selectU_member_id", u_id);
		
		return u_member_id;
	}
	
	// 작성자 닉네임 조회
	@Override
	public String selectU_nicknameAction(String u_id) {
		System.out.println("NoticeDAOImpl - selectU_nicknameAction()");
		
		String u_nickname = sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.selectU_nicknameAction", u_id);
		
		return u_nickname;
	}

	// 공지/이벤트 통합 목록 (공지+이벤트)
	@Override
	public List<BoardDTO> noticeUnifiedListAction(Map<String, Object> map) {
		System.out.println("NoticeDAOImpl - noticeUnifiedListAction()");
		return sqlSession.selectList("com.spring.DCShop.board.dao.NoticeDAO.noticeUnifiedListAction", map);
	}

	// 공지/이벤트 통합 전체 개수 (공지+이벤트)
	@Override
	public int noticeUnifiedListTotal() {
		System.out.println("NoticeDAOImpl - noticeUnifiedListTotal()");
		return sqlSession.selectOne("com.spring.DCShop.board.dao.NoticeDAO.noticeUnifiedListTotal");
	}

	

}
