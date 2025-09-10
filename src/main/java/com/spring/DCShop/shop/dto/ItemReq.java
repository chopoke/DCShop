package com.spring.DCShop.shop.dto;

public class ItemReq {
	
    private Long pdId;
    private Long ctId;
    
	public ItemReq() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ItemReq(Long pdId, Long ctId) {
		super();
		this.pdId = pdId;
		this.ctId = ctId;
	}
	
	public Long getPdId() {
		return pdId;
	}
	
	public void setPdId(Long pdId) {
		this.pdId = pdId;
	}
	
	public Long getCtId() {
		return ctId;
	}
	
	public void setCtId(Long ctId) {
		this.ctId = ctId;
	}
	
	@Override
	public String toString() {
		return "ItemReq [pdId=" + pdId + ", ctId=" + ctId + "]";
	}
    
}