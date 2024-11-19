package com.itwillbs.learnon.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.learnon.service.CouponService;
import com.itwillbs.learnon.service.PayService;
import com.itwillbs.learnon.vo.CouponVO;
import com.itwillbs.learnon.vo.PurchaseVO;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	//=================================================================================
	// Payment 서블릿 주소 로드시 매핑 - POST
	// 결제 목록 조회 비즈니스 로직
	@PostMapping("Payment")
	public String payment(@RequestParam(value = "checkitem", required = false) List<String> checkItems, Model model) {
		// checkItems가 제대로 전달되었는지 확인
//	    System.out.println("(Payment)선택한 장바구니 번호: " + checkItems); //[4, 3, 2, 1]
	    
	    // List<String>으로 전달하여 getSelectedCarts 호출
	    List<PurchaseVO> selectedItems = payService.getSelectedCart(checkItems);
//	    System.out.println("selectedItems: " + selectedItems);
	    
	    // 선택된 상품 정보를 Model에 추가하여 payment.jsp로 전달
	    model.addAttribute("selectedCartList", selectedItems);

	    // 결제 페이지로 이동
	    return "cart_payment/payment";
	}
	
	//=================================================================================
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
