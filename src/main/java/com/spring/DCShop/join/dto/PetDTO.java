package com.spring.DCShop.join.dto;

import java.sql.Date;

public class PetDTO {

	private int pet_num;
	private Integer u_member_id;
	private String pet_name;
	private Date pet_birthday;
	private String pet_type;
	private String pet_kind;
	private String pet_gender;
	private double pet_kg;
	private String pet_size;
	private String pet_neutered;
	
	public PetDTO() {
		super();
	}

	public PetDTO(int pet_num, String pet_name, Date pet_birthday, String pet_type, String pet_kind, String pet_gender,
			double pet_kg, Integer u_member_id, String pet_size, String pet_neutered) {
		super();
		this.pet_num = pet_num;
		this.u_member_id = u_member_id;
		this.pet_name = pet_name;
		this.pet_gender = pet_gender;
		this.pet_type = pet_type;
		this.pet_kg = pet_kg;
		this.pet_size = pet_size;
		this.pet_birthday = pet_birthday;
		this.pet_kind = pet_kind;
		this.pet_neutered = pet_neutered;
	}

	public int getPet_num() {
		return pet_num;
	}

	public void setPet_num(int pet_num) {
		this.pet_num = pet_num;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public Date getPet_birthday() {
		return pet_birthday;
	}

	public void setPet_birthday(Date pet_birthday) {
		this.pet_birthday = pet_birthday;
	}

	public String getPet_type() {
		return pet_type;
	}

	public void setPet_type(String pet_type) {
		this.pet_type = pet_type;
	}

	public String getPet_kind() {
		return pet_kind;
	}

	public void setPet_kind(String pet_kind) {
		this.pet_kind = pet_kind;
	}

	public String getPet_gender() {
		return pet_gender;
	}

	public void setPet_gender(String pet_gender) {
		this.pet_gender = pet_gender;
	}

	public double getPet_kg() {
		return pet_kg;
	}

	public void setPet_kg(double pet_kg) {
		this.pet_kg = pet_kg;
	}

	public Integer getU_member_id() {
		return u_member_id;
	}

	public void setU_member_id(Integer u_member_id) {
		this.u_member_id = u_member_id;
	}

	public String getPet_size() {
		return pet_size;
	}

	public void setPet_size(String pet_size) {
		this.pet_size = pet_size;
	}

	public String getPet_neutered() {
		return pet_neutered;
	}

	public void setPet_neutered(String pet_neutered) {
		this.pet_neutered = pet_neutered;
	}

	@Override
	public String toString() {
		return "PetDTO [pet_num=" + pet_num + ", pet_name=" + pet_name + ", pet_birthday=" + pet_birthday
				+ ", pet_type=" + pet_type + ", pet_kind=" + pet_kind + ", pet_gender=" + pet_gender + ", pet_kg="
				+ pet_kg + ", u_member_id=" + u_member_id + ", pet_size=" + pet_size + ", pet_neutered=" + pet_neutered + "]";
	}

	

	
}