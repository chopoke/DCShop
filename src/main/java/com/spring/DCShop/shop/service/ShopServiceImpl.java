package com.spring.DCShop.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.shop.dao.ShopDAO;
import com.spring.DCShop.shop.dto.ShopDTO;
import com.spring.DCShop.shop.page.Paging;

@Service
public class ShopServiceImpl implements ShopService{

	@Autowired
	private ShopDAO dao;
	
	@Override
	public void productListAction(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		// 페이지 처리를 위해 화면에서 입력받은 pageNum 가져오기
		String pageNum = request.getParameter("pageNum");
		String sortOrder = request.getParameter("sortOrder");		// 정렬타입
		String keyword = request.getParameter("searchKeyword");		// 검색어
		String petType = request.getParameter("petType"); 			// 동물타입
		String category = request.getParameter("category");			// 메인카테고리
		String subcategory = request.getParameter("subcategory");	// 서브카테고리
		String event = request.getParameter("event");
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
		if ("1".equals(event)) {
			countP.put("event", "1");
		}
		// 전체 상품 수 조회 (+키워드에 맞게)
		int total = dao.productCnt(countP);
		
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
		if ("1".equals(event)) {
			map.put("event", "1");
		}
		
		// (상품)리스트 출력 함수 호출
		List<ShopDTO> list = dao.productListAction(map);
		
		System.out.println(list);
		
		if(category != null && !category.trim().isEmpty()) {
			int categoryI = Integer.parseInt(category);
			List<Integer> cateList = dao.getSubcategory(categoryI);
			model.addAttribute("cateList",cateList);
		}
		
		
		Map<Integer, String> dogcategoryNames = new HashMap<>();
		dogcategoryNames.put(1101, "대형");
		dogcategoryNames.put(1102, "중형");
		dogcategoryNames.put(1103, "소형");
		dogcategoryNames.put(1201, "샴푸");
		dogcategoryNames.put(1202, "미용가위");
		dogcategoryNames.put(1203, "구강관리");
		dogcategoryNames.put(1204, "타올");
		dogcategoryNames.put(1205, "발톱깎이");
		dogcategoryNames.put(1301, "배변패드");
		dogcategoryNames.put(1302, "기저귀");
		dogcategoryNames.put(1401, "공");
		dogcategoryNames.put(1402, "원반");
		dogcategoryNames.put(1403, "터그");
		dogcategoryNames.put(1404, "인형");
		dogcategoryNames.put(1501, "목줄");
		dogcategoryNames.put(1502, "하네스");
		dogcategoryNames.put(1503, "리드줄");
		dogcategoryNames.put(1504, "자동줄");
		Map<Integer, String> catcategoryNames = new HashMap<>();
		catcategoryNames.put(2101, "대형");
		catcategoryNames.put(2102, "중형");
		catcategoryNames.put(2103, "소형");
		catcategoryNames.put(2201, "샴푸");
		catcategoryNames.put(2202, "미용가위");
		catcategoryNames.put(2203, "구강관리");
		catcategoryNames.put(2204, "타올");
		catcategoryNames.put(2205, "발톱깎이");
		catcategoryNames.put(2301, "응고형두부모래");
		catcategoryNames.put(2302, "흡수형실리카겔모래");
		catcategoryNames.put(2401, "낚시대");
		catcategoryNames.put(2402, "공");
		catcategoryNames.put(2403, "막대");
		catcategoryNames.put(2501, "캣타워형");
		catcategoryNames.put(2502, "패드형");
		catcategoryNames.put(2503, "하우스형");

		model.addAttribute("dogcategoryNames", dogcategoryNames);
		model.addAttribute("catcategoryNames", catcategoryNames);
		
		
		model.addAttribute("list", list);
		model.addAttribute("paging",paging);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("keyword", keyword);
		model.addAttribute("petType", petType);
		model.addAttribute("total", total);
		model.addAttribute("category", category);
		model.addAttribute("subcategory", subcategory);
	}

}
