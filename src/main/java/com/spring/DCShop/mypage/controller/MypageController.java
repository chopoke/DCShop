package com.spring.DCShop.mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.DCShop.mypage.dto.MyPetDTO;
import com.spring.DCShop.mypage.service.MypageService;



@Controller
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private MypageService myService;
	
	
	@RequestMapping("mypage_main.do")
	public String mypage_main(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("=== url -> mypage_main ===");
		
		String sessionid = (String)request.getSession().getAttribute("sessionid");
		
		if(sessionid == null) {
			return "user/login/login_main";
		}
		
		// 주문 상품 리스트와 장바구니 리스트 가져와서 뿌려주기
		myService.getCartAndOrderList(request, response, model);
		
		// 세셔정보 없으면 만들어주고 있으면 가져오기
		HttpSession session = request.getSession(false);
	    String loginId = (String) session.getAttribute("sessionid");
	    myService.findById(loginId, model);
		
		return "/mypage/mypage_main";
	}
	
	// 비밀번호 체크
	@RequestMapping("mypage_pwdcheck.do")
	public String pwdcheck(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> mypage_pwdcheck ===");
		HttpSession session = request.getSession(false);
	    if (session != null) {
	        String loginId = (String) session.getAttribute("sessionid");
	        if (loginId != null) {
	            myService.findById(loginId, model); 
	        }
	    }
		
		return "/mypage/mypage_pwdcheck";
	}
	
	// 정보 수정을 위한 비밀번호 체크 처리
	@RequestMapping("mypage_pwdcheckAction.do")
	public String pwdcheckAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> mypage_editinfo ===");
		
		HttpSession session = request.getSession(false);
	    if (session != null) {
	        String loginId = (String) session.getAttribute("sessionid");
	        if (loginId != null) {
	            myService.findById(loginId, model);
	        }
	    }
		
		int res = myService.passwordCheck(request, response, model);
		if (res == 1) {
            // 성공: 수정 폼으로 이동
			System.out.println("로그인 성공");
            return "redirect:mypage_editinfo.do";
	    }else {
	    	System.out.println("로그인 실패");
	    	model.addAttribute("errorMsg", "비밀번호가 올바르지 않습니다.");
	    	return "redirect:mypage_pwdcheck.do";
	    }
	}
	// 정보 수정 페이지
	@RequestMapping("mypage_editinfo.do")
	public String editInfo(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> mypage_editinfo ===");
		
		// 세션에서 로그인 사용자 식별
		HttpSession session = request.getSession(false);
	    if (session != null) {
	        String loginId = (String) session.getAttribute("sessionid");
	        if (loginId != null) {
	            myService.findById(loginId, model);
	        }
	    }
	    else {
	    	return "login_main.do";
	    }
		return "mypage/mypage_editinfo";
	}
	
	// 정보 수정 처리
	@RequestMapping("mypage_editinfoAction.do")
	public String editInfoAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> mypage_editinfoAction ===");
		
		myService.setUserInfo(request, response, model);
		return "redirect:/mypage_main.do";
	}
	
	// 이미지 업로드(프로필)
	@RequestMapping("mypage_imgUpload.do")
	public String uploadProfile(MultipartHttpServletRequest multi, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> mypage_uploadProfile ===");
		myService.profileUpdate(multi, res, model);
		
		return "redirect:mypage_main.do";
	}
	
	
	// 반려동물 정보 수정페이지 
	@RequestMapping("mypage_editPet.do")
	public String mypage_editPet(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> mypage_editPet ===");
		
		HttpSession session = req.getSession(false);
	    if (session == null || session.getAttribute("sessionid") == null) {
	        return "redirect:login_main.do";
	    }
        String loginId = (String) session.getAttribute("sessionid");
        myService.findById(loginId, model);
        myService.getPetList(req, res, model);
		return "mypage/mypage_editPet";
	}
	
	
	@PostMapping("/mypage/pets/save")
	public String saveOne(@ModelAttribute MyPetDTO pet, HttpServletRequest req, HttpServletResponse res, Model model) {
	    myService.updatePetInfo(pet, req, res, model);
	    
	    return "redirect:/mypage_editPet.do"; // 목록 페이지로
	}

	// 장바구니 페이지 이동
	@RequestMapping("cartList")
	public String cartList(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> cartList ===");
		
		String sessionid = (String)req.getSession().getAttribute("sessionid");
		
		if(sessionid == null) {
			return "user/login/login_main";
		}
		
		myService.carListInfo(req, res, model);
		
		return "mypage/cartList";
	}
	
	// 장바구니 페이지 이동
	@RequestMapping("recommendProduct")
	public String recommendProduct(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> recommendProduct ===");
		
//		String sessionid = (String)req.getSession().getAttribute("sessionid");
//		
//		if(sessionid == null) {
//			return "user/login/login_main";
//		}

		return "mypage/recommanedProduct";
	}
	
	// 주문내역 페이지 이동
	@RequestMapping("orderList")
	public String orderList(HttpServletRequest req, HttpServletResponse res, Model model)
			throws ServletException, IOException{
		logger.info("=== url -> orderList ===");
		
		String sessionid = (String)req.getSession().getAttribute("sessionid");
		
		if(sessionid == null) {
			return "user/login/login_main";
		}
		
		myService.orderListInfo(req, res, model);
		
		return "mypage/orderList";
	}

	@PostMapping(value = "/mypage/pets/delete", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam String p_num, HttpServletRequest req, HttpServletResponse res, Model model) {
	    int cnt = myService.deletePetInfo(p_num, req, res, model);
	    Map<String, Object> result = new HashMap<>();
	    result.put("ok", cnt == 1);
	    return result;

	}
}
