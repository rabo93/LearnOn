package com.itwillbs.learnon.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.ChatGPTService;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Controller
public class ChatGPTController {
	
	@Autowired
	private ChatGPTService chatGPTService;
	
	@GetMapping("Recommend")
	public String recommend(HttpServletRequest request, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		Map<String, String> userInfo = chatGPTService.getName(id);
		
		String response = chatGPTService.requestRecommend();
		String responsePerson = chatGPTService.requestRecommendPerson(userInfo.get("HASHTAG"));
		
		List<Map<String, Object>> classList = chatGPTService.getRecommendList(response);
		List<Map<String, Object>> myClassList = chatGPTService.getRecommendList(responsePerson);
		
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("classList", classList);
		model.addAttribute("myClassList", myClassList);

		return "gpt/gpt_list";
	}
	
//	@GetMapping("RequestRecommend")
//	public String requestRecommend(@RequestParam String hashtag) {
//		
//		String response = chatGPTService.requestRecommendPerson(hashtag);
//		
//		JSONObject jsonObj = new JSONObject(response);
//		JSONArray jsonArr = jsonObj.getJSONArray("choices");
//		JSONObject firstChoice = jsonArr.getJSONObject(0);
//		JSONObject message = firstChoice.getJSONObject("message");
//	    String class_ids = message.getString("content").replace("[", "").replace("]", "");
//	    
//    	List<Map<String, Object>> myClassList = chatGPTService.getRecommendList(class_ids);
//	    
//		return "";
//	}
	
	// =======================================================================
	// 챗GPT 활용 해시태그 자동생성
	@ResponseBody
	@PostMapping("ClassRequestHashtag") 
	public String classRequestHashtag(@RequestParam Map<String, String> classInfo) {
		log.info("클래스 정보 : " + classInfo);
		
		// ChatGPTService - requestHashtag() 메서드 호출하여 해시태그 생성 요청
		// => 파라미터 : Map객체(classInfo) / 리턴타입: String(response)
		String response = chatGPTService.requestHashtag(classInfo);
		log.info("ChatGPT 응답 결과(body만 추출) : " + response);
		
		return response;
	}
	
}
