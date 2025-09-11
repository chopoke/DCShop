package com.spring.DCShop.shop.dto;

import java.util.List;

public class DeleteReq {
	
	private List<ItemReq> items;

	public DeleteReq() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DeleteReq(List<ItemReq> items) {
		super();
		this.items = items;
	}

	public List<ItemReq> getItems() {
		return items;
	}

	public void setItems(List<ItemReq> items) {
		this.items = items;
	}

	@Override
	public String toString() {
		return "DeleteReq [items=" + items + "]";
	}
 
}
