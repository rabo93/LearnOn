package com.itwillbs.learnon.vo;

import java.util.List;

import lombok.Data;

@Data
public class OrderVO { 
	//체크한 장바구니 상품을 주문할 때 결제페이지에서 조회될 멤버변수
	private int cartItemIdx;        // 장바구니ID
	private int classId;          	// 클래스ID
    private String classTitle;    	// 클래스명
    private String memId;   		// 회원ID
    private String teacherName;   	// 강사명
    private int classPrice;       	// 가격
    private String classPic1;     	// 썸네일사진

    //----------------------------------------------
    //주문 내역 DTO
    private int order_idx;
    private String merchant_uid;
    private String mem_id;
    private List<OrderItemVO> items;	//상품별 정보
    private int coupon_id;
    private int price;
    
}

