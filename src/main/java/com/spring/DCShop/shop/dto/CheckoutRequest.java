package com.spring.DCShop.shop.dto;

import java.util.List;

public class CheckoutRequest {
	private List<CartItemRequest> items;
	private Integer pdShippingFee;
	private Long totalClient;
	private String currency;
	private Integer totalDiscount;
	private String shipping;
	  
	public CheckoutRequest() {}

	public CheckoutRequest(List<CartItemRequest> items,Integer pdShippingFee , Long totalClient, String currency, Integer totalDiscount) {
		super();
		this.items = items;
		this.pdShippingFee = pdShippingFee;
		this.totalClient = totalClient;
		this.currency = currency;
		this.totalDiscount = totalDiscount;
	}
	
	public CheckoutRequest(List<CartItemRequest> items,Integer pdShippingFee , Long totalClient, String currency, Integer totalDiscount, String shipping) {
		super();
		this.items = items;
		this.pdShippingFee = pdShippingFee;
		this.totalClient = totalClient;
		this.currency = currency;
		this.totalDiscount = totalDiscount;
		this.shipping = shipping;
	}

	public List<CartItemRequest> getItems() {
		return items;
	}

	public void setItems(List<CartItemRequest> items) {
		this.items = items;
	}
	
	public Integer getPdShippingFee() {
		return pdShippingFee;
	}
	
	public void setPdShippingFee(Integer pdShippingFee) {
		this.pdShippingFee = pdShippingFee;
	}

	public Long getTotalClient() {
		return totalClient;
	}

	public void setTotalClient(Long totalClient) {
		this.totalClient = totalClient;
	}

	public String getShipping() {
		return shipping;
	}

	public void setCurrency(String shipping) {
		this.shipping = shipping;
	}
	
	public Integer getTotalDiscount() {
		return totalDiscount;
	}
	
	public void setTotalDiscount(Integer totalDiscount) {
		this.totalDiscount = totalDiscount;
	}

	@Override
	public String toString() {
		return "CheckoutRequest [items=" + items + ", pdShippingFee=" + pdShippingFee + ", totalClient=" + totalClient + ", currency=" + currency + ", totalDiscount=" + totalDiscount + ", shipping=" + shipping + "]";
	}
	  
}
