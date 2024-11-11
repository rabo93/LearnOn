package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class CourseVO {
	private String CLASS_TITLE;
	private String MEM_ID;
	private String CLASS_INTRO;
	private int CLASS_PRICE;
	private String CLASS_CATEGORY;
	private String CLASS_REG_DATE;
	private int CLASS_RUNTIME;
	private String CLASS_PIC1;
	private String CLASS_CONTENTS;
	private int CLASS_STATUS;
	private int CLASS_ID;
	
	private int CUR_ID;
	private String CUR_TITLE;
	private String CUR_VIDEO;
	private double REVIEW_SCORE;
	
	private String CODETYPE;
	private String NAME;
	private String DESCRIPTION;
	private String CODETYPE_ID;
	
	private String CATENAME;
}
