package com.spring.DCShop.mypage.dto;

import java.sql.Date;

public class MyPetDTO {
	private String p_num;      // 트리거가 넣음
    private int u_member_id;
    private String p_name;
    private String p_gender;   // 'M'/'F'
    private String p_type;     // '강아지'/'고양이'
    private Double p_weight;
    private String p_size;     // '대형'/'중형'/'소형'
    private Date p_birth;
    private String p_kind;
    private String p_neutered; // 'Y'/'N'
	public MyPetDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MyPetDTO(String p_num, int u_member_id, String p_name, String p_gender, String p_type, Double p_weight,
			String p_size, Date p_birth, String p_kind, String p_neutered) {
		super();
		this.p_num = p_num;
		this.u_member_id = u_member_id;
		this.p_name = p_name;
		this.p_gender = p_gender;
		this.p_type = p_type;
		this.p_weight = p_weight;
		this.p_size = p_size;
		this.p_birth = p_birth;
		this.p_kind = p_kind;
		this.p_neutered = p_neutered;
	}
	public String getP_num() {
		return p_num;
	}
	public void setP_num(String p_num) {
		this.p_num = p_num;
	}
	public int getU_member_id() {
		return u_member_id;
	}
	public void setU_member_id(int u_member_id) {
		this.u_member_id = u_member_id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_gender() {
		return p_gender;
	}
	public void setP_gender(String p_gender) {
		this.p_gender = p_gender;
	}
	public String getP_type() {
		return p_type;
	}
	public void setP_type(String p_type) {
		this.p_type = p_type;
	}
	public Double getP_weight() {
		return p_weight;
	}
	public void setP_weight(Double p_weight) {
		this.p_weight = p_weight;
	}
	public String getP_size() {
		return p_size;
	}
	public void setP_size(String p_size) {
		this.p_size = p_size;
	}
	public java.sql.Date getP_birth() {
		return p_birth;
	}
	public void setP_birth(java.sql.Date p_birth) {
		this.p_birth = p_birth;
	}
	public String getP_kind() {
		return p_kind;
	}
	public void setP_kind(String p_kind) {
		this.p_kind = p_kind;
	}
	public String getP_neutered() {
		return p_neutered;
	}
	public void setP_neutered(String p_neutered) {
		this.p_neutered = p_neutered;
	}
	@Override
	public String toString() {
		return "MyPetDTO [p_num=" + p_num + ", u_member_id=" + u_member_id + ", p_name=" + p_name + ", p_gender="
				+ p_gender + ", p_type=" + p_type + ", p_weight=" + p_weight + ", p_size=" + p_size + ", p_birth="
				+ p_birth + ", p_kind=" + p_kind + ", p_neutered=" + p_neutered + "]";
	}
    
    
}
