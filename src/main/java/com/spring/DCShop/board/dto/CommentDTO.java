package com.spring.DCShop.board.dto;

import java.sql.Date;

public class CommentDTO {
	
	private int c_num; 			//댓글번호
	private int b_num;			//게시글번호
	private int u_member_id;	//작성자
	private String c_content;	//댓글 내용
	private Date c_regDate;		//작성일
	private int c_num2;			//대댓글
	private String c_deleted;	//삭제
	private String c_writer;	//작성자
	
	public CommentDTO() {
		super();
	}
	public CommentDTO(int c_num, int b_num, int u_member_id, String c_content, Date c_regDate, int c_num2,
			String c_deleted, String c_writer) {
		super();
		this.c_num = c_num;
		this.b_num = b_num;
		this.u_member_id = u_member_id;
		this.c_content = c_content;
		this.c_regDate = c_regDate;
		this.c_num2 = c_num2;
		this.c_deleted = c_deleted;
		this.c_writer = c_writer;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
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
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public Date getC_regDate() {
		return c_regDate;
	}
	public void setC_regDate(Date c_regDate) {
		this.c_regDate = c_regDate;
	}
	public int getC_num2() {
		return c_num2;
	}
	public void setC_num2(int c_num2) {
		this.c_num2 = c_num2;
	}
	public String getC_deleted() {
		return c_deleted;
	}
	public void setC_deleted(String c_deleted) {
		this.c_deleted = c_deleted;
	}
	public String getC_writer() {
		return c_writer;
	}
	public void setC_writer(String c_writer) {
		this.c_writer = c_writer;
	}
	@Override
	public String toString() {
		return "CommentDTO [c_num=" + c_num + ", b_num=" + b_num + ", u_member_id=" + u_member_id + ", c_content="
				+ c_content + ", c_regDate=" + c_regDate + ", c_num2=" + c_num2 + ", c_deleted=" + c_deleted
				+ ", c_writer=" + c_writer + "]";
	}
	
	
	
}
