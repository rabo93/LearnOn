package com.itwillbs.learnon.vo;

import lombok.Data;

//멤버변수 camelCase 형식으로 선언해야하는지 확인
@Data
public class CartVO {
	//CART 테이블에 있는 컬럼
	private int CARTITEM_IDX; 	//장바구니번호(PK)
	private int CLASS_ID;		//클래스ID
	private String MEM_ID;		//회원ID
	
	private String CLASS_TITLE; //클래스명: CLASS 테이블에서 조인해서 가져올 정보
	private String MEM_NAME; 	//회원이름: MEMBER 테이블에서 조인해서 가져올 정보
	private int CLASS_PRICE; 	//가격 : CLASS 테이블에서 조인해서 가져올 정보
	
	private String CLASS_PIC1; //썸네일사진 - String 타입 멤버변수는 실제 파일이 아닌 파일명을 저장하는 용도로 사용
	
	private int cnt;//선택 갯수
	
	//장바구니는 상품정보를 갖고 있음
//	private ClassVO classVO;
	
	
}
