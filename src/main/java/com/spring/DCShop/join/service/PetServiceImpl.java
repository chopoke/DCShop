package com.spring.DCShop.join.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.DCShop.join.dao.CustomerDAO;
import com.spring.DCShop.join.dao.PetDAO;
import com.spring.DCShop.join.dto.CustomerDTO;
import com.spring.DCShop.join.dto.PetDTO;

@Service
public class PetServiceImpl implements PetService {

	@Autowired
	private PetDAO petDAO;

	@Autowired
	private CustomerDAO customerDAO;

	private static final ObjectMapper OM = new ObjectMapper();

	// 사용자 정보 및 펫 정보 등록
	// 원자성
	@Override 
	public boolean insertAction(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException { 
		System.out.println("PetServiceImpl - insertPetAction()"); 
		try { 
			// 1) 세션의 고객 
			CustomerDTO customer = (CustomerDTO) request.getSession().getAttribute("customerdto"); 
			System.out.println("출력[customer] => " + customer); 

			// 2) 고객 insert (+ selectKey로 u_member_id 채워짐) 
			customerDAO.insertCustomer(customer); 

			// 3) 펫 JSON 파싱 (없으면 빈 리스트) 
			String json = request.getParameter("petsJson"); 
			System.out.println("출력[json] => " + json); 
			List<PetDTO> petsDTO = (json != null && !json.trim().isEmpty()) 
					? OM.readValue(json, new TypeReference<List<PetDTO>>() {}) 
					: java.util.Collections.<PetDTO>emptyList();
			
			System.out.println("출력[petsDTO] => " + petsDTO); 
		
			// 4) 펫 FK 세팅 + 일괄 insert
			int expected = petsDTO.size(); 
			if (expected > 0) { 
				int fk = customer.getU_member_id(); 
				for (PetDTO p : petsDTO) { 
					System.out.println("[fk] => " + fk); 
					p.setU_member_id(fk); 
				} 
				petDAO.insertPet(petsDTO); 
			}
				
		} catch (Exception e) { 
			e.printStackTrace(); 
			return false; 
		}
		return true;
		
	}
}
