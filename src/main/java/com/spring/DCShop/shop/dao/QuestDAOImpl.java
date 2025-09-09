package com.spring.DCShop.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DCShop.shop.dto.QuestDTO;

@Repository
public class QuestDAOImpl implements QuestDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	//문의 작성 처리
	@Override
	public void insertQuest(QuestDTO dto) {
		sqlSession.insert("com.spring.DCShop.shop.dao.QuestDAO.insertQuest", dto);
		
	}

	//문의 목록 불러오기
	@Override
	public List<QuestDTO> questList(int pd_id) {
		List<QuestDTO> list = sqlSession.selectList("com.spring.DCShop.shop.dao.QuestDAO.questList", pd_id);
		return list;
	}
	
	@Override
	public QuestDTO qusetDetail(int q_num) {
		return sqlSession.selectOne("com.spring.DCShop.shop.dao.QuestDAO.qusetDetail", q_num);
	}
}
