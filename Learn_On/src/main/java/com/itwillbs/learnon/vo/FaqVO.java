package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class FaqVO {
	private int faq_idx; 
	private String faq_subject; 
	private String faq_content; 
	private int faq_cate;
	private int class_category;
}


