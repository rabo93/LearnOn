package com.itwillbs.learnon.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor  // 모든 필드를 인자로 받는 생성자 자동 생성
@NoArgsConstructor // 기본 생성자 자동 생성
@ToString
public class PayVO {
	private List<PurchaseVO> purchaseItems; //주문한 상품들
	private int totalAmount; // 총 금액
	private int itemCount; // 주문 상품수
	
	//----------------------------------------------
	private String merchantUid;				// 주문 번호
    private String classId;					// 클래스 ID
    private String className;				// 클래스명
    private String memId;					// 멤버 ID
    private String memName;					// 주문자명
//    private int price;					// 주문 금액
    private String price;					// 주문 금액
    //BigDecimal은 문자열 타입이기 때문에 Integer 타입처럼 사칙연산이 불가능
    private String payMethod;				// 결제 수단
    private String memPhone;				// 주문자 연락처
    private String memEmail;				// 주문자 이메일
    private String paymentDate;				// 결제 일시
    private String imp_uid;					// 포트원 결제번호
}
