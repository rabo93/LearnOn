package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class OrderItemVO {	
	//각 상품별 주문정보를 담을 VO => OrderVO에 List 객체로 사용
	private int class_id;
	private int class_price;
}
