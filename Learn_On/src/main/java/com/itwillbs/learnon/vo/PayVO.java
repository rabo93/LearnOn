package com.itwillbs.learnon.vo;

import java.math.BigDecimal;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor  // 모든 필드를 인자로 받는 생성자 자동 생성
@NoArgsConstructor // 기본 생성자 자동 생성
public class PayVO {
	private List<PurchaseVO> purchaseItems; //주문한 상품들
	private int totalAmount; // 총 금액
	private int itemCount; // 주문 상품수
	
	//----------------------------------------------
	//결제 내역 VO(rsp)
	private String merchant_uid;				// 주문 번호
    private String class_name;					// 클래스명
    private String mem_name;					// 주문자명
    private int price;							// 주문 금액
//    private BigDecimal price;					// 주문 금액
    //BigDecimal은 문자열 타입이기 때문에 Integer 타입처럼 사칙연산이 불가능
    private String pay_method;					// 결제 수단
    private String pay_status;					// 결제 상태
    private String pay_date;					// 결제 일시
    
    private String imp_uid;						// 포트원 결제번호
    private String card_name;					// 카드명
    private String card_num;					// 카드번호
    private String bank_name;					// 은행명
    private String receipt_url;					// 결제 영수증 url주소
}
