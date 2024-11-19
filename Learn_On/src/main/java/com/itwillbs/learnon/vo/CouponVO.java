package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class CouponVO {
	private String mem_id;			//회원ID
	private int coupon_id;			//쿠폰ID
	private String coupon_code;		//쿠폰코드
	private String coupon_name;		//쿠폰명
	private int discount_amount;	//할인금액
	private int discount_percent;	//할인비율
	private String issue_date; 		//발급날짜
	private String expiry_date;		//유효기간
	private int coupon_status; 		//쿠폰상태(1:사용가능,2:사용불가)
	private int coupon_isUsed;		//쿠폰 사용여부(1:미사용,2:사용완료)
	
}
