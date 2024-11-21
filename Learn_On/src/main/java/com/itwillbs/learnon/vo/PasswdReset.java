package com.itwillbs.learnon.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public class PasswdReset {
		private String mem_email;
		private String token;
	}
