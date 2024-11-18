package com.itwillbs.learnon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.learnon.service.CouponService;
import com.itwillbs.learnon.vo.CouponVO;


@Controller
public class CouponController {
	@Autowired
	private CouponService couponService;

	//=================================================================================
	@GetMapping("Coupon")
	public String couponSelect(HttpSession session, Model model) {
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		System.out.println("로그인 아이디: " + sId);
		
		// sId가 null인지 확인 (로그인하지 않은 경우)
		if(sId == null) {
			model.addAttribute("msg", "로그인 후 진행해주세요.");
			return "redirect:/MemberLogin"; //로그인 페이지로 리다이렉트
		}
		//------------------------------------------------------
				
		//CouponService - getCoupon() 메서드 호풀하여 쿠폰 조회 요청
		List<CouponVO> coupon = couponService.getCoupon(sId);
		System.out.println(coupon);
		
		//리턴받은 쿠폰 데이터 뷰페이지로 전달하기 위해 model에 저장
		model.addAttribute("coupon", coupon);
		
		// 쿠폰 페이지(coupon.jsp)로 포워딩 - Get
		return "cart_payment/coupon";
	}
	//=================================================================================
	
}
