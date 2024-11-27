package com.itwillbs.learnon.vo;

import java.util.List;

import lombok.Data;

@Data
public class OrderVO { 
	//체크한 상품들의 정보
	private int cartitem_idx;			// 장바구니ID
	private int class_id;				// 클래스ID
	private String mem_id;   			// 회원ID
    private String class_title;    		// 클래스명
    private String teacher_name;   		// 강사명
    private int class_price;       		// 가격
    private String class_pic1;     		// 썸네일사진

    //----------------------------------------------
    //주문 정보 저장
    private int order_idx;				//상품별주문번호
    private String merchant_uid;		//결제주문번호
    private List<OrderItemVO> items;	//상품별 정보(클래스ID, 클래스 가격)
    private int coupon_id;				//사용한 쿠폰번호
    private int price;					//총 결제 ㄱ금액
    
//    private int course_idx;
    
}

