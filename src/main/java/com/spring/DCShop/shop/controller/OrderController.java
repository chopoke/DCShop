package com.spring.DCShop.shop.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.DCShop.shop.service.OrderServiceImpl;

@Controller
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderServiceImpl service;

	@RequestMapping("/checkout")
	public String checkout(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		logger.info("<<< url => pay >>>");
		
		System.out.println(request.getSession().getAttribute("goPay"));
		service.orderUserAction(request, response, model);

		return "shop/pay";
	}

	
	@RequestMapping("/pay_success") 
	public String success(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException { 
		logger.info("<<< url => success >>>");
		
		return "shop/pay_success"; 
	}
	 
	@RequestMapping("/pay_fail") 
	public String fail(HttpServletRequest request, HttpServletResponse response, Model model) 
			throws ServletException, IOException { 
		logger.info("<<< url => fail >>>");
		
		System.out.println(request.getParameter("message"));
		System.out.println(request.getParameter("code"));
		
		model.addAttribute("message", request.getParameter("message"));
		model.addAttribute("code", request.getParameter("code"));
	    
		return "shop/pay_fail"; 
	}
	 
	@RequestMapping("/pay_confirm")
	@ResponseBody
    public ResponseEntity<JSONObject> confirmPayment(@RequestBody String jsonBody, HttpServletRequest request) throws Exception {
		logger.info("<<< url => confirm >>>");
		
        JSONParser parser = new JSONParser();
        Long orderId;
        String amount;
        // 결제의 키값. 최대 길이는 200자. 결제 승인, 결제 조회, 결제 취소 API에 사용된다.
        String paymentKey;
        
        try {
            // 클라이언트에서 받은 JSON 요청 바디입니다.
            JSONObject requestData = (JSONObject) parser.parse(jsonBody);
            paymentKey = (String) requestData.get("paymentKey");
            orderId = Long.valueOf(requestData.get("orderId").toString());
            amount = (String) requestData.get("amount");
            
        } catch (ParseException e) {
            throw new RuntimeException(e);
        };
        
        System.out.println("orderId = " + orderId);
        System.out.println("amount = " + amount);
        System.out.println("paymentKey = " + paymentKey);

        
        JSONObject obj = new JSONObject();
        obj.put("orderId", orderId);
        obj.put("amount", amount);
        obj.put("paymentKey", paymentKey);
        
        // 시크릿키로 Basic 인증 헤더 설정
        // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);
        
        // 결제 승인 API 호출
        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        
        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(obj.toString().getBytes("UTF-8"));
        
        int code = connection.getResponseCode();
        boolean isSuccess = code == 200;	// 결제 승인에 성공하면 HTTP 200 OK와 Payment 객체를 받는다.
        
        System.out.println("code = " + code);
        System.out.println("isSuccess = " + isSuccess);
        
        // 결제 승인 결과 확인하기
        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
        
        // 결제 성공 및 실패 비즈니스 로직을 구현하세요.
        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
        JSONObject jsonObject = (JSONObject) parser.parse(reader);
        responseStream.close();
        
        if(isSuccess) {
        	// 결제가 정상적으로 승인이 되었다면 DB에 저장
        	service.orderInsertAction(jsonBody, jsonObject, request);
        }

        
        // 결제 정보
        System.out.println("jsonObject = " + jsonObject);
        // 결제 승인 여부 + 정보
        System.out.println("return = " + ResponseEntity.status(code).body(jsonObject));

        return ResponseEntity.status(code).body(jsonObject);
	}
}
