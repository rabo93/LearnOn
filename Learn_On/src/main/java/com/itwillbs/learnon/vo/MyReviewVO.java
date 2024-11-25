package com.itwillbs.learnon.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyReviewVO {
	private int review_idx;
	private String mem_id;
	private String teacher_name;
	private String review_content;
	private Timestamp review_date;
	private String class_id;
	private String class_title;
	private double review_score;
	private String review_answer_content;
	private int total_count;
}
