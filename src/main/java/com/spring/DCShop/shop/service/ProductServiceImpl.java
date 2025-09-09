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

import com.spring.DCShop.shop.dao.ProductDAO;
import com.spring.DCShop.shop.dao.ReviewDAO;
import com.spring.DCShop.shop.dto.ProductDTO;
import com.spring.DCShop.shop.dto.ReviewDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDAO dao;
	
	@Autowired
	private ReviewDAO rdao;
	
	
	// 상품상세페이지
	@Override
	public void productDetailAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("ProductServiceImpl - productDetailAction");
		
		// pd_id 안전 파싱
	    int pdId;
	    try {
	        String s = request.getParameter("pdId");
	        System.out.println("ss" + s);
	        pdId = (s == null || s.isEmpty()) ? 1 : Integer.parseInt(s);
	    } catch (NumberFormatException e) {
	        pdId = 1;
	    }

	    // 상품 상세
	    ProductDTO dto = dao.productDetail(pdId);

	    // 최신 5개 리뷰 + 총 리뷰 수
	    List<ReviewDTO> recent = rdao.recentReviews(pdId);
	    int revCount = rdao.reviewCnt(pdId);

	    // 평균(0~5로 가드)
	    Double avg = rdao.avgScoreByProduct(pdId);
	    double avgScore = (avg == null) ? 0.0 : avg;
	    avgScore = Math.max(0.0, Math.min(5.0, avgScore));

	    // 0.5 단위로 반올림
	    double avg05 = Math.round(avgScore * 2.0) / 2.0;

	    // 별 개수 계산 (avg05는 정수 또는 .5만 나옴)
	    int full  = (int) avg05;           // 꽉 별
	    int half  = (avg05 > full) ? 1 : 0; // 반 별 (정확하고 간단)
	    int empty = 5 - full - half;       // 빈 별
	    
	    int fillPct = (int) Math.round((avg05 / 5.0) * 100);
	    
	    model.addAttribute("dto", dto);
	    model.addAttribute("recentReviews", recent);
	    model.addAttribute("revCount", revCount);
	    model.addAttribute("pd_id", pdId);

	    // 모델
	    model.addAttribute("avgScore", avgScore);   // 숫자 표기용(예: 3.6)
	    model.addAttribute("avg05", avg05);         // 반별 표현용(예: 3.5)
	    model.addAttribute("fullStars", full);
	    model.addAttribute("halfStar", half);
	    model.addAttribute("emptyStars", empty);
	    model.addAttribute("fillPct", fillPct);
	    
	}
}
