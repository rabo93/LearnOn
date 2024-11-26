package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CourseSupportVO {

	private int c_support_idx; 
	private Timestamp c_support_date; 
	private String c_support_category; 
	private String mem_id;
	private String c_support_subject; 
	private String c_support_content; 
	private Timestamp c_support_answer_date; 
	private String c_support_answer_subject; 
	private String c_support_answer_content;
	
	
	//--------------------------------------
	// 파일 업로드시 실제 파일과 파일명을 별도로 분리하여 관리
	// 1) String 타입 멤버변수는 실제 파일이 아닌 파일명을 저장하는 용도로 사용
	private String c_support_file;
	//2) MultipartFile 타입 변수를 통해 실제 업로드 되는 파일을 관리하는 용도로 사용
	private MultipartFile file;
	//--------------------------------------
	
	private int c_class_id;
}
