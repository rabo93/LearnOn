package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class MyCurriculumVO {
	private String mem_id;
	private int class_id;
	private int cur_id;
	private String cur_title;
	private String cur_video;
	private int cur_runtime;
	private int completed_status;
}
