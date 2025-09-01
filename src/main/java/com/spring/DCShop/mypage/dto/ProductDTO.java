package com.spring.DCShop.mypage.dto;

import java.sql.Clob;
import java.sql.Date;

public class ProductDTO {

	private int pdId;
	private String pdName;
	private Clob pdDescription;
	private int pdPrice;
	private int pdStock;
	private int category;
	private Date pdCreated;
	private Date pdUpdate;
	private String pdBrand;
	private String pdImageUrl;
	private int pdShippingFee;
	private int pdDiscountRate;
	private String pdStatus;
	private String pdOption;
	
	public ProductDTO() {}

	public ProductDTO(int pdId, String pdName, Clob pdDescription, int pdPrice, int pdStock, int category,
			Date pdCreated, Date pdUpdate, String pdBrand, String pdImageUrl, int pdShippingFee, int pdDiscountRate,
			String pdStatus, String pdOption) {
		super();
		this.pdId = pdId;
		this.pdName = pdName;
		this.pdDescription = pdDescription;
		this.pdPrice = pdPrice;
		this.pdStock = pdStock;
		this.category = category;
		this.pdCreated = pdCreated;
		this.pdUpdate = pdUpdate;
		this.pdBrand = pdBrand;
		this.pdImageUrl = pdImageUrl;
		this.pdShippingFee = pdShippingFee;
		this.pdDiscountRate = pdDiscountRate;
		this.pdStatus = pdStatus;
		this.pdOption = pdOption;
	}

	public int getPdId() {
		return pdId;
	}

	public void setPdId(int pdId) {
		this.pdId = pdId;
	}

	public String getPdName() {
		return pdName;
	}

	public void setPdName(String pdName) {
		this.pdName = pdName;
	}

	public Clob getPdDescription() {
		return pdDescription;
	}

	public void setPdDescription(Clob pdDescription) {
		this.pdDescription = pdDescription;
	}

	public int getPdPrice() {
		return pdPrice;
	}

	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}

	public int getPdStock() {
		return pdStock;
	}

	public void setPdStock(int pdStock) {
		this.pdStock = pdStock;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public Date getPdCreated() {
		return pdCreated;
	}

	public void setPdCreated(Date pdCreated) {
		this.pdCreated = pdCreated;
	}

	public Date getPdUpdate() {
		return pdUpdate;
	}

	public void setPdUpdate(Date pdUpdate) {
		this.pdUpdate = pdUpdate;
	}

	public String getPdBrand() {
		return pdBrand;
	}

	public void setPdBrand(String pdBrand) {
		this.pdBrand = pdBrand;
	}

	public String getPdImageUrl() {
		return pdImageUrl;
	}

	public void setPdImageUrl(String pdImageUrl) {
		this.pdImageUrl = pdImageUrl;
	}

	public int getPdShippingFee() {
		return pdShippingFee;
	}

	public void setPdShippingFee(int pdShippingFee) {
		this.pdShippingFee = pdShippingFee;
	}

	public int getPdDiscountRate() {
		return pdDiscountRate;
	}

	public void setPdDiscountRate(int pdDiscountRate) {
		this.pdDiscountRate = pdDiscountRate;
	}

	public String getPdStatus() {
		return pdStatus;
	}

	public void setPdStatus(String pdStatus) {
		this.pdStatus = pdStatus;
	}

	public String getPdOption() {
		return pdOption;
	}

	public void setPdOption(String pdOption) {
		this.pdOption = pdOption;
	}

	@Override
	public String toString() {
		return "ProductDTO [pdId=" + pdId + ", pdName=" + pdName + ", pdDescription=" + pdDescription + ", pdPrice="
				+ pdPrice + ", pdStock=" + pdStock + ", category=" + category + ", pdCreated=" + pdCreated
				+ ", pdUpdate=" + pdUpdate + ", pdBrand=" + pdBrand + ", pdImageUrl=" + pdImageUrl + ", pdShippingFee="
				+ pdShippingFee + ", pdDiscountRate=" + pdDiscountRate + ", pdStatus=" + pdStatus + ", pdOption="
				+ pdOption + "]";
	}
	
}