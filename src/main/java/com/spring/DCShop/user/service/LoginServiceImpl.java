package com.spring.DCShop.user.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.board.dao.BoardDAO;
import com.spring.DCShop.user.dao.LoginDAO;
import com.spring.DCShop.user.dto.UserDTO;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDAO dao;
	@Autowired
	private BoardDAO boardDao;
	
	@Override
	public void loginaction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("CustomerServiceImpl - loginaction");
		
		String id = request.getParameter("user_id");
		String pw = request.getParameter("user_password");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		
//		int test = 0;
//		String test1 = "";
//		String test2 = "";
//		String test3 = "";
		UserDTO dto = dao.idpasswordchk(map);
		//6. 로그인 성공시 세션 id를 설정
		if(dto != null) {
			request.getSession().setAttribute("sessionid", id);
			request.getSession().setAttribute("sessionpw", pw);
			request.getSession().setAttribute("session_u_member_id", dto.getU_member_id());
			request.getSession().setAttribute("session_u_nickname", dto.getU_nickname());
			request.getSession().setAttribute("session_u_email", dto.getU_email());
			request.getSession().setAttribute("session_u_phone", dto.getU_phone());
//			test = (Integer)request.getSession().getAttribute("session_u_member_id");
//			test1 = (String)request.getSession().getAttribute("session_u_nickname");
//			test2 = (String)request.getSession().getAttribute("session_u_email");
//			test3 = (String)request.getSession().getAttribute("session_u_phone");
			
		}
//		System.out.println("test : " + test + ", " + test1 + ", " + test2 + ", " + test3);
	}

}
