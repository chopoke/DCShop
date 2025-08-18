package com.spring.DCShop.join.dto;

public class AgreeDTO {
	private String agreeTerms;		//서비스 이용약관
	private String agreePrivacy;	//개인정보 수집 동의
	private String agreeThird;		//개인정보 제3자 제공 동의
	private String agreeMarketing;	//마케팅 수신동의
	
	public AgreeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public AgreeDTO(String agreeTerms, String agreePrivacy, String agreeThird, String agreeMarketing) {
		super();
		this.agreeTerms = agreeTerms;
		this.agreePrivacy = agreePrivacy;
		this.agreeThird = agreeThird;
		this.agreeMarketing = agreeMarketing;
	}
	
	public String getAgreeTerms() {
		return agreeTerms;
	}
	public void setAgreeTerms(String agreeTerms) {
		this.agreeTerms = agreeTerms;
	}
	public String getAgreePrivacy() {
		return agreePrivacy;
	}
	public void setAgreePrivacy(String agreePrivacy) {
		this.agreePrivacy = agreePrivacy;
	}
	public String getAgreeThird() {
		return agreeThird;
	}
	public void setAgreeThird(String agreeThird) {
		this.agreeThird = agreeThird;
	}
	public String getAgreeMarketing() {
		return agreeMarketing;
	}
	public void setAgreeMarketing(String agreeMarketing) {
		this.agreeMarketing = agreeMarketing;
	}
	
	@Override
	public String toString() {
		return "termsDTO [agreeTerms=" + agreeTerms + ", agreePrivacy=" + agreePrivacy + ", agreeThird=" + agreeThird
				+ ", agreeMarketing=" + agreeMarketing + "]";
	}
}
