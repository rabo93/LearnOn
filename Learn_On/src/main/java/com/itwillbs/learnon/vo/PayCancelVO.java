package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class PayCancelVO {
	//결제 취소 API Request 파라미터
	//https://developers.portone.io/api/rest-v1/payment?v=v1#post%20%2Fpayments%2Fcancel
	private String imp_uid;		 //포트원 거래 고유 번호(필수!대신uk여야함)
	private int amount;			 //취소 요청 금액(누락하거나 0을 입력 시 전액취소 요청)
	
	//아래는 선택사항
//	private String merchant_uid; //주문 고유 번호
//	private String reason;		 //취소 사유
//	private String checksum;	 //취소 트랜잭션 수행 전, 현재시점의 취소 가능한 잔액(부분환불시 취소 가능 금액보다 같거나 작아야함)
	
	
	//가상계좌 환시 필수사항
//	private String refund_holder;	//환불 수령계좌 예금주
//	private String refund_bank;		//환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
//	private String refund_account;	//환불 수령계좌 번호
	
}
