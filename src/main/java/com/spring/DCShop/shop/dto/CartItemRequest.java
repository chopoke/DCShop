package com.spring.DCShop.shop.dto;

public class CartItemRequest {
	private Long pdId;
	private String pdName;
	private Integer pdPrice;
	private Integer qty;
	private String pdImg;
	private Integer pdDiscountRate;
	
	public CartItemRequest() {
		super();
	}
	
	public CartItemRequest(Long pdId, String pdName, Integer pdPrice, Integer qty, String pdImg, Integer pdDiscountRate) {
		super();
		this.pdId = pdId;
		this.pdName = pdName;
		this.pdPrice = pdPrice;
		this.qty = qty;
		this.pdImg = pdImg;
		this.pdDiscountRate = pdDiscountRate;
	}

	public Long getPdId() {
		return pdId;
	}

	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}

	public String getPdName() {
		return pdName;
	}

	public void setPdName(String pdName) {
		this.pdName = pdName;
	}

	public Integer getPdPrice() {
		return pdPrice;
	}

	public void setPdPrice(Integer pdPrice) {
		this.pdPrice = pdPrice;
	}

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
	}
	
	public String getPdImg() {
		return pdImg;
	}
	
	public void setPdImg(String pdImg) {
		this.pdImg = pdImg;
	}
	
	public Integer getPdDiscountRate() {
		return pdDiscountRate;
	}
	
	public void setPdDiscountRate(Integer pdDiscountRate) {
		this.pdDiscountRate = pdDiscountRate;
	}
	
	@Override
	public String toString() {
		return "CartItemRequest [pdId=" + pdId + ", pdName=" + pdName + ", pdPrice=" + pdPrice + ", qty=" + qty+ ", pdImg=" + pdImg + ", pdDiscountRate=" + pdDiscountRate + "]";
	}

	
}