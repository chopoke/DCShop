package com.spring.DCShop.mypage.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.board.page.Paging;
import com.spring.DCShop.mypage.dao.MypageDAO;
import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;
import com.spring.DCShop.shop.dto.QuestDTO;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private MypageDAO myDao;
	
	private int productCountSum;
	private int productTotalPrice;
	
	private int cartCountSum;
	private int cartTotalPrice;
	
	public void getCartAndOrderList(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		System.out.println("MypageServiceImpl => getCartAndOrderList");
		
		// 공통 영역
		int session_u_member_id = (Integer)request.getSession().getAttribute("session_u_member_id");
		
		Map<String, Object> productListInfo = new HashMap<String, Object>();
		
		productListInfo.put("u_member_id", session_u_member_id);
		
		/** 주문내역 **/
		List<OrderDTO> orderList = myDao.getOrderList(productListInfo);
		
		productCountSum = 0;
		orderList.forEach(i -> {
			productCountSum += i.getO_Count();
		});

		productTotalPrice = 0;
		orderList.forEach(i -> {
			i.getProductDto().forEach(j -> {
				productTotalPrice += i.getO_Count() * j.getPdPrice();
			});
		});
		
		model.addAttribute("order", orderList);
		model.addAttribute("productCountSum", productCountSum);
		model.addAttribute("productTotalPrice", productTotalPrice);
		
		/** 장바구니 **/
		
		List<CartDTO> cartList = myDao.getCartList(productListInfo);

		System.out.println("cart" + cartList);
		
		cartCountSum = 0;
		cartList.forEach(i -> {
			cartCountSum += i.getCtQuantity();
		});

		cartTotalPrice = 0;
		cartList.forEach(i -> {
			i.getProductDto().forEach(j -> {
				cartTotalPrice += i.getCtQuantity() * j.getPdPrice();
			});
		});
		
		model.addAttribute("cart", cartList);
		model.addAttribute("cartCountSum", cartCountSum);
		model.addAttribute("cartTotalPrice", cartTotalPrice);
	}
	
	
	// 문의관리 - 문의 리스트 
 	@Override
 	public void myQnaList(HttpServletRequest request, HttpServletResponse response, Model model)
 			throws ServletException, IOException {
 		
 		//검색조건, user권한, paging에 대한 데이터를 담을 map.
 		Map<String, Object> map = new HashMap<String, Object>();
 		
 		//검색을 위한 검색 조건 체크.
 		String q_answer = request.getParameter("q_answer");
		String q_category = request.getParameter("q_category");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		
		// 문의목록 띄우기 전 조건의 null값을 체크. null이라면 map에 넣지 않음.
		if(q_answer != null){ map.put("q_answer", q_answer); }
		if(q_category != null){ map.put("q_category", q_category); }
		if(q_answer != null){ map.put("from", from); }
		if(q_answer != null){ map.put("to", to); }
		
		
		//페이지 요청 시 요청자의 권한 체크
		String u_role = (String)request.getSession().getAttribute(("session_u_role"));
		Integer sessionId = (Integer)(request.getSession().getAttribute(("session_u_member_id")));
		
		if(sessionId != null && u_role != null && ("USER"== u_role || "USER".equals(u_role))) {
			//페이지를 요청한 사람이 로그인을 하였고, 일반 회원이맞다면 타인의 문의를 조회하지 않기 위해 map에 담기.
			map.put("sessionId", sessionId);
		}
		else {	//로그인을 안했다면 그냥 리턴
			return;
		}
		
		//페이징
		String pageNum = request.getParameter("pageNum");
		
		Paging paging = new Paging(pageNum);
		
		int total = myDao.myQnaCnt(map);			// paging을 위한 갯수 호출
		
		paging.setTotalCount(total);
		
		map.put("start", paging.getStartRow());
		map.put("end", paging.getEndRow());
		
		List<QuestDTO> list = myDao.myQnaList(map);//list 호출
		
		System.out.println("list => "+list);
		
 		model.addAttribute("list", list);
 		model.addAttribute("paging", paging);
 	}
}
