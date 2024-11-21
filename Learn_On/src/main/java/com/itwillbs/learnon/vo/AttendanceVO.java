package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class AttendanceVO {
	private String check_in_date;
	private String mem_id;
	private int streak_days;
}
