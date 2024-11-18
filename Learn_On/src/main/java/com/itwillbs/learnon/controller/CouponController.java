package com.itwillbs.learnon.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
