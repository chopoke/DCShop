package com.spring.DCShop.join.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.join.dto.AgreeDTO;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	//약관 동의 항목 체크
	@Override
	public void totalAgreement(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("CustomerServiceImpl - totalAgreement");
		
		AgreeDTO agreementdto = new AgreeDTO();
		String terms = request.getParameter("agreeTerms");
		String privacy = request.getParameter("agreePrivacy");
		String third = request.getParameter("agreeThird");
		String marketing = request.getParameter("agreeMarketing");
		
		 //서비스 이용약관 동의여부
		if("Y".equals(terms)) {
			agreementdto.setAgreeTerms(terms);
		}
		else {
			agreementdto.setAgreeTerms("N");
		}
		
		//개인정보 수집 동의
		if("Y".equals(privacy)) {
			agreementdto.setAgreePrivacy(privacy); 
		}
		else {
			agreementdto.setAgreePrivacy("N");
		}
		
		//개인정보 제3자 제공 동의
		if("Y".equals(third)) {
			agreementdto.setAgreeThird(third); 
		}
		else {
			agreementdto.setAgreeThird("N");
		}
		
		//마케팅 수신 동의
		if("Y".equals(marketing)) {
			agreementdto.setAgreeMarketing(marketing);
		}
		else {
			agreementdto.setAgreeMarketing("N"); //마케팅 수신 비동의
		}
		
		//약관 동의 정보 넘기기
		model.addAttribute("agreementdto", agreementdto);
	}
}
