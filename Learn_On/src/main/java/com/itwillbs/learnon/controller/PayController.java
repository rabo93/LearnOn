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
	// 결제 페이지(patment.jsp) 매핑 - POST
	// 결제 페이지 비즈니스 로직 
	// 장바구니 페이지에서 
	@ResponseBody
	@PostMapping("Payment")
	public String payForm() {
		
		
		
		
		
		
		return "cart_payment/payment"; // payment.jsp
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
