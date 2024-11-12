package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class MyReviewVO {
	private int review_idx;
	private String mem_id;
	private String review_subject;
	private String review_content;
	private String review_date;
	private String class_id;
	private double review_score;
	private String review_answer_subject;
	private String review_answer_content;
}
