package com.spring.DCShop.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.shop.dao.ShopDAOImpl;
import com.spring.DCShop.shop.dto.ShopDTO;
import com.spring.DCShop.shop.page.Paging;

@Service
public class MainlistServiceImpl implements MainlistService{

	@Autowired
	private ShopDAOImpl dao;
	
	@Override
	public void getlist(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("ShopServiceImpl2 - productListAction");
		// 페이지 처리를 위해 화면에서 입력받은 pageNum 가져오기
		String pageNum = request.getParameter("pageNum");
		String sortOrder = request.getParameter("sortOrder");		// 정렬타입
		String keyword = request.getParameter("searchKeyword");
		String petType = request.getParameter("petType"); 
		String category = request.getParameter("category");			// 메인카테고리
		String subcategory = request.getParameter("subcategory");	// 서브카테고리
		// 가격
		String priceMin = request.getParameter("priceMin");
		String priceMax = request.getParameter("priceMax");
		
		
		// 게시글 갯수 
		Map<String, Object> map = new HashMap<>();
		Paging paging = new Paging(pageNum);
		
		
		// 상품 갯수를 가져오기 위해 전달할 Map 생성
		Map<String, Object> countP = new HashMap<>();
		countP.put("keyword", keyword);
		countP.put("petType", petType);
		countP.put("category", category);
		countP.put("subcategory", subcategory);
		countP.put("priceMin", priceMin);
		countP.put("priceMax", priceMax);
		// 전체 상품 수 조회 (+키워드에 맞게)
		int total = dao.productCnt(countP);
		System.out.println(total);
		// 페이징 객체에 전체 상품수 전달하깅!
		paging.setTotalCount(total);
		
		int start = paging.getStartRow();
		int end = paging.getEndRow();
		map.put("start", start);
		map.put("end", end);
		map.put("sortOrder", sortOrder);
		map.put("keyword", keyword);
		map.put("petType", petType);
		map.put("category", category);
		map.put("subcategory", subcategory);
		map.put("priceMin", priceMin);
		map.put("priceMax", priceMax);
		
		// (상품)리스트 출력 함수 호출
		List<ShopDTO> list_d = dao.productListAction1();
		List<ShopDTO> list_c = dao.productListAction2();
		
		System.out.println(list_d);
		System.out.println(list_c);

		model.addAttribute("list_d", list_d);
		model.addAttribute("list_c", list_c);
	}

}
