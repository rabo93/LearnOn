package com.itwillbs.learnon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FAQcontroller {
	
	@GetMapping("FAQ")
	public String faq() {
		
		return "faq/faq";
	}
	
	
}
