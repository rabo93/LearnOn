package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class CouponVO {
	private String MEM_ID;
	private int COUPON_ID;
	private String COUPON_CODE;
	private String COUPON_NAME;
	private int DISCOUNT_AMOUNT;
	private int DISCOUNT_PERCENT;
	
	//---------------------------
//	private String CLASS_TITLE;
//	private int CNT;
//	private int CLASS_PRICE;
//	private int TOTAL_DISCOUNT;
//	
	
}
