package com.spring.DCShop.mypage.dto;

import java.sql.Date;
import java.util.List;

public class CartDTO {

	private int ctNum;
	private int pdId;
	private int uMemberId;
	private int ctQuantity;
	private Date ctAddDate;
	private List<ProductDTO> productDto;
	
	public CartDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CartDTO(int ctNum, int pdId, int uMemberId, int ctQuantity, Date ctAddDate, List<ProductDTO> productDto) {
		super();
		this.ctNum = ctNum;
		this.pdId = pdId;
		this.uMemberId = uMemberId;
		this.ctQuantity = ctQuantity;
		this.ctAddDate = ctAddDate;
		this.productDto = productDto;
	}

	public int getCtNum() {
		return ctNum;
	}

	public void setCtNum(int ctNum) {
		this.ctNum = ctNum;
	}

	public int getPdId() {
		return pdId;
	}

	public void setPdId(int pdId) {
		this.pdId = pdId;
	}

	public int getuMemberId() {
		return uMemberId;
	}

	public void setuMemberId(int uMemberId) {
		this.uMemberId = uMemberId;
	}

	public int getCtQuantity() {
		return ctQuantity;
	}

	public void setCtQuantity(int ctQuantity) {
		this.ctQuantity = ctQuantity;
	}

	public Date getCtAddDate() {
		return ctAddDate;
	}

	public void setCtAddDate(Date ctAddDate) {
		this.ctAddDate = ctAddDate;
	}

	public List<ProductDTO> getProductDto() {
		return productDto;
	}

	public void setProductDto(List<ProductDTO> productDto) {
		this.productDto = productDto;
	}

	@Override
	public String toString() {
		return "CartDTO [ctNum=" + ctNum + ", pdId=" + pdId + ", uMemberId=" + uMemberId + ", ctQuantity=" + ctQuantity
				+ ", ctAddDate=" + ctAddDate + ", productDto=" + productDto + "]";
	}
	
}
