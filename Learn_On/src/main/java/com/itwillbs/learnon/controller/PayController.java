package com.itwillbs.learnon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.learnon.service.PayService;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.PurchaseVO;

@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
//	private IamportClient api; //선언한 api를 이용하여 아임포트에서 제공되는 다양한 API 를 사용할 수 있음
//	private PrePaymentRepository prePaymentRepository;
	
	//=================================================================================
	// "Payment" 서블릿 주소 로드시 매핑 - GET
	// 결제 목록 조회 비즈니스 로직
	@GetMapping("Payment")
	public String payment(@RequestParam(value = "checkitem", required = false) List<String> checkItems,
						 HttpSession session, Model model) {
		// checkItems가 제대로 전달되었는지 확인
//	    System.out.println("(Payment)선택한 장바구니 번호: " + checkItems); //[4, 3, 2, 1]
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		System.out.println("결제할 로그인 아이디: " + sId);
		//------------------------------------------------------
		//sId를 이용해 주문정보 객체 호출
		MemberVO member = payService.getMemberInfo(sId);
	    
		// List<String>으로 전달하여 getSelectedCarts 호출
	    List<PurchaseVO> selectedItems = payService.getSelectedCart(checkItems);
//	    System.out.println("selectedItems: " + selectedItems);
	    
	    
	    // 회원 정보 및 선택된 상품 정보를 Model에 추가하여 payment.jsp로 전달
	    model.addAttribute("member", member);
	    model.addAttribute("selectedCartList", selectedItems);

	    // 결제 페이지로 이동
	    return "cart_payment/payment";
	}
	
	//=================================================================================
	// 결제금액 위변조 검증 (클라이언트가 스크립트를 조작해 금액 위변조 방지)
	// 결제하고자 하는 상품의 금액과 실제로 결제된 금액을 비교!!!
	// 아임포트에서 제공하는 자바용 라이브러리 사용(https://github.com/iamport/iamport-rest-client-java?tab=readme-ov-file)
	// 1. 결제 사전 검증
//	@ResponseBody
//	@PostMapping("Payment/prepare")
//	public void preparePayment(@RequestBody PayVO pay) 
//								throws IamportResponseException, IOException {
//		payService.postPrepare(pay);
//	}
//	
//	public void postPrepare(PayVO pay) throws IamportResponseException, IOException {
//		PrepareData prepareData = new PrepareData(pay.getMerchantId(), pay.getTotalPrice());
//		api.postPrepare(prepareData);  // 사전 등록 API 
//		
//		prePaymentRepository.save(pay); // 주문번호와 결제예정 금액 DB 저장
//	}
	
	//--------------------------------------------------------
	// 2. 결제 사후 검증
	// - 사후 검증은 클라이언트에서 결제 요청이 끝난 후 이루어진다. 
	// - 결제 요청 후 응답받은 내용을 바탕으로 실 결제금액과 자체 DB에 저장된 결제요청금액을 비교한다.
	// - 테스트 환경에서는 부분 환불이 불가능하므로 전체 환불 처리
//	@PostMapping("Payment/validate")
//	public Payment validatePayment() {
//		
//		
//		return paymentService.validatePayment(request);
//	}
	
//	 public Payment validatePayment(PaymentDTO request) throws IamportResponseException, IOException {
//	        PrePaymentEntity prePayment = prePaymentRepository.findById(request.getMerchant_uid()).orElseThrow();
//	        BigDecimal preAmount = prePayment.getAmount(); // DB에 저장된 결제요청 금액 
//	        
//	        IamportResponse<Payment> iamportResponse = api.paymentByImpUid(request.getImp_uid());
//	        BigDecimal paidAmount = iamportResponse.getResponse().getAmount(); // 사용자가 실제 결제한 금액
//			
//			// 두 금액이 다르다면 바로 결제 취소
//	        if (!preAmount.equals(paidAmount)) {
//	            CancelData cancelData = cancelPayment(iamportResponse);
//	            api.cancelPaymentByImpUid(cancelData);
//	        }
//
//	        return iamportResponse.getResponse();
//	    }
	//--------------------------------------------------------
	// 사후 처리 후 결제정보&주문정보 저장하기 => AJAX로 요청 후 서버응답
	// 3. 아래 코드는 결제 테스트 검증 후 진행하기
//	 @PostMapping("/save_buyerInfo")
//	 @ResponseBody

//    @PostMapping("/save_orderInfo")
//    @ResponseBody
    
	// OrderSerivce
//    @Transactional
//    public void save_buyerInfo(BuyerEntity request) {
//        buyerRepository.save(request);
//    }
//
//    @Transactional
//    public void save_orderInfo(OrderEntity request) {
//        orderRepository.save(request);
//    }
//
//    @Transactional
//    public void deleteCart(Long cartid, String userid) {
//        CartEntity cart = cartRepository.findByUseridAndCartid(userid, cartid);
//        cartRepository.delete(cart);
//    }
	
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
