package com.itwillbs.learnon;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
	
		
		
		// index.jsp 페이지로 포워딩
		return "index";
	}
	
	
	
}
