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
	
	// 주문번호, 클래스id, 멤버id, 주문금액, 할인금액, 결제금액, 결제수단, 결제일시,
	//channelKey, MID
	private String orderNo;                   // 주문 번호
    private String classId;                   // 클래스 ID
    private String memberId;                  // 멤버 ID
    private int orderAmount;                  // 주문 금액
    private int discountAmount;               // 할인 금액
    private int paymentAmount;                // 결제 금액
    private String paymentMethod;             // 결제 수단
    private String paymentDate;               // 결제 일시
    private String channelKey;                // 채널 키
    private String mid;                       // Merchant ID (MID)
}
