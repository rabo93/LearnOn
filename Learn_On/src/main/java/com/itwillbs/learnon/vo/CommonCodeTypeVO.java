package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class CommonCodeTypeVO {
	private String codetype; 	// 대분류 CODE (CATE01...)
	private String name;	 	// COMMONCODETYPE 이름 (프로그래밍...) 
	private String description;	// COMMONCODETYPE 설명
	private String codetype_id;	// COMMONCODETYPE ID 소분류 01, 02, ...
	private String order;		// 정렬순서
	
	private String codename;	// COMMONCODE 의 CODENAME
	private String cc_codetype; // COMMONCODE의 CODETYPE : CATE, BOARD...

}
