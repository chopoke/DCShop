package com.spring.DCShop.shop.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.DCShop.shop.dao.OrderDAO;
import com.spring.DCShop.shop.dto.CheckoutRequest;
import com.spring.DCShop.shop.dto.OrderDTO;
import com.spring.DCShop.user.dto.UserDTO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	OrderDAO dao;
	
	// 결제자 정보
	public void orderUserAction(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("OrderServiceImpl - orderUserAction");
		
		int u_member_id = (Integer) request.getSession().getAttribute("session_u_member_id");
		
		UserDTO dto = dao.orderUserAction(u_member_id);
		System.out.println(dto);
		
		model.addAttribute("user", dto);
		
	}

	// 결제내역 저장
	@Override
	public void orderInsertAction(String jsonBody, JSONObject jsonObject, HttpServletRequest request) throws Exception {
		System.out.println("OrderServiceImpl - orderInsertAction()");
				
		JSONParser parser = new JSONParser();
		
        Long o_num;					// 주문번호(Pk)
        int pd_id;					// 상품 고유번호 (PK,FK)
        int u_member_id;			// 회원 아이디 (FK)
        String o_name;				// 주문자 이름
        String o_phone;				// 주문자 폰 번호
        int o_price;				// 주문가격
        int o_count;				// 주문개수
        String o_payment;			// 결제정보 (카드/네이버페이/카카오페이)
        String o_address;			// 배송주소
        int o_zip_code;				// 우편번호
        String o_request;			// 배송요청사항
        String o_status;			// 주문상태 (주문완료/환불/반품진행/교환진행)
        String o_payment_key;		// 결제키

        try {
        	JSONObject requestData = (JSONObject) parser.parse(jsonBody);
        	
        	JSONObject orderInfo = (JSONObject) requestData.get("orderInfo");
            System.out.println("orderInfo = " + orderInfo.toJSONString());
            
            // 공통정보
            // 숫자들은 JSONParser가 Long으로 파싱하므로 바로 캐스팅 후 intValue() 사용
            o_name = (String) orderInfo.get("o_name");
            o_phone = (String) orderInfo.get("o_phone");
            o_address = (String) orderInfo.get("o_address");
            o_zip_code = Integer.parseInt((String) orderInfo.get("o_zip_code"));
            o_request = (String)orderInfo.get("o_request");
            
            u_member_id = (Integer) request.getSession().getAttribute("session_u_member_id");
            o_num = Long.valueOf(jsonObject.get("orderId").toString());
            o_payment_key = (String) jsonObject.get("paymentKey");
            
            // 결제 수단
            String method = (String) jsonObject.get("method");
            if(method.equals("간편결제")) {
            	JSONObject easyPay = (JSONObject) jsonObject.get("easyPay");
            	o_payment = (String) easyPay.get("provider");
            } else {
            	o_payment = method;
            }
            
            // 결제 상태가 DONE 일 때 주문완료
            String status = (String) jsonObject.get("status");
            if(status.equals("DONE")) {
            	o_status = "주문완료";
            } else {
            	o_status = "";
            }

            // 상품 리스트
            JSONArray orderList = (JSONArray) orderInfo.get("orderList");
            for (Object obj : orderList) {
            	JSONObject product = (JSONObject) obj;
            	
            	pd_id = ((Long) product.get("pd_id")).intValue();
            	o_price = ((Long) product.get("o_price")).intValue();
                o_count = ((Long) product.get("o_count")).intValue();
                
                OrderDTO dto = new OrderDTO();
                
                dto.setO_num(o_num);
                dto.setPd_id(pd_id);
                dto.setU_member_id(u_member_id);
                dto.setO_name(o_name);
                dto.setO_phone(o_phone);
                dto.setO_price(o_price);
                dto.setO_count(o_count);
                dto.setO_payment(o_payment);
                dto.setO_address(o_address);
                dto.setO_zip_code(o_zip_code);
                dto.setO_request(o_request);
                dto.setO_status(o_status);
                dto.setO_payment_key(o_payment_key);
                
                System.out.println(dto);
                
                // 결제내역 저장
                dao.orderInsertAction(dto);
                
                Map<String, Object> p_map = new HashMap<String, Object>();
                p_map.put("pd_stock", o_count);
                p_map.put("pd_id", pd_id);
                // 재고수량 업데이트
                dao.productStockUpdate(p_map);
                
                int selectCnt = dao.cartCheck(u_member_id);
                
                if(selectCnt > 0) {
                	Map<String, Object> c_map = new HashMap<String, Object>();
                    c_map.put("u_member_id", u_member_id);
                    c_map.put("pd_id", pd_id);
                    // 장바구니 삭제
                    dao.cartDelete(c_map);
                }
                
            }
            
        } catch (ParseException e) {
            throw new RuntimeException(e);
        };
        
	    if (request.getSession() != null) {
	    	request.getSession().removeAttribute("goPay");
	    }
        
	}

}
