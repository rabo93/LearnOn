package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CourseSupportVO {

	private int c_support_idx; 
	private Timestamp c_support_date; 
	private String c_support_category; 
	private String mem_id;
	private String c_support_subject; 
	private String c_support_content; 
	private String c_support_answer_date; 
	private String c_support_answer_subject; 
	private String c_support_answer_content; 
	private String c_support_file;
	private int c_class_id;
}
