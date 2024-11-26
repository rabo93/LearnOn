package com.itwillbs.learnon.controller;

import java.io.IOException;
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

import com.itwillbs.learnon.service.PayService;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.OrderVO;
import com.itwillbs.learnon.vo.PayCancelVO;
import com.itwillbs.learnon.vo.PayVO;
import com.itwillbs.learnon.vo.PayVerificationVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;


@Controller
public class PayController {
	@Autowired
	private PayService payService;
	
	//IamportClient 객체 생성 - 포트원에서 제공
	private IamportClient iamportClient;
	
	public PayController() {
		this.iamportClient = new IamportClient("1582333057803703", "Xeql20bTzSYAkeu3qPVXGoU3GEn0Ve4WKSmXsZViEAIrMFoJKE8n8q78DJlZMXkconSi5Nd3JpfpUX7h");
	}
	
	//=================================================================================
	// "Payment" 서블릿 주소 로드시 매핑 - GET
	// 결제 목록 조회 비즈니스 로직
	@GetMapping("Payment")
	public String payment(@RequestParam(value = "checkitem", required = false) List<String> checkItems,
						 HttpSession session, Model model) {
//	    System.out.println("(Payment)선택한 장바구니 번호: " + checkItems); //[4, 3, 2, 1]
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		System.out.println("결제할 로그인 아이디: " + sId);
		//------------------------------------------------------
		// PayService - getMemberInfo() 메서드 호출
		// 파라미터 : sId  	리턴타입 : MemberVO
		MemberVO member = payService.getMemberInfo(sId);
	    
		// PayService - getSelectedCart() 메서드 호출
		// 파라미터 : checkItems(List)  리턴타입 : OrderVO(List)
	    List<OrderVO> selectedItems = payService.getSelectedCart(checkItems);
//	    System.out.println("selectedItems: " + selectedItems);
	    
	    // 회원 정보 및 선택된 상품 정보를 Model에 추가하여 payment.jsp로 전달
	    model.addAttribute("member", member);
	    model.addAttribute("selectedCartList", selectedItems);

	    // 결제 페이지로 이동
	    return "cart_payment/payment";
	}
	
	//=================================================================================
	// 1. 결제 사후 검증
	// - 사후 검증은 클라이언트에서 결제 요청이 끝난 후 이루어진다. 
	// - 결제 요청 후 응답받은 내용을 바탕으로 실 결제금액과 자체 DB에 저장된 결제요청금액을 비교한다.
	// - 테스트 환경에서는 부분 환불이 불가능하므로 전체 환불 처리
	@ResponseBody
	@PostMapping("/payments/verification")
	public IamportResponse<Payment> paymentByImpUid(@RequestBody PayVerificationVO payVerificationVO) throws IamportResponseException, IOException {
		System.out.println("결제검증VO : " + payVerificationVO); //결제검증VO: PayVerificationVO(imp_uid=imp_600839946642, merchant_uid=2024112421267, amount=1004)
	
		//IamportClient클래스의 paymentByImpUid() 함수 호출
		//=> 파라미터: PayVerificationVO(imp_uid) 	/리턴: IamportResponse<Payment>
		return iamportClient.paymentByImpUid(payVerificationVO.getImp_uid());
	}
	
	//--------------------------------------------------------
	// 2. 결제 성공 후 결제정보&주문정보 DB 저장
	@ResponseBody
	@PostMapping("payinfoSave")
	public String  savePayInfo(@RequestBody PayVO payVO) {
		System.out.println("결제저장DTO : " + payVO);
		
		//결제정보 저장 호출
		payService.savePayInfo(payVO);
		
		//ajax 응답 데이터로 넘겨줄 response 저장
		String response = payVO.getMerchant_uid();
		return  response;
	}
	
	@ResponseBody
    @PostMapping("orderinfoSave")
	public String orderPayInfo(@RequestBody OrderVO orderVO, Model model) {
		System.out.println("컨트롤러에 넘겨받은 주문저장VO : " + orderVO);
		//OrderVO(order_idx=0, merchant_uid=2024112528321, mem_id=bborara
		//		, items=[OrderItemVO(class_id=1, class_price=75000), OrderItemVO(class_id=2, class_price=1004)]
		//		, coupon_id=2, price=0)
		
		//주문정보 & 나의클래스 저장
		payService.saveOrderInfo(orderVO);
		
		//쿠폰 사용 상태 업데이트
		payService.couponUsed(orderVO.getCoupon_id());
		
		//ajax 응답 데이터로 넘겨줄 response 저장
		//=> 저장 완료되면 결제 결과 페이지로 이동하고, 주문고유번호를 가지고가서 표출함.
		String response = orderVO.getMerchant_uid();
		return response;
	}
	
	//--------------------------------------------------------
	// 결제 취소
	@ResponseBody
	@PostMapping("/payments/cancel")
	public IamportResponse<Payment> cancelPaymentbyImpUid(@RequestBody PayCancelVO paycancelVO) throws IamportResponseException, IOException {
		System.out.println("결제 취소에 필요한 VO: " + paycancelVO); 
		
		String impUid = paycancelVO.getImp_uid();
		
		//취소하면 결제 상태값 업데이트
		payService.payStatusUpdate(paycancelVO.getImp_uid());
		
		//IamportClient클래스의 cancelPaymentByImpUid() 함수 호출
		//=> 파라미터: CancelData클래스 	/리턴: IamportResponse<Payment>
		//CancelData(결제를 취소할때 사용하기위한 클래스) : 주의! 이름 맞춰줘야함!
		return iamportClient.cancelPaymentByImpUid(new CancelData(impUid, true));
	}
	
	
	//=================================================================================
	// "Terms" 이용약관 페이지 매핑 - GET
	@GetMapping("Terms")
	public String termPage() {
		return "info/terms";
	}
	
	//=================================================================================
	// "PayResult" 매핑 - GET 
	@GetMapping("PayResult")
	public String paySuccess(@RequestParam String merchant_uid, Model model) {
		System.out.println("주문고유번호;" + merchant_uid);
		
		//결제 정보 조회
		PayVO payinfo = payService.getPayInfo(merchant_uid);
		System.out.println("결제완료시정보:" + payinfo);
		
		//뷰페이지에 전달
		model.addAttribute("payinfo", payinfo);
		
		
		return "cart_payment/pay_result";
	}
	
}
