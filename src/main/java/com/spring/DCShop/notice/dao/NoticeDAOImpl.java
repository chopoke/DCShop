package com.spring.DCShop.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.notice.dto.NoticeDTO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 공지 목록 조회
	@Override
	public List<NoticeDTO> noticeListAction(Map<String, Object> map) {
		return sqlSession.selectList("noticeMapper.noticeListAction", map);
	}
	
	// 공지 전체 개수
	@Override
	public int noticeListTotal() {
		return sqlSession.selectOne("noticeMapper.noticeListTotal");
	}
	
	// 공지 상세 조회
	@Override
	public NoticeDTO noticeDetailAction(int n_num) {
		return sqlSession.selectOne("noticeMapper.noticeDetailAction", n_num);
	}
	
	// 조회수 증가
	@Override
	public void viewsUpdateAction(int n_num) {
		sqlSession.update("noticeMapper.viewsUpdateAction", n_num);
	}
	
	// 공지 등록
	@Override
	public int noticeInsertAction(NoticeDTO dto) {
		return sqlSession.insert("noticeMapper.noticeInsertAction", dto);
	}
	
	// 공지 수정 정보 조회
	@Override
	public NoticeDTO noticeUpdateDTOAction(int n_num) {
		return sqlSession.selectOne("noticeMapper.noticeUpdateDTOAction", n_num);
	}
	
	// 공지 수정
	@Override
	public int noticeUpdateAction(NoticeDTO dto) {
		return sqlSession.update("noticeMapper.noticeUpdateAction", dto);
	}
	
	// 공지 삭제
	@Override
	public int noticeDeleteAction(int n_num) {
		return sqlSession.delete("noticeMapper.noticeDeleteAction", n_num);
	}
	
	// 회원 번호 조회
	@Override
	public int selectU_member_id(String u_id) {
		return sqlSession.selectOne("noticeMapper.selectU_member_id", u_id);
	}
	
	// 공지 번호 조회
	@Override
	public int selectN_num(int u_member_id) {
		return sqlSession.selectOne("noticeMapper.selectN_num", u_member_id);
	}
	
	// 공지 작성자 아이디 조회
	@Override
	public String selectNoticeAuthorId(int n_num) {
		return sqlSession.selectOne("noticeMapper.selectNoticeAuthorId", n_num);
	}
}
