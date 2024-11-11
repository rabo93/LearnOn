package com.itwillbs.learnon.vo;

import java.sql.Date;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
	public class MemberVO {
		private int IDX;
		private String MEM_NAME;
		private String MEM_ID;
		//private String mem_passwd1;
		private String MEM_PASSWD;
		private String MEM_NICK;
		private String MEM_GENDER;
		//--------------
		private String MEM_BIRTHDAY;
//		private String YEAR;
//		private String MONTH;
//		private String DAY;
		//--------------
		private String MEM_PHONE;
		private String MEM_POST_CODE;
		private String MEM_ADDRESS1;
		private String MEM_ADDRESS2;
		//-----------------
		// 폼에서 입력받은 이메일 주소는 email1,2 라는 파라미터명으로 전달되므로
		// memberVO 객체에 email1 , 2객체필요
		// insert 과정에서 .. . . .. . . .
		//-----------------
		//만약 뷰페이지에서 자바스트립트 활용하여 email 결합할 경우 email1,email2 멤버변수 불필요
		private String EMAIL;
		private String MEM_EMAIL1;
		private String MEM_EMAIL2;
		//-----------------
		private String MAIL_AUTH_STATUS; // 이메일 인증상태 (Y:인증 N:미인증)
		private String MEM_GRADE;
		//---------------------
		private String TERMS1;
		private String TERMS2;
		private String TERMS3;

		private int MEM_STATUS; //회원상태 (1:정상 2:휴먼 3:탈퇴)
		private Date MEM_REG_DATE;
		private Date MEM_WITHDRAW_DATE;  
		private String MEM_LIKE1_CLASS;
		private String MEM_LIKE2_CLASS;
		private MultipartFile MEM_PP_FILE;
		private String FILE_PP;
		

}
