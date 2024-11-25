package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class PayCancelVO {
	private String imp_uid;		//포트원 결제 고유 번호
	private String reason;		//결제 취소 사유
	private String checksum;	//환불 가능 금액
}
