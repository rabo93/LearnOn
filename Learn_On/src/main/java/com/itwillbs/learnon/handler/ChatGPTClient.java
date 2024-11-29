package com.itwillbs.learnon.handler;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ChatGPTClient {
	
	@Value("${gpt.API_KEY")
	private String apiKey;
	
	private String url = "";
	private String model ="gpt-4o-mini"; //GPT모델
	private double temperature = 0.5;
	
	
}
