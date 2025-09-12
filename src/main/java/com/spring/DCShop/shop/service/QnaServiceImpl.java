package com.spring.DCShop.shop.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.board.page.Paging;
import com.spring.DCShop.shop.dao.QuestDAO;
import com.spring.DCShop.shop.dto.QuestDTO;


@Service
public class QnaServiceImpl implements QnaService{
	
	@Autowired
	private QuestDAO dao;
	
	//[문의 작성 처리]
	@Override
	public void addQuestion(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("BoardServiceImpl - commentAddaction()");
		
		// 3단계. 화면에서 입력받은 값(jQuery에서 넘긴값)을 가져와서 객체에 담는다.
		// 문의 내용을 담을 객체(QuestDTO) 생성
		QuestDTO dto = new QuestDTO();
		dto.setPd_id(Integer.parseInt(request.getParameter("pd_id"))); //문의를 작성한 상품 페이지의 상품 번호
		dto.setU_member_id((Integer)request.getSession().getAttribute("session_u_member_id")); //문의를 한 유저
		dto.setQ_title(request.getParameter("q_title"));//문의 
		dto.setQ_content(request.getParameter("q_content"));  //문의 내용
		dto.setQ_category(request.getParameter("q_category")); //문의 종류
		
		// 비밀글여부 체크
		String q_secret = request.getParameter("q_secret");
		System.out.println("비밀여부 => '"+ q_secret + "'");
		
		if ("on".equals(q_secret)) {
			dto.setQ_secret("Y");
		}
		else {
			dto.setQ_secret("N");
		}
		
		System.out.println("addQuestion => mapper"+dto);
		//문의 작성처리 
		dao.insertQuest(dto);
		
	}

	//[문의 목록]
	@Override
	public void questListAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("QnaServiceImpl - commentAddaction()");
		
		
		//화면에서 입력받은 값을 객체에 담기
		String pageNum = request.getParameter("pageNum");
		int pd_id = Integer.parseInt(request.getParameter("pd_id"));
		
		Paging paging = new Paging(pageNum);
		int total = dao.questCnt(pd_id);
		
		paging.setTotalCount(total);
		
		//문의글 목록 불러오기
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println(pd_id);
		
		map.put("start", start);
		map.put("end", end);
		map.put("pd_id", pd_id);
		
		List<QuestDTO> list = dao.questList(map);
		
		System.out.println(list);
		
		//6단계. jsp로 처리결과 전달
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
	}

	@Override
	public QuestDTO qnaDetail(int q_num) {
		//문의 번호 받아와서 객체에 담기
		QuestDTO dto = dao.questDetail(q_num);
		System.out.println(dto);
		return dto;
	}
	
	@Override
	public void updateQuestion(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		QuestDTO dto = new QuestDTO();
		
		int q_num = Integer.parseInt(request.getParameter("q_num"));
		String q_title = request.getParameter("q_title");
		String q_content = request.getParameter("q_content");
		String q_secret = request.getParameter("q_secret");
		String q_category = request.getParameter("q_category");
		
		dto.setQ_num(q_num);
		dto.setQ_title(q_title);
		dto.setQ_category(q_category);
		dto.setQ_content(q_content);
		// 비밀글 여부
		dto.setQ_secret(q_secret);
		
		System.out.println(dto);
		dao.updateQuest(dto);	//수정
	}
	
	public void deleteQuest(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		
		Integer q_num = Integer.parseInt(request.getParameter("q_num"));
		// 로그인 한 사람의 유저넘버 불러오기
		int u_member_id = (Integer)request.getSession().getAttribute("session_u_member_id");
		// 로그인한 사람이 작성자 본인이 맞는지 체크하기 위한 데이터 불러오기
		QuestDTO check = dao.questDetail(q_num);
		
		if(q_num != null && check.getU_member_id()==u_member_id) {//로그인 한 사람이 글 작성자 본인이라면
			dao.deleteQuest(q_num);
		}
	}
}


