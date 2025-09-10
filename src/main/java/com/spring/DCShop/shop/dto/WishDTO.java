package com.spring.DCShop.shop.dto;

public class WishDTO {
	
	private int w_num;			// 찜번호
	private int u_member_id;	// 유저번호
	private int pd_id;			// 상품 번호
	
	
	public WishDTO() {
		super();
	}
	public WishDTO(int w_num, int u_member_id, int pd_id) {
		super();
		this.w_num = w_num;
		this.u_member_id = u_member_id;
		this.pd_id = pd_id;
	}
	public int getW_num() {
		return w_num;
	}
	public void setW_num(int w_num) {
		this.w_num = w_num;
	}
	public int getU_member_id() {
		return u_member_id;
	}
	public void setU_member_id(int u_member_id) {
		this.u_member_id = u_member_id;
	}
	public int getPd_id() {
		return pd_id;
	}
	public void setPd_id(int pd_id) {
		this.pd_id = pd_id;
	}
	@Override
	public String toString() {
		return "WishDTO [w_num=" + w_num + ", u_member_id=" + u_member_id + ", pd_id=" + pd_id + "]";
	}

	
}
