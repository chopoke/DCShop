package com.spring.DCShop.mypage.dto;

import java.sql.Date;

public class MypageDTO {
	// 맴버 변수
   private String u_id;
   private String u_password;
   private String u_name;
   private int u_member_id;
   private String u_address;
   private int u_zip_code;
   private String u_phone;
   private String u_email;
   private Date u_birthday;
   private String u_nickname;
   private String u_show;
   private String u_image;
	public MypageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MypageDTO(String u_id, String u_password, String u_name, int u_member_id, String u_address, int u_zip_code,
			String u_phone, String u_email, Date u_birthday, String u_nickname, String u_show, String u_image) {
		super();
		this.u_id = u_id;
		this.u_password = u_password;
		this.u_name = u_name;
		this.u_member_id = u_member_id;
		this.u_address = u_address;
		this.u_zip_code = u_zip_code;
		this.u_phone = u_phone;
		this.u_email = u_email;
		this.u_birthday = u_birthday;
		this.u_nickname = u_nickname;
		this.u_show = u_show;
		this.u_image = u_image;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_password() {
		return u_password;
	}
	public void setU_password(String u_password) {
		this.u_password = u_password;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public int getU_member_id() {
		return u_member_id;
	}
	public void setU_member_id(int u_member_id) {
		this.u_member_id = u_member_id;
	}
	public String getU_address() {
		return u_address;
	}
	public void setU_address(String u_address) {
		this.u_address = u_address;
	}
	public int getU_zip_code() {
		return u_zip_code;
	}
	public void setU_zip_code(int u_zip_code) {
		this.u_zip_code = u_zip_code;
	}
	public String getU_phone() {
		return u_phone;
	}
	public void setU_phone(String u_phone) {
		this.u_phone = u_phone;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public Date getU_birthday() {
		return u_birthday;
	}
	public void setU_birthday(Date u_birthday) {
		this.u_birthday = u_birthday;
	}
	public String getU_nickname() {
		return u_nickname;
	}
	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}
	public String getU_show() {
		return u_show;
	}
	public void setU_show(String u_show) {
		this.u_show = u_show;
	}
	public String getU_image() {
		return u_image;
	}
	public void setU_image(String u_image) {
		this.u_image = u_image;
	}
	@Override
	public String toString() {
		return "MypageDTO [u_id=" + u_id + ", u_password=" + u_password + ", u_name=" + u_name + ", u_member_id="
				+ u_member_id + ", u_address=" + u_address + ", u_zip_code=" + u_zip_code + ", u_phone=" + u_phone
				+ ", u_email=" + u_email + ", u_birthday=" + u_birthday + ", u_nickname=" + u_nickname + ", u_show="
				+ u_show + ", u_image=" + u_image + "]";
	}
	   
   
}