package com.itwillbs.learnon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.learnon.service.CouponService;
import com.itwillbs.learnon.vo.CouponVO;


@Controller
public class CouponController {
	@Autowired
	private CouponService couponService;
	

	//=================================================================================
	@GetMapping("Coupon")
	public String couponSelect(@RequestParam(value = "memId", required = false, defaultValue = "'hong1234'") String memId, Model model) {
		
		//CouponService - getCoupon() 메서드 호풀하여 쿠폰 조회 요청
		List<CouponVO> coupon = couponService.getCoupon(memId);
		System.out.println(coupon);
		
		model.addAttribute("coupon", coupon);
		
		// 쿠폰 페이지(coupon.jsp)로 포워딩 - Get
		return "cart_payment/coupon";
	}
	
	// 쿠폰 목록 조회(전달받은 회원ID로 조회)
//	@PostMapping("Coupon")
//	public String couponList(CouponVO coupon, HttpSession session, Model model, HttpServletRequest request) {
		//세션에 저장된 아이디 체크하기
//		String id = (String)session.getAttribute("sId");
//		if(id == null) {
//			model.addAttribute("msg", "로그인 필수!\\n로그인 페이지로 이동합니다.");
//			model.addAttribute("targetURL", "MemberLogin");
//			// ----------------------------------------------------------------
//			// 로그인 완료 후 다시 회원 상세정보 조회 페이지로 이동할 수 있도록
//			// 세션 객체에 회원 상세정보 조회 페이지의 서블릿 주소를 저장 후
//			// 로그인 완료 시 해당 주소로 리다이렉트 수행할 수 있다!
////						session.setAttribute("prevURL", "MemberInfo");
//			// => 경로를 직접 입력하지 않고 request 객체의 getServletPath() 메서드로 서블릿 주소 추출 가능
//			String prevURL = request.getServletPath();
//			String queryString = request.getQueryString(); // URL 파라미터 가져오기(없으면 null)
//			
//			// URL 파라미터(쿼리)가 null 이 아닐 경우 prevURL 에 결합(? 포함)
//			if(queryString != null) {
//				prevURL += "?" + queryString;
//			}
//			
//			// 세션 객체에 prevURL 값 저장
//			session.setAttribute("prevURL", prevURL);
//			// ----------------------------------------------------------------
//			
//			return "result/fail";
//		}
		
//		coupon.setMEM_ID(id);;
//		coupon = couponService.getCoupon(coupon);
//		
//		model.addAttribute("coupon", coupon);
//		
//		return "cart_payment/coupon";
//	}
	
}
