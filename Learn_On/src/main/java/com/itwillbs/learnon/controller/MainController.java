package com.itwillbs.learnon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.learnon.service.MainService;

@Controller
public class MainController {
	@Autowired
	private MainService mainService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String mainIndex() {
		System.out.println("메인페이지 로딩");
		return "index";
	}
}
