package com.spring.DCShop.shop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.DCShop.shop.dto.QuestDTO;
import com.spring.DCShop.shop.service.QnaService;

//Qna 상세 페이지 Modal에 데이터 넘기기위한 컨트롤러
@RestController
@RequestMapping("/api/qna")
public class QnaRestController {
	@Autowired
	private QnaService service;
	
	@GetMapping("/{q_num}")
	public ResponseEntity<QuestDTO> getDetail(HttpServletRequest res, @PathVariable int q_num) {
		//질문 객체 생성
		QuestDTO dto = service.qnaDetail(q_num);
		
		System.out.println(dto);
	    // 2. 문의글이 존재하지 않는 경우
	    if (dto == null) {
	        return ResponseEntity.notFound().build(); // 404 Not Found
	    }
		//세션아이디 조회
		Integer sessionId = (Integer)res.getSession().getAttribute("session_u_member_id");
		// 4. 비밀글인 경우 접근 권한 확인
	    if ("Y".equals(dto.getQ_secret())) {
	        // 로그인 상태가 아닌 경우 (세션에 userId가 null 또는 0)
	        if (sessionId == null || sessionId == 0) {
	            return ResponseEntity.status(401).build(); // 401 Unauthorized: 로그인 필요
	        }
	        // 로그인한 사용자와 작성자의 ID가 다른 경우
	        if (dto.getU_member_id() != sessionId) {
	            return ResponseEntity.status(403).build(); // 403 Forbidden: 접근 금지
	        }
	    }
	
	    // 5. 일반글이거나, 비밀글의 작성자 본인인 경우 DTO 반환
	    return ResponseEntity.ok(dto);
	}
}