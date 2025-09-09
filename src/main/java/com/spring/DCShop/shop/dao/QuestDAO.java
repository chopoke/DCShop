package com.spring.DCShop.shop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.DCShop.shop.dto.QuestDTO;

public interface QuestDAO {
	//문의 작성 처리
	public void insertQuest(QuestDTO dto);
	
	//문의 목록							get방식으로 넘어오는 pd_id를 @Param으로 받아오게 주입
	public List<QuestDTO> questList(@Param("pd_id") int pd_id);
	
	//문의 상세 데이터
	public QuestDTO qusetDetail(int q_num);
}
