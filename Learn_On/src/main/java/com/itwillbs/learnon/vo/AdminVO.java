package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AdminVO {
	
	// 클래스
	private int class_id;
	private String class_title;
	private String mem_id;
	private String class_intro;
	private int class_price;
	private String class_category;
	private String class_reg_date;
	private int class_runtime;
	private String class_pic1;
	private MultipartFile class_pic1_get;
	private String class_contents;
	private int class_status;
	private String codetype_id;
	private String name;
	
	// 커리큘럼
	private int cur_id;
	private String cur_title;
	private String cur_video;
	private MultipartFile cur_video_get;
	private String cur_runtime;
	private MultipartFile cur_video_file;
	
	// 카테고리
	//=======================================
	// 대분류
	private String codetype_maincate;
	private String codeid_maincate;
	private String codename_maincate;
	private String description_maincate;
	
	private String old_codetype_maincate;
	private String old_codeid_maincate;
	private String old_codename_maincate;
	private String old_description_maincate;
	private String main_checkCodeid;
	
	
	// 소분류
	private String codetype_subcate;
	private String codetype_id_subcate;
	private String name_subcate;
	private String description_subcate;
	private String order_subcate;
	
	private String old_codetype_subcate;
	private String old_codetype_id_subcate;
	private String old_name_subcate;
	private String old_description_subcate;
	private String old_order_subcate;
	private String sub_checkCodeid;	
	//=======================================
	
}
