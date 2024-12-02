package com.itwillbs.learnon.service;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.handler.ChatGPTClient;
import com.itwillbs.learnon.mapper.ChatGPTMapper;

@Service
public class ChatGPTService {
	@Autowired
	private ChatGPTMapper mapper;
	@Autowired
	private ChatGPTClient client;
	

	// 사용자 정보 조회
	public Map<String, String> getName(String id) {
		return mapper.selectName(id);
	}
	
	// 회원 전체 해시태그 조회
	public String getHashtags() {
		return mapper.selectHashtags();
	}
	
	// 클래스 전체 해시태그 조회
	public List<Map<String, String>> getHashtagsByClass(){
		return mapper.selectHashtagsByClass();
	}
	
	// 추천 클래스 요청
	public String requestRecommend() {
		String hashtags = getHashtags();
		List<Map<String, String>> classList = getHashtagsByClass();
		
		String response = client.requestRec(hashtags, classList);
		
		JSONObject jsonObj = new JSONObject(response);
		JSONArray jsonArr = jsonObj.getJSONArray("choices");
		JSONObject firstChoice = jsonArr.getJSONObject(0);
		JSONObject message = firstChoice.getJSONObject("message");
	    String class_ids = message.getString("content").replace("[", "").replace("]", "");
	    
	    return class_ids;
	}
	
	public String requestRecommendPerson(String hashtag) {
		List<Map<String, String>> classList = getHashtagsByClass();
		
		String response = client.requestRec(hashtag, classList);
		
		JSONObject jsonObj = new JSONObject(response);
		JSONArray jsonArr = jsonObj.getJSONArray("choices");
		JSONObject firstChoice = jsonArr.getJSONObject(0);
		JSONObject message = firstChoice.getJSONObject("message");
	    String class_ids = message.getString("content").replace("[", "").replace("]", "");
	    
	    return class_ids;
	}
	
	// 추천 클래스 목록 조회
	public List<Map<String, Object>> getRecommendList(String class_ids) {
		return mapper.selectClassList(class_ids);
	}
	

	
	// ================================================================
	
	// 관리자 - 클래스 등록 시 해시태그 요청
	public String requestHashtag(Map<String, String> classInfo) {
		return client.requestHashtag(classInfo);
	}



	
	
}
