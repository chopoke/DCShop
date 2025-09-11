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

import com.spring.DCShop.shop.dao.WishDAO;
import com.spring.DCShop.shop.dto.WishDTO;

@Service
public class WishServiceImpl implements WishService{

	@Autowired
	private WishDAO dao;
	
	// 찜 목록(마이페이지)
	public void getWishList(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		System.out.println(" ====== wish service - getWishList ====== ");
		
		Integer memberUid = (Integer) req.getSession().getAttribute("session_u_member_id");
		if (memberUid == null) {
		    // 비로그인 처리 (원하는 동작으로)
		    model.addAttribute("wishList", java.util.Collections.emptyList());
		    return;
		}
		List<WishDTO> list = dao.getWishList(memberUid);
		System.out.println("[wish] list size = " + (list == null ? 0 : list.size()));
		model.addAttribute("wishList", list);
	}

	
	//------------------------------------------------------------------
	// 찜 여부(상품페이지)
	@Override
	public void serIsWish(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException {
		
		Map<String, Object> map = new HashMap<>();
		// 세션에 저장된 u_id(회원번호)
		Integer memberId = (Integer) req.getSession().getAttribute("session_u_member_id");
		if(memberId == null || String.valueOf(memberId).isBlank()) {
			model.addAttribute("isWish", 0);
			return;
		}
		int pd_id = Integer.parseInt(req.getParameter("pdId"));
		map.put("u_member_id", memberId);
		map.put("pd_id", pd_id);
		
		// 찜 여부
		int result = dao.isWish(map);
		System.out.println("서비스 위시 : "+result);
		model.addAttribute("isWish", result > 0 ? 1 : 0);
		model.addAttribute("pd_id", pd_id);
	}
	
	
	// 상품당 찜 갯수
	@Override
	public void serPdWishCount(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException {
		
		int pd_id = Integer.parseInt(req.getParameter("pdId"));
		int result = dao.pdWishCount(pd_id);
		model.addAttribute("productWishCnt", result);
	}

	// 찜추가
	@Override
	public int serAddWish(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException {

		int pd_id = Integer.parseInt(req.getParameter("pdId"));
		int click = Integer.parseInt(req.getParameter("click"));
		
		// 회원 번호
		Integer memberUid = (Integer) req.getSession().getAttribute("session_u_member_id");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pd_id", pd_id);
		map.put("u_member_id", memberUid);
		
		// ㅋ
		int suc = (click == 1) ? dao.addWish(map) : dao.removeWish(map);
		return suc > 0 ? 1 : 0;
	}
		
	
	// 찜삭제
	@Override
	public int serRemoveWish(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		return 0;
	}


	// 찜 바로 반응용
	@Override
	public int getPdWishCount(int pdId) {
	    return dao.pdWishCount(pdId);
	}
	
	
}
