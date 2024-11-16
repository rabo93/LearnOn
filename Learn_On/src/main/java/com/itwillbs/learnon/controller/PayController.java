package com.itwillbs.learnon.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.CartService;
import com.itwillbs.learnon.service.PayService;
import com.itwillbs.learnon.vo.CartVO;
import com.itwillbs.learnon.vo.PayVO;
import com.itwillbs.learnon.vo.PurchaseVO;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	//=================================================================================
	// Payment 서블릿 주소 로드시 매핑 - GET
//	@GetMapping("Payment")
//	public String payPage(HttpSession session, Model model) {
//		System.out.println("payment 컨트롤러 시작 - Get");
//		
//		// 세션에서 선택된 장바구니 상품 가져오기
//		@SuppressWarnings("unchecked")
//		List<CartVO> selectedItems = (List<CartVO>) session.getAttribute("selectedItems");
//		System.out.println(selectedItems);
//		
//		if (selectedItems == null || selectedItems.isEmpty()) {
//			return "redirect:/Cart";  // 선택된 상품이 없으면 장바구니 페이지로 리다이렉트
//        }
//		
//		//payment.jsp 뷰페이지로 전달
//		model.addAttribute("selectedItems", selectedItems);
//		
//		return "cart_payment/payment"; // payment.jsp
//	}
	
	@PostMapping("Payment")
	public String payment(@RequestParam(value = "checkitem", required = false) List<String> checkItems, 
							Model model) {
		// 선택된 상품이 없다면 처리
		if (checkItems == null || checkItems.isEmpty()) {
			model.addAttribute("msg", "상품을 선택해주세요.");
			return "redirect:/Cart";
		}
		
		// checkItems가 제대로 전달되었는지 확인
	    System.out.println("(Payment)선택한 장바구니 번호: " + checkItems);
		//(Payment)선택한 장바구니 번호: [4, 3, 2, 1]
	    
	    
	    // List<String>으로 전달하여 getSelectedCarts 호출
	    List<PurchaseVO> selectedItems = payService.getSelectedCart(checkItems);
	    System.out.println("selectedItems: " + selectedItems);
	    
	    // PurchaseVO로 변환
//	    List<PurchaseVO> selectedItems = new ArrayList<>();
//	    for (CartVO cart : cartItems) {
//	        PurchaseVO purchase = new PurchaseVO(
//	            cart.getClass_id(),
//	            cart.getClass_title(),
//	            cart.getMem_name(),
//	            cart.getClass_price(),
//	            cart.getClass_pic1()
//	        );
//	        selectedItems.add(purchase);
//	    }
	    
	    
	    // 선택된 상품 정보를 Model에 추가하여 payment.jsp로 전달
	    model.addAttribute("selectedCartList", selectedItems);

	    // 결제 페이지로 이동
	    return "cart_payment/payment";
	}
	
	
	//=================================================================================
	// 결제 페이지 비즈니스 로직 - POST
//	@ResponseBody // AJAX 응답으로 JSON 반환
//	@PostMapping("Payment")
//	public String payment(@RequestBody PayVO pay, HttpSession session ) {
//		System.out.println("payment 컨트롤러 시작 - Post"); // 왜 두개가 나오지..?
//		
//		String sId = (String) session.getAttribute("sId");
//		System.out.println("로그인 아이디: " + sId);
//		System.out.println(pay);
//		
//		
//		
//		return "redirect:/Payment"; //작업 완료 후 결제 서블릿 주소로 리다이렉트
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
