package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class CartVO {
	private int cartitem_idx; 		//장바구니번호(pk)
	private int class_id;			//클래스id
	private String mem_id;			//회원id
	private String class_title; 	//클래스명: class 테이블에서 조인해서 가져올 정보
	private String mem_name; 		//강사이름: member 테이블에서 조인해서 가져올 정보
	private int class_price; 		//가격 : class 테이블에서 조인해서 가져올 정보
	private String class_pic1; 		//썸네일사진 - string 타입 멤버변수는 실제 파일이 아닌 파일명을 저장하는 용도로 사용
	
}
