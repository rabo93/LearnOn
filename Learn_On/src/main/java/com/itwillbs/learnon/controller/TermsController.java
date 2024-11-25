package com.itwillbs.learnon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TermsController {
	
	@GetMapping("TermsOfService")
	public String termsOfService() {
		return "info/terms";
	}
	
	@GetMapping("PrivacyPolicy")
	public String privacyPolicy() {
		return "info/privacy";
	}
	
	@GetMapping("RefundPolicy")
	public String refundPolicy() {
		return "info/refund";
	}
	
}
