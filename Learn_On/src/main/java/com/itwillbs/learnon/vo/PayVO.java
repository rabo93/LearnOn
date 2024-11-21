package com.itwillbs.learnon.vo;

import java.util.List;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor  // 모든 필드를 인자로 받는 생성자 자동 생성
@NoArgsConstructor // 기본 생성자 자동 생성
public class PayVO {
	private List<PurchaseVO> purchaseItems; //주문한 상품들
	private int totalAmount; // 총 금액
	private int itemCount; // 주문 상품수
	
	//----------------------------------------------
	private String merchantId;				// 주문 번호
    private String classId;					// 클래스 ID
    private String className;				// 클래스명
    private String memId;					// 멤버 ID
    private String memName;					// 주문자명
    private int totalPrice;					// 주문 금액
    private String payMethod;				// 결제 수단
    private String memTel;					// 주문자 연락처
    private String memEmail;				// 주문자 이메일
    private String paymentDate;				// 결제 일시
}
