package com.spring.DCShop.mypage.dto;

import java.sql.Date;
import java.util.List;

public class OrderDTO {

	private int o_Num;
	private int pd_Id;
	private int u_Member_Id;
	private String o_name;
	private String o_phone;
	private Date o_date;
	private int o_price;
	private String o_Delivery_State;
	private Date o_Delivery_Date;
	private int o_Count;
	private String o_Payment;
	private String o_Address;
	private int o_Zip_Code;
	private String o_Request;
	private String o_Status;
	private String o_payment_key;
	private List<ProductDTO> productDto;
	
	public OrderDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderDTO(int o_Num, int pd_Id, int u_Member_Id, String o_name, String o_phone, Date o_date, int o_price,
			String o_Delivery_State, Date o_Delivery_Date, int o_Count, String o_Payment, String o_Address,
			int o_Zip_Code, String o_Request, String o_Status, String o_payment_key, List<ProductDTO> productDto) {
		super();
		this.o_Num = o_Num;
		this.pd_Id = pd_Id;
		this.u_Member_Id = u_Member_Id;
		this.o_name = o_name;
		this.o_phone = o_phone;
		this.o_date = o_date;
		this.o_price = o_price;
		this.o_Delivery_State = o_Delivery_State;
		this.o_Delivery_Date = o_Delivery_Date;
		this.o_Count = o_Count;
		this.o_Payment = o_Payment;
		this.o_Address = o_Address;
		this.o_Zip_Code = o_Zip_Code;
		this.o_Request = o_Request;
		this.o_Status = o_Status;
		this.o_payment_key = o_payment_key;
		this.productDto = productDto;
	}

	public int getO_Num() {
		return o_Num;
	}

	public void setO_Num(int o_Num) {
		this.o_Num = o_Num;
	}

	public int getPd_Id() {
		return pd_Id;
	}

	public void setPd_Id(int pd_Id) {
		this.pd_Id = pd_Id;
	}

	public int getU_Member_Id() {
		return u_Member_Id;
	}

	public void setU_Member_Id(int u_Member_Id) {
		this.u_Member_Id = u_Member_Id;
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

	public String getO_Delivery_State() {
		return o_Delivery_State;
	}

	public void setO_Delivery_State(String o_Delivery_State) {
		this.o_Delivery_State = o_Delivery_State;
	}

	public Date getO_Delivery_Date() {
		return o_Delivery_Date;
	}

	public void setO_Delivery_Date(Date o_Delivery_Date) {
		this.o_Delivery_Date = o_Delivery_Date;
	}

	public int getO_Count() {
		return o_Count;
	}

	public void setO_Count(int o_Count) {
		this.o_Count = o_Count;
	}

	public String getO_Payment() {
		return o_Payment;
	}

	public void setO_Payment(String o_Payment) {
		this.o_Payment = o_Payment;
	}

	public String getO_Address() {
		return o_Address;
	}

	public void setO_Address(String o_Address) {
		this.o_Address = o_Address;
	}

	public int getO_Zip_Code() {
		return o_Zip_Code;
	}

	public void setO_Zip_Code(int o_Zip_Code) {
		this.o_Zip_Code = o_Zip_Code;
	}

	public String getO_Request() {
		return o_Request;
	}

	public void setO_Request(String o_Request) {
		this.o_Request = o_Request;
	}

	public String getO_Status() {
		return o_Status;
	}

	public void setO_Status(String o_Status) {
		this.o_Status = o_Status;
	}

	public String getO_payment_key() {
		return o_payment_key;
	}

	public void setO_payment_key(String o_payment_key) {
		this.o_payment_key = o_payment_key;
	}

	public List<ProductDTO> getProductDto() {
		return productDto;
	}

	public void setProductDto(List<ProductDTO> productDto) {
		this.productDto = productDto;
	}

	@Override
	public String toString() {
		return "OrderDTO [o_Num=" + o_Num + ", pd_Id=" + pd_Id + ", u_Member_Id=" + u_Member_Id + ", o_name=" + o_name
				+ ", o_phone=" + o_phone + ", o_date=" + o_date + ", o_price=" + o_price + ", o_Delivery_State="
				+ o_Delivery_State + ", o_Delivery_Date=" + o_Delivery_Date + ", o_Count=" + o_Count + ", o_Payment="
				+ o_Payment + ", o_Address=" + o_Address + ", o_Zip_Code=" + o_Zip_Code + ", o_Request=" + o_Request
				+ ", o_Status=" + o_Status + ", o_payment_key=" + o_payment_key + ", productDto=" + productDto + "]";
	}
	
}
