package com.spring.DCShop.notice.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.notice.dto.NoticeDTO;

public interface NoticeDAO {
	
	// 공지 목록 조회
	public List<NoticeDTO> noticeListAction(Map<String, Object> map);
	
	// 공지 전체 개수
	public int noticeListTotal();
	
	// 공지 상세 조회
	public NoticeDTO noticeDetailAction(int n_num);
	
	// 조회수 증가
	public void viewsUpdateAction(int n_num);
	
	// 공지 등록
	public int noticeInsertAction(NoticeDTO dto);
	
	// 공지 수정 정보 조회
	public NoticeDTO noticeUpdateDTOAction(int n_num);
	
	// 공지 수정
	public int noticeUpdateAction(NoticeDTO dto);
	
	// 공지 삭제
	public int noticeDeleteAction(int n_num);
	
	// 회원 번호 조회
	public int selectU_member_id(String u_id);
	
	// 공지 번호 조회
	public int selectN_num(int u_member_id);
	
	// 공지 작성자 아이디 조회
	public String selectNoticeAuthorId(int n_num);
}
