package com.spring.DCShop.shop.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class QuestDTO {
	private int q_num;	//문의 번호 -> NVL
    private int pd_id;	//문의가 달린 상품 번호 -> 받아야 함
    private int u_member_id; //문의를 한 유저넘버 -> insert할땐 세션으로 받기
    private String u_id;	//문의를 한 유저.
    private String q_answer; //답변 여부 
    private String q_title;  //문의 제목 ㅁ
    private String q_content;//문의 내용 ㅁ
    private String q_secret; //문의 비밀여부 선택 
    private Date q_regDate;  //문의 일자
    private String q_img;	 //문의 이미지
    private String q_category; //문의 종류 ㅁ
    
    private int rn;		//상품에 달린 문의의 번호
    
	public QuestDTO() {
		super();
	}
	public QuestDTO(int q_num, int pd_id, int u_member_id, String u_id, String q_answer, String q_title, String q_content,
			String q_secret, Date q_regDate, String q_img, String q_category, int rn) {
		super();
		this.q_num = q_num;
		this.pd_id = pd_id;
		this.u_member_id = u_member_id;
		this.u_id = u_id;
		this.q_answer = q_answer;
		this.q_title = q_title;
		this.q_content = q_content;
		this.q_secret = q_secret;
		this.q_regDate = q_regDate;
		this.q_img = q_img;
		this.q_category = q_category;
		this.rn = rn;
	}
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
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
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getQ_answer() {
		return q_answer;
	}
	public void setQ_answer(String q_answer) {
		this.q_answer = q_answer;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getQ_secret() {
		return q_secret;
	}
	public void setQ_secret(String q_secret) {
		this.q_secret = q_secret;
	}
	public Date getQ_regDate() {
		return q_regDate;
	}
	public void setQ_regDate(Date q_regDate) {
		this.q_regDate = q_regDate;
	}
	public String getQ_img() {
		return q_img;
	}
	public void setQ_img(String q_img) {
		this.q_img = q_img;
	}
	public String getQ_category() {
		return q_category;
	}
	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}
	
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	
	
	@Override
	public String toString() {
		return "QuestDTO [q_num=" + q_num + ", pd_id=" + pd_id + ", u_member_id=" + u_member_id + ", u_id=" + u_id
				+ ", q_answer=" + q_answer + ", q_title=" + q_title + ", q_content=" + q_content + ", q_secret="
				+ q_secret + ", q_regDate=" + q_regDate + ", q_img=" + q_img + ", q_category=" + q_category + ", rn="
				+ rn + "]";
	}
	
	
    
}
//CREATE TABLE qna_tbl (
//	    q_num       NUMBER          PRIMARY KEY,                    -- 문의번호
//	    pd_id       NUMBER          NOT NULL,                       -- 상품 고유번호 (FK)
//	    u_member_id      NUMBER    NOT NULL,                       -- 작성자 (FK)
//	    q_answer    VARCHAR2(1) DEFAULT 'N'  CHECK (q_answer IN ('Y','N')) NOT NULL,         -- 답변여부
//	    q_title     VARCHAR2(200)   NOT NULL,                       -- 문의제목
//	    q_content   CLOB            NOT NULL,                       -- 문의내용
//	    q_secret    VARCHAR2(1) DEFAULT 'N'  CHECK (q_secret IN ('Y','N')) NOT NULL,         -- 비밀글여부
//	    q_regDate   DATE DEFAULT SYSDATE NOT NULL,                  -- 등록일
//	    q_img       VARCHAR2(255),                                  -- 이미지 URL
//	    q_category  VARCHAR2(20)
//);