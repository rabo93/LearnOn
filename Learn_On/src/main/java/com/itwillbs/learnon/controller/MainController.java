package com.itwillbs.learnon.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.learnon.service.MainService;

@Controller
public class MainController {
	@Autowired
	private MainService mainService;
	
	@GetMapping("/")
	public String mainIndex(Model model) {
		
		List<Map<String, String>> bestClassList = mainService.getBestClassList();
		List<Map<String, String>> newClassList = mainService.getNewClassList();
		
		model.addAttribute("bestClassList", bestClassList);
		model.addAttribute("newClassList", newClassList);
		
		
		return "index";
	}
}
