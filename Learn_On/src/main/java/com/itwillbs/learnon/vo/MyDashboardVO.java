package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class MyDashboardVO {
	private String mem_id;
	private int study_time;
	private int class_id;
	private String class_category;
	private String class_title;
	private int class_runtime;
	private int curriculum_count;
	private String teacher_name;
}
