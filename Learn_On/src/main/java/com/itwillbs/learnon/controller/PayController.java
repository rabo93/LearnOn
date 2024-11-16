package com.itwillbs.learnon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.CartService;
import com.itwillbs.learnon.service.PayService;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	//=================================================================================
	// Payment 서블릿 주소 로드시 매핑 - GET
	@GetMapping("Payment")
	public String payPage() {
		return "cart_payment/payment"; // payment.jsp
	}
	//=================================================================================
	// 결제 페이지 비즈니스 로직 - POST
	@PostMapping("Payment")
	public String payment() {
		
		
		
		
		
		return "redirect:/Payment"; //작업 완료 후 결제 서블릿 주소로 리다이렉트
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//=================================================================================
	// "Terms" 이용약관 페이지 매핑 - GET
	@GetMapping("Terms")
	public String termPage() {
		return "info/terms";
	}
	
	//=================================================================================
	// "PaySuccess" 매핑 - GET => 결제 완료 뷰페이지 포워딩
	@GetMapping("PaySuccess")
	public String paySuccess() {
		return "cart_payment/pay_success";
	}
	
}
