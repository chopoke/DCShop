package com.spring.DCShop.shop.dto;

import java.sql.Date;

public class OrderDTO {
	
	private Long o_num;		// 주문번호(Pk)
	private int pd_id;		// 상품 고유번호 (PK,FK)
	private int u_member_id;	// 회원 아이디 (FK)
	private String o_name;		// 주문자 이름
	private String o_phone;		// 주문자 폰 번호
	private Date o_date;	// 주문일
	private int o_price;	// 주문가격
	private String o_delivery_state; 	// 배송상태 (배송중/배송완료)
	private Date o_delivery_date;		// 배송완료일
	private int o_count;				// 주문개수
	private String o_payment;			// 결제정보 (카드/네이버페이/카카오페이)
	private String o_address;			// 배송주소
	private int o_zip_code;				// 우편번호
	private String o_request;			// 배송요청사항
	private String o_status;			// 주문상태 (주문완료/환불/반품진행/교환진행)
	private String o_payment_key;		// 결제키
	
	public OrderDTO() {
		super();
	}
	
	public OrderDTO(Long o_num, int pd_id, int u_member_id, String o_name, String o_phone, Date o_date, int o_price,
			String o_delivery_state, Date o_delivery_date, int o_count, String o_payment, String o_address,
			int o_zip_code, String o_request, String o_status, String o_payment_key) {
		super();
		this.o_num = o_num;
		this.pd_id = pd_id;
		this.u_member_id = u_member_id;
		this.o_name = o_name;
		this.o_phone = o_phone;
		this.o_date = o_date;
		this.o_price = o_price;
		this.o_delivery_state = o_delivery_state;
		this.o_delivery_date = o_delivery_date;
		this.o_count = o_count;
		this.o_payment = o_payment;
		this.o_address = o_address;
		this.o_zip_code = o_zip_code;
		this.o_request = o_request;
		this.o_status = o_status;
		this.o_payment_key = o_payment_key;
	}
	
	public Long getO_num() {
		return o_num;
	}
	public void setO_num(Long o_num) {
		this.o_num = o_num;
	}
	
	public int getPd_id() {
		return pd_id;
	}
	public void setPd_id(int pd_id) {
		this.pd_id = pd_id;
	}
	
	public int getU_member_id() {
		return u_member_id;
	}
	public void setU_member_id(int u_member_id) {
		this.u_member_id = u_member_id;
	}
	
	public String getO_name() {
		return o_name;
	}
	public void setO_name(String o_name) {
		this.o_name = o_name;
	}
	
	public String getO_phone() {
		return o_phone;
	}
	public void setO_phone(String o_phone) {
		this.o_phone = o_phone;
	}
	
	public Date getO_date() {
		return o_date;
	}
	public void setO_date(Date o_date) {
		this.o_date = o_date;
	}
	
	public int getO_price() {
		return o_price;
	}
	public void setO_price(int o_price) {
		this.o_price = o_price;
	}
	
	public String getO_delivery_state() {
		return o_delivery_state;
	}
	public void setO_delivery_state(String o_delivery_state) {
		this.o_delivery_state = o_delivery_state;
	}
	
	public Date getO_delivery_date() {
		return o_delivery_date;
	}
	public void setO_delivery_date(Date o_delivery_date) {
		this.o_delivery_date = o_delivery_date;
	}
	
	public int getO_count() {
		return o_count;
	}
	public void setO_count(int o_count) {
		this.o_count = o_count;
	}
	
	public String getO_payment() {
		return o_payment;
	}
	public void setO_payment(String o_payment) {
		this.o_payment = o_payment;
	}
	
	public String getO_address() {
		return o_address;
	}
	public void setO_address(String o_address) {
		this.o_address = o_address;
	}
	
	public int getO_zip_code() {
		return o_zip_code;
	}
	public void setO_zip_code(int o_zip_code) {
		this.o_zip_code = o_zip_code;
	}
	
	public String getO_request() {
		return o_request;
	}
	public void setO_request(String o_request) {
		this.o_request = o_request;
	}
	
	public String getO_status() {
		return o_status;
	}
	public void setO_status(String o_status) {
		this.o_status = o_status;
	}
	
	public String getO_payment_key() {
		return o_payment_key;
	}
	public void setO_payment_key(String o_payment_key) {
		this.o_payment_key = o_payment_key;
	}
	
	@Override
	public String toString() {
		return "OrderDTO [o_num=" + o_num + ", pd_id=" + pd_id + ", u_member_id=" + u_member_id + ", o_name=" + o_name
				+ ", o_phone=" + o_phone + ", o_date=" + o_date + ", o_price=" + o_price + ", o_delivery_state="
				+ o_delivery_state + ", o_delivery_date=" + o_delivery_date + ", o_count=" + o_count + ", o_payment="
				+ o_payment + ", o_address=" + o_address + ", o_zip_code=" + o_zip_code + ", o_request=" + o_request
				+ ", o_status=" + o_status + ", o_payment_key=" + o_payment_key + "]";
	}
	
}
