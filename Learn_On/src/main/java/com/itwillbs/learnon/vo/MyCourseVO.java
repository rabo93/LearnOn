package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class MyCourseVO {
	private String mem_id;
	private int course_status;
	private int study_time;
	private String class_id;
	private String class_category;
	private String class_title;
	private int class_runtime;
	private int curriculum_count;
	private String teacher_name;
	private int review_idx;
	private String review_subject;
	private String review_content;
}
