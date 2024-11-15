package com.itwillbs.learnon.vo;

import java.sql.Date;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
	public class MemberVO {
		private int idx;
		private String mem_name;
		private String mem_id;
		//private String mem_passwd1;
		private String mem_passwd;
		private String mem_nick;
		private String mem_gender;
		//--------------
		private String mem_birthday;
//		private String YEAR;
//		private String MONTH;
//		private String DAY;
		//--------------
		private String mem_phone;
		private String mem_post_code;
		private String mem_address1;
		private String mem_address2;
		//-----------------
		// 폼에서 입력받은 이메일 주소는 email1,2 라는 파라미터명으로 전달되므로
		// memberVO 객체에 email1 , 2객체필요
		// insert 과정에서 .. . . .. . . .
		//-----------------
		//만약 뷰페이지에서 자바스트립트 활용하여 email 결합할 경우 email1,email2 멤버변수 불필요
		private String email;
		private String mem_email1;
		private String mem_email2;
		//-----------------
		private String mail_auth_status; // 이메일 인증상태 (Y:인증 N:미인증)
		private String mem_grade;
		//---------------------
		private String terms1;
		private String terms2;
		private String terms3;

		private int mem_status; //회원상태 (1:정상 2:휴먼 3:탈퇴)
		private Date mem_reg_date;
		private Date mem_withdraw_date;  
		private String mem_like1_class;
		private String mem_like2_class;
		private MultipartFile mem_pp_file;
		private String file_pp;
		

}
