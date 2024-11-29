package com.itwillbs.learnon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.learnon.service.ChatGPTService;

@Controller
public class ChatGPTController {
	
	@Autowired
	private ChatGPTService chatGPTService;
	
	@GetMapping("Recommend")
	public String recommend() {
		return "gpt/gpt_list";
	}
}
