package com.spring.DCShop.shop.dao;

import java.util.List;
import java.util.Map;

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

	//문의 갯수
	public int questCnt(int pd_id){
		int total = sqlSession.selectOne("com.spring.DCShop.shop.dao.QuestDAO.questCnt", pd_id);
		return total;
	}
	
	//문의 목록 불러오기
	@Override
	public List<QuestDTO> questList(Map<String, Object> map) {
		List<QuestDTO> list = sqlSession.selectList("com.spring.DCShop.shop.dao.QuestDAO.questList", map);
		return list;
	}
	
	@Override
	public QuestDTO qusetDetail(int q_num) {
		return sqlSession.selectOne("com.spring.DCShop.shop.dao.QuestDAO.qusetDetail", q_num);
	}
}
