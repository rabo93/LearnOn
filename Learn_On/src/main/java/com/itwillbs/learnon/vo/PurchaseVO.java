package com.itwillbs.learnon.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PurchaseVO { //체크한 장바구니 상품을 주문할 때 멤버변수 => PayVO
	private int cartItemIdx;          // 클래스 ID
	private int classId;          // 클래스 ID
    private String classTitle;    // 클래스명
    private String memId;   // 강사명
    private String teacherName;   // 강사명
    private int classPrice;       // 가격
    private String classPic1;     // 이미지
}

