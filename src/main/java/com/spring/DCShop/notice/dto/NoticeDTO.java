package com.spring.DCShop.notice.dto;

import java.sql.Date;

public class NoticeDTO {
	private int n_num;           // 공지번호
	private int u_member_id;     // 작성자 회원번호
	private String n_title;      // 공지제목
	private String n_contents;   // 공지내용
	private Date n_dateposted;   // 등록일
	private Date n_updateDate;   // 수정일
	private int n_views;         // 조회수
	private String n_category;   // 공지카테고리 (공지/이벤트)
	private String n_image;      // 공지이미지
	private int n_important;     // 중요도 (1: 일반, 2: 중요, 3: 긴급)
	
	// UserDTO와의 연관관계
	private Object userDTO;
	
	// 기본 생성자
	public NoticeDTO() {}
	
	// Getter/Setter
	public int getN_num() {
		return n_num;
	}
	
	public void setN_num(int n_num) {
		this.n_num = n_num;
	}
	
	public int getU_member_id() {
		return u_member_id;
	}
	
	public void setU_member_id(int u_member_id) {
		this.u_member_id = u_member_id;
	}
	
	public String getN_title() {
		return n_title;
	}
	
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	
	public String getN_contents() {
		return n_contents;
	}
	
	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}
	
	public Date getN_dateposted() {
		return n_dateposted;
	}
	
	public void setN_dateposted(Date n_dateposted) {
		this.n_dateposted = n_dateposted;
	}
	
	public Date getN_updateDate() {
		return n_updateDate;
	}
	
	public void setN_updateDate(Date n_updateDate) {
		this.n_updateDate = n_updateDate;
	}
	
	public int getN_views() {
		return n_views;
	}
	
	public void setN_views(int n_views) {
		this.n_views = n_views;
	}
	
	public String getN_category() {
		return n_category;
	}
	
	public void setN_category(String n_category) {
		this.n_category = n_category;
	}
	
	public String getN_image() {
		return n_image;
	}
	
	public void setN_image(String n_image) {
		this.n_image = n_image;
	}
	
	public int getN_important() {
		return n_important;
	}
	
	public void setN_important(int n_important) {
		this.n_important = n_important;
	}
	
	public Object getUserDTO() {
		return userDTO;
	}
	
	public void setUserDTO(Object userDTO) {
		this.userDTO = userDTO;
	}
	
	@Override
	public String toString() {
		return "NoticeDTO [n_num=" + n_num + ", u_member_id=" + u_member_id + ", n_title=" + n_title + ", n_contents="
				+ n_contents + ", n_dateposted=" + n_dateposted + ", n_updateDate=" + n_updateDate + ", n_views="
				+ n_views + ", n_category=" + n_category + ", n_image=" + n_image + ", n_important=" + n_important + "]";
	}
}
