package com.itwillbs.learnon.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.learnon.service.ChatGPTService;

@Controller
public class ChatGPTController {
	
	@Autowired
	private ChatGPTService chatGPTService;
	
	@GetMapping("Recommend")
	public String recommend(HttpServletRequest request, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		
		
		
		return "gpt/gpt_list";
	}
}
