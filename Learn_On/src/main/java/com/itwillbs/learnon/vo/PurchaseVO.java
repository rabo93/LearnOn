package com.itwillbs.learnon.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PurchaseVO { //체크한 장바구니 상품을 주문할 때 결제페이지에서 조회될 멤버변수
	private int cartItemIdx;        // 장바구니ID
	private int classId;          	// 클래스ID
    private String classTitle;    	// 클래스명
    private String memId;   		// 회원ID
    private String teacherName;   	// 강사명
    private int classPrice;       	// 가격
    private String classPic1;     	// 썸네일사진
}

