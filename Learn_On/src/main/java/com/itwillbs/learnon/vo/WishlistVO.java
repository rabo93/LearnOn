package com.itwillbs.learnon.vo;

import lombok.Data;

@Data
public class WishlistVO {
	private int wishlist_idx;
	private String mem_id;
	private int class_id;
	private String class_category;
	private String class_title;
	private String class_pic;
	private String class_reg_date;
	private String review_score;
	private String teacher_name;
	
//	private int wishlistIDX;
//	private String memID;
//	private int classID;
//	private String classCategory;
//	private String classTitle;
//	private String classRegDate;
//	private String reviewScore;
//	private String teacherName;
}
