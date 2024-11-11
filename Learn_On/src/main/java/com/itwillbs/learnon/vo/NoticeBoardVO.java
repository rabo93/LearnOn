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
	private int NOTICE_IDX;
	private String MEM_ID;
	private String NOTICE_SUBJECT;
	private String NOTICE_CONTENT;
	private Date NOTICE_DATE;
	private int NOTICE_CATE;
	private MultipartFile[] NOTICE_FILE_GET;
	private String NOTICE_FILE;
	private int NOTICE_READ_COUNT;
}


