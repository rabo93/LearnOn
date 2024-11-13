package com.itwillbs.learnon.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailAuthInfo {
	private String email;
	private String auth_code;
	}
