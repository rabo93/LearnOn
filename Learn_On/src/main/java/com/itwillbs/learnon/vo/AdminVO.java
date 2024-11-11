package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AdminVO {
	private int CLASS_ID;
	private String CLASS_TITLE;
	private String MEM_ID;
	private String CLASS_INTRO;
	private int CLASS_PRICE;
	private String CLASS_CATEGORY;
	private String CLASS_CATEGORY2;
	private Timestamp CLASS_REG_DATE;
	private int CLASS_RUNTIME;
	private String CLASS_PIC1;
	private String CLASS_CONTENTS;
	private int CLASS_STATUS;
}
