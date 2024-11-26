package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyPaymentVO {
	private String merchant_uid;
	private int order_idx;
	private String mem_id;
	private int class_id;
	private String class_title;
	private int class_price;
	private int coupon_id;
	private int discount_type;
	private int discount_percent;
	private int discount_amount;
	private int result_price;
	private Timestamp pay_date;
	private String pay_method;
	private int pay_status;
	private String receipt_url;
	private int total_price; // 할인 전 합계금액
}
