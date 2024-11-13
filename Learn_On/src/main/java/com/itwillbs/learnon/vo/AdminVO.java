package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AdminVO {
	private int class_id;
	private String class_title;
	private String mem_id;
	private String class_intro;
	private int class_price;
	private String class_category;
	private String class_category2;
//	private Timestamp class_reg_date;
	private int class_runtime;
	private String class_pic1;
//	private multipartfile class_pic;
	private String class_contents;
	private int class_status;
	
	//=======================================
	
	private String codeid;
	private String codetype;
	private String codename;
	
	//=======================================
	
	private String name;
}
