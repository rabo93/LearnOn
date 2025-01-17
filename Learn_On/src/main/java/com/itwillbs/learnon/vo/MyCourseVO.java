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
	private String class_pic;
	private int class_runtime;
	private int curriculum_count;
	private String teacher_name;
	private int review_idx;
	private String review_content;
	private int completion_rate; // 수강률
	private Boolean is_reviewed; // 수강후기 작성 여부
}
