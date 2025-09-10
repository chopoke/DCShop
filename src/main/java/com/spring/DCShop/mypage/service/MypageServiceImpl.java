package com.spring.DCShop.mypage.service;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.mypage.dao.MypageDAO;
import com.spring.DCShop.mypage.dto.CartDTO;
import com.spring.DCShop.mypage.dto.MyPetDTO;
import com.spring.DCShop.mypage.dto.MypageDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;

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
	
	
	// 정보수정 진입 전, 비밀번호체크
	@Override
	public int passwordCheck(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		Map<String, Object> map = new HashMap<>();
		String u_id = (String)request.getSession().getAttribute("sessionid");
		String u_password = request.getParameter("u_password");
		map.put("u_id", u_id);
		map.put("u_password", u_password);
		
		int result = myDao.pwdcheck(map);
		
		return result;
	}
	
	// 정보수정 페이지 user정보 get
	@Override
	public void findById(String loginId, Model model) {

		MypageDTO dto = myDao.getUserInfo(loginId);
		model.addAttribute("dto", dto);
	}
	
	// 정보 수정 처리
	@Override
	public void setUserInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		// input에 입력된 값 받아오기!
		String u_id = request.getParameter("u_id");
		String u_password = request.getParameter("u_password");
		String u_email = request.getParameter("u_email");
		String u_nickname = request.getParameter("u_nickname");
		Date u_birthday = Date.valueOf(request.getParameter("u_birth"));
		String temp_u_address = request.getParameter("u_address");
		// String temp_u_detailaddress = request.getParameter("u_detailaddress");
		String u_zip_code = request.getParameter("u_zip_code");
		String u_phone = request.getParameter("u_phone");
		
		System.out.println("비밀번호:" +u_password);
		
//		// 주소 합치기
//		String u_address = temp_u_address + temp_u_detailaddress;
		
		Map<String, Object> map = new HashMap<>();
		map.put("u_id", u_id);
		map.put("u_password", u_password);
		map.put("u_email", u_email);
		map.put("u_nickname", u_nickname);
		map.put("u_birthday", u_birthday);
		map.put("u_address", temp_u_address);
		map.put("u_phone", u_phone);
		map.put("u_zip_code", u_zip_code);
		
		int result = myDao.setUserInfo(map);
		System.out.println("서비스 setUser:" + result);
		
		
		// DB만 업데이트 되고, 세션은 적용되지 않음 -> 즉 마이페이지에선 이전 정보 그대로 보임 (로그아웃 하고 재 로그인해야 보임)
		// 수정된 정보로 바로 보여주기 위해서 세션 업데이트
		if(result == 1) {
			request.getSession().setAttribute("sessionid", u_id);
			request.getSession().setAttribute("sessionpw", u_password);
			request.getSession().setAttribute("session_u_nickname", u_nickname);
			request.getSession().setAttribute("session_u_email", u_email);
		}
	}
	
	
	// 프로필 사진 업뎃
	@Override
	public void profileUpdate(MultipartHttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{

		// input으로 받은거 가져오기
		MultipartFile file = request.getFile("u_image");
		String u_id = request.getParameter("u_id");
		
		if (file == null || file.isEmpty()) {
	        model.addAttribute("errorMsg", "파일이 비어 있습니다.");
	        return;
	    }
		
		// input경로 정의
		String saveDir = request.getSession()
                .getServletContext()
                .getRealPath("/resources/image/profile/");
		File dir = new File(saveDir);
		if (!dir.exists()) dir.mkdirs();
		
	    String savedName = file.getOriginalFilename();		// 원본파일명 그대로 저장
		file.transferTo(new File(saveDir, savedName));		// 저장!
			
		Map<String, Object> map = new HashMap<>();
		map.put("u_image", savedName);
		map.put("u_id", u_id);
		
		myDao.profileupdate(map);
		model.addAttribute("map", map);
			
	}



	@Override
	public void carListInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		System.out.println("MypageServiceImpl => carListInfo");

		int session_u_member_id = (Integer)request.getSession().getAttribute("session_u_member_id");
		
		Map<String, Object> productListInfo = new HashMap<String, Object>();
		
		productListInfo.put("u_member_id", session_u_member_id);
		
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


	@Override
	public void orderListInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		System.out.println("MypageServiceImpl => orderListInfo");
		
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
	}
		
	private String mapSize(Double w) {
	    if (w == null) return null;
	    if (w < 4)  return "소형";
	    if (w < 20) return "중형";
	    return "대형";
	}
	// 기존 펫 정보 가져오기
	public void getPetList(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Integer memberId = (Integer) request.getSession().getAttribute("session_u_member_id");		// 세션에 저장된 u_member_id 가져오기
		if (memberId == null) {
	        model.addAttribute("petList", java.util.Collections.emptyList());
	        return;
	    }
		List<MyPetDTO> petList = myDao.getPetList(memberId);
	    model.addAttribute("petList", petList);				// model에 넣어주기
	}
	
	// 반려동물 정보 수정 처리
	public void updatePetInfo(MyPetDTO pet, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Integer memberId = (Integer) request.getSession().getAttribute("session_u_member_id");		// 세션에 저장된 u_member_id 가져오기
		pet.setU_member_id(memberId);		// dto에 저장
		
		if (pet.getP_size() == null || pet.getP_size().isBlank()) {		// 펫 사이즈 정보가 null이 아닐때
	        pet.setP_size(mapSize(pet.getP_weight()));					// 사이즈 계산 -> 대형/중형/소형
	    }
		int cnt;
	    if (pet.getP_num() == null || pet.getP_num().isBlank()) {
	        // INSERT (트리거가 p_num 채움)
	    	System.out.println("서비스 insert DTO : "+pet);
	        cnt = myDao.petInfoInsert(pet);
	    } else {
	        // UPDATE
	    	System.out.println("서비스 update DTO : "+pet);
	        cnt = myDao.petInfoUpdate(pet);
	    }
	}
	
	// 반려동물 정보 삭제
	public int deletePetInfo(String p_num, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Integer memberId = (Integer) request.getSession().getAttribute("session_u_member_id");		// 세션에 저장된 u_member_id 가져오기
		Map<String, Object> map = new HashMap<>();
		map.put("p_num", p_num);
		map.put("u_member_id", memberId);
		return myDao.petInfoDelete(map);
	}
}
