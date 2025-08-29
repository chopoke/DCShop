package com.spring.DCShop.board.dto;

import java.sql.Date;
import java.util.List;

import com.spring.DCShop.user.dto.UserDTO;

public class BoardDTO {
	
	private int b_num;				// 글번호
	private int u_member_id;		// fk - 아이디
	private String b_title;			// 제목
	private String b_contents;		// 내용
	private String b_category;		// 카테고리
	private Date b_dateposted;		// 작성일
	private Date b_updateDate;		// 수정일
	private int b_views;			// 조회수
	private int b_recommend;		// 추천수
	private String b_image;			// 이미지
	private int b_comments;			// 댓글 개수
	private List<UserDTO> userDTO;
	
	private String writerNickname;

    public String getWriterNickname() { return writerNickname; }
    public void setWriterNickname(String writerNickname) { this.writerNickname = writerNickname; }
	
	public BoardDTO() {
		super();
	}

	public BoardDTO(int b_num, int u_member_id, String b_title, String b_contents, String b_category, Date b_dateposted,
			Date b_updateDate, int b_views, int b_recommend, String b_image) {
		super();
		this.b_num = b_num;
		this.u_member_id = u_member_id;
		this.b_title = b_title;
		this.b_contents = b_contents;
		this.b_category = b_category;
		this.b_dateposted = b_dateposted;
		this.b_updateDate = b_updateDate;
		this.b_views = b_views;
		this.b_recommend = b_recommend;
		this.b_image = b_image;
	}

	public int getB_num() {
		return b_num;
	}

	public void setB_num(int b_num) {
		this.b_num = b_num;
	}

	public int getU_member_id() {
		return u_member_id;
	}

	public void setU_member_id(int u_member_id) {
		this.u_member_id = u_member_id;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public String getB_contents() {
		return b_contents;
	}

	public void setB_contents(String b_contents) {
		this.b_contents = b_contents;
	}

	public String getB_category() {
		return b_category;
	}

	public void setB_category(String b_category) {
		this.b_category = b_category;
	}

	public Date getB_dateposted() {
		return b_dateposted;
	}

	public void setB_dateposted(Date b_dateposted) {
		this.b_dateposted = b_dateposted;
	}

	public Date getB_updateDate() {
		return b_updateDate;
	}

	public void setB_updateDate(Date b_updateDate) {
		this.b_updateDate = b_updateDate;
	}

	public int getB_views() {
		return b_views;
	}

	public void setB_views(int b_views) {
		this.b_views = b_views;
	}

	public int getB_recommend() {
		return b_recommend;
	}

	public void setB_recommend(int b_recommend) {
		this.b_recommend = b_recommend;
	}

	public String getB_image() {
		return b_image;
	}

	public void setB_image(String b_image) {
		this.b_image = b_image;
	}
	
	public int getB_comments() {
		return b_comments;
	}
	
	public void setB_comments(int b_comments) {
		this.b_comments = b_comments;
	}
	
	public List<UserDTO> getUserDTO() {
		return userDTO;
	}
	
	public void setUserDTO(List<UserDTO> userDTO) {
		this.userDTO = userDTO;
	}

	@Override
	public String toString() {
		return "BoardDTO [b_num=" + b_num + ", u_member_id=" + u_member_id + ", b_title=" + b_title + ", b_contents="
				+ b_contents + ", b_category=" + b_category + ", b_dateposted=" + b_dateposted + ", b_updateDate="
				+ b_updateDate + ", b_views=" + b_views + ", b_recommend=" + b_recommend + ", b_image=" + b_image + "userDTO" + userDTO +  "]";
	}

}
