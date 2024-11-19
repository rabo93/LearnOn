package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class CourseVO {
	private String class_title;
	private String mem_id;
	private String class_intro;
	private int class_price;
	private String class_category;
	private String class_reg_date;
	private int class_runtime;
	private String class_pic1;
	private String class_contents;
	private int class_status;
	private int class_id;
	
	private int cur_id;
	private String cur_title;
	private String cur_video;
	private String cur_runtime;
	
	private double review_score;
	
	private String codetype;
	private String name;
	private String description;
	private String codetype_id;
	
	private String catename;
}
