package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class PayVerificationVO {
	private String imp_uid;			//포트원 결제 고유 번호
	private String merchant_uid;	//주문 고유 번호
	private String amount;			//포트원 결제 금액
}
