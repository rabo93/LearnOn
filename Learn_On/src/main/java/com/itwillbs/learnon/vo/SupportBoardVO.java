package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SupportBoardVO {
	private int support_idx;
	private Timestamp support_date;
	private String support_category;
	private String mem_id;
	private String mem_name;
	private String support_subject;
	private String support_content;
	private Timestamp support_answer_date;
	private String support_answer_subject;
	private String support_answer_content;
	
	// 첨부파일
	private String support_file1; // 파일명
	private MultipartFile file1; // 실제 파일
	private String original_file1;
}
