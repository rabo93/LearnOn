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
	
	// 관리자 클래스 등록 시 해시태그 요청
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
	
	// ==============================================================================================
	
	// 추천 해시태그 요청
	public String requestRec(String hashtags, List<Map<String, String>> classList) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(apiKey);
		
		Map<String, String> roleSystem = new HashMap<String, String>();
		roleSystem.put("role", "system");
		roleSystem.put("content", "너는 온라인 교육 사이트 교육 안내원 역할이야."
				+ "너는 우리 사이트는 회원들의 해시태그 선호도를 조사해서 해당 해시태그와 연관된"
				+ "클래스를 추천해주는 역할이야."
				+ "첫번째는 우리 웹사이트(온라인 교육 플랫폼)의 회원들이 선호하는 해시태그 모음이야."
				+ "두번째로 우리 웹사이트에 등록된 전체 클래스 목록(클래스 아이디와 해시태그)을 보여줄테니"
				+ "만약, 해시태그가 10개 이상으로 많다면 회원 선호 해시태그 중 가장 인기있는 해시태그 상위 5개만 간추리고"
				+ "그 해시태그와 우리 웹사이트에 등록된 전체 클래스 목록에서 일치하거나 가장 연관있는 클래스를 최대 8개만 뽑아서 클래스아이디를 배열 객체로 알려줘."
				+ "모든 설명은 제외하고 제목도 제외하고 오로지 클래스아이디만 알려줘. 결과에 ```json``` 이런 글자는 모두 제외해줘.");
		
		Map<String, String> roleUser = new HashMap<String, String>();
		roleUser.put("role", "user");
		roleUser.put("content", hashtags + "\n" + classList);
		
		List<Map<String, String>> messages = new ArrayList<Map<String,String>>();
		messages.add(roleSystem);
		messages.add(roleUser);
		
		JSONObject requestData = new JSONObject();
		requestData.put("model", model);
		requestData.put("temperature", temperature);
		requestData.put("messages", messages);
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(requestData.toString(), headers);
		System.out.println("httpEntity : " + httpEntity);
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<String> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
		System.out.println(responseEntity.getBody());
		
		return responseEntity.getBody();
	}
	
	
}
