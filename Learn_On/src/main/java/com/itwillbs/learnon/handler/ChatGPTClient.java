package com.itwillbs.learnon.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Component
public class ChatGPTClient {
	
	@Value("${gpt.API_KEY}")
	private String apiKey;
	private String url = "https://api.openai.com/v1/chat/completions";
	private String model ="gpt-4o-mini"; //GPT모델
	private double temperature = 0.5;
	
	// 해시태그 요청을 위한 requestHashtag() 메서드
	public String requestHashtag(Map<String, String> classInfo) {
		log.info("API_KEY: " + apiKey);
		
		// Rest API 요청을 위한 HTTP 통신
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(apiKey);
		
		
		Map<String, String> roleSystem = new HashMap<String, String>();
		roleSystem.put("role", "system");
		roleSystem.put("content", "너는 온라인 교육 사이트 교육 안내원 역할이야."
				+ "우리의 온라인 교육 사이트의 카테고리는 크게 \"IT개발 / 외국어 / 운동,건강 / 라이프스타일(드로잉,공예,사진 등등) / 요리,음료\" 5가지가 있어"
				+ "강의명과 강의 상세 내용에 해당하는 해시태그 5개 생성해줘."
				+ "단, 해시태그 1개당 최대 5글자이고, 주로 한글과 숫자만 사용하되"
				+ "전문용어는 영문자를 섞어도 상관없고, 각 해시태그 사이는 공백없이 콤마(,)로 연결하고,"
				+ "설명 제외하고 해시태그만 보여줘.");
		
		Map<String, String> roleUser = new HashMap<String, String>();
		roleUser.put("role", "user");
		roleUser.put("content", classInfo.get("class_title") + "\n" + classInfo.get("class_intro"));
		
		List<Map<String, String>> messages = new ArrayList<Map<String, String>>();
		messages.add(roleSystem);
		messages.add(roleUser);
		
		JSONObject requestData = new JSONObject();
		requestData.put("model", model);
		requestData.put("temperature", temperature);
		requestData.put("messages", messages);
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(requestData.toString(), headers);
		log.info("httpEntity : " + httpEntity);
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
		
		return responseEntity.getBody();
	}
}
