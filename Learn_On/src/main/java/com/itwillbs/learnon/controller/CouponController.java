package com.itwillbs.learnon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.learnon.service.CouponService;

@Controller
public class CouponController {
	@Autowired
	private CouponService couponService;
	
	//=================================================================================
	// 쿠폰선택 클릭시 보유한 쿠폰 목록 조회
	@GetMapping("myCouponList")
	public String couponSelect(
			HttpSession session, Model model) {
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		System.out.println("로그인 아이디: " + sId);
		
		// sId가 null인지 확인 (로그인하지 않은 경우)
		if(sId == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			
			return "result/fail";
		}
		//------------------------------------------------------
		//CouponService - getCoupon() 메서드 호출하여 쿠폰 조회 요청
		List<Map<String, Object>> coupon = couponService.getCoupon(sId);
		//CouponService - getCouponCount() 메서드 호출하여 쿠폰 갯수 조회 요청
		int couponCount = couponService.getCouponCount(sId);
		System.out.println(coupon);
		System.out.println(couponCount);
		
		//리턴받은 쿠폰 데이터 뷰페이지로 전달하기 위해 model에 저장
		model.addAttribute("coupon", coupon);
		model.addAttribute("couponCount", couponCount);

		// 쿠폰 페이지(coupon.jsp)로 포워딩 - Get
		return "cart_payment/mycoupon";
	}
	
	//=================================================================================
	// 쿠폰 발급 클릭시 입력한 쿠폰코드 확인 후 등록
	@GetMapping("CouponCreate")
	public String couponCreate(@RequestParam String couponCode, HttpSession session, Model model) {
		System.out.println("여기까진 왔지? 입력한 쿠폰 코드: " + couponCode);
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		System.out.println("로그인 아이디: " + sId);
		//------------------------------------------------------
		//JSON 형식으로 응답하기 위해 Map에 담아서 반환(일단 미리 생성)
//		Map<String, Object> response = new HashMap<String, Object>();
		
		//CouponService - createCoupon() 메서드 호출하여 쿠폰 발급 요청 (발급여부 리턴)
		boolean isIssued = couponService.createCoupon(sId, couponCode);
		System.out.println("발급 됐나요?:"+ isIssued); //true
		
		if(isIssued) { //발급 성공시
			model.addAttribute("msg", "발급 성공");
//			response.put("result", true);
//			response.put("msg", "쿠폰 발급 성공! 지금 바로 사용해보세요.");
		} else { //발급 실패시
			model.addAttribute("msg", "발급 실패");
//			response.put("result", false);
//			response.put("msg", "해당 쿠폰은 발급 조건을 충족하지 않습니다.");
		}
//		
//		return response; // Map이 JSON으로 변환되어 반환
		//-------------------------------------------
//		// 발급 성공 여부를 모델에 담기
//	    if (isIssued) {
//	        redirectAttributes.addFlashAttribute("result", true);
//	        redirectAttributes.addFlashAttribute("msg", "쿠폰 발급 성공! 지금 바로 사용해보세요.");
//	    } else {
//	        redirectAttributes.addFlashAttribute("result", false);
//	        redirectAttributes.addFlashAttribute("msg", "해당 쿠폰은 발급 조건을 충족하지 않습니다.");
//	    }
	    
	    return "redirect:/Payment";
		
	}
	
	
	
	

	// ===========================================================================================
	// 이전 페이지 이동 저장
//	private void savePreviousUrl(HttpServletRequest request, HttpSession session) {
//		String prevURL = request.getServletPath();
//		String queryString = request.getQueryString();
////			System.out.println("prevURL : " + prevURL);
////			System.out.println("queryString : " + queryString);
//		
//		if (queryString != null) {
//			prevURL += "?" + queryString;
//		}
//		
//		session.setAttribute("prevURL", prevURL);
//	}
	
	
}
