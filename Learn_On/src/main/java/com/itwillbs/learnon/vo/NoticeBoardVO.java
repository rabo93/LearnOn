package com.itwillbs.learnon.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeBoardVO {
	private int notice_idx;
	private String mem_id;
	private String notice_subject;
	private String notice_content;
	private Date notice_date;
//	private int notice_cate;
	private MultipartFile[] notice_file_get;
	private String notice_file;
	private int notice_read_count;
}


