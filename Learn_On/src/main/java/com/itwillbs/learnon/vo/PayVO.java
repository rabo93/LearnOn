package com.itwillbs.learnon.vo;

import java.util.List;

import lombok.Data;

@Data
//@AllArgsConstructor  // 모든 필드를 인자로 받는 생성자 자동 생성
//@NoArgsConstructor // 기본 생성자 자동 생성
public class PayVO {
	private List<OrderVO> orderItems; //주문한 상품들
	private int totalAmount; // 총 금액
	private int itemCount; // 주문 상품수
	
	//----------------------------------------------
	//결제 내역 DTO(rsp)
	private String merchant_uid;				// 주문 번호
    private String class_name;					// 클래스명
    private String mem_id;						// 주문자ID
    private String mem_name;					// 주문자명
    private int price;							// 주문 금액
//    private BigDecimal price;					
    //BigDecimal은 문자열 타입이기 때문에 Integer 타입처럼 사칙연산이 불가능
    private String pay_method;					// 결제 수단
    //결제 응답 추가 파라미터
    private String pay_status;					// 결제 상태 
    //=> rsp에서 수신받은 결제상태값
    //ready(브라우저 창 이탈, 가상계좌 발급 완료 등 미결제 상태)
    //paid(결제완료)
    //failed(신용카드 한도 초과, 체크카드 잔액 부족, 브라우저 창 종료 또는 취소 버튼 클릭 등 결제실패 상태)
    private String imp_uid;						// 포트원 결제번호
    private String card_name;					// 카드명
    private String card_num;					// 카드번호
    private String bank_name;					// 가상계좌은행명
    private String bank_num;					// 가상계좌번호
    private String apply_num;					// 승인 번호
    private String receipt_url;					// 결제영수증 url주소
    
    private int discount_amount;				// 할인금액
    private String vbank_due;					// 결제영수증 url주소
}


