package com.itwillbs.learnon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	// 쿠폰 발급 클릭시 입력한 쿠폰코드 확인 후 등록 - AJAX
	@ResponseBody
	@GetMapping(value = "CouponCreate", produces = "application/text; charset=UTF-8")
//	public String couponCreate(@RequestParam String couponCode, HttpSession session, HttpServletResponse response) {
	public String couponCreate(@RequestParam String couponCode, HttpSession session) {
//	public Map<String, Object> couponCreate(@RequestParam String couponCode, HttpSession session) {
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		System.out.println("로그인 아이디: " + sId);
		//------------------------------------------------------
		//CouponService - createCoupon() 메서드 호출하여 쿠폰 발급 요청 (발급여부 리턴)
		boolean isIssued = couponService.createCoupon(sId, couponCode);
		System.out.println("발급 됐나요?:"+ isIssued);
		
		//--------------------------------
		//String 문자열로 리턴할때
//		response.setCharacterEncoding("UTF-8"); //한글 인코딩
//		return isIssued ? "발급 성공" : "발급 실패"; //String으로 리턴
		//--------------------------------
		//JSON객체 생성
//		JSONObject json = new JSONObject();
//		//JSON 요소 추가({"key" : "value"})
//		json.put("success", isIssued);
//		System.out.println("json success값: "+ json.get("success")); ; //출력됨
//		return json;
		//--------------------------------
		//Map으로 해보자!!!
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("success", isIssued);
//		System.out.println(response.get("success"));
		
		//AJAX으로 다시 응답 넘겨줄때 Map으로 넘어가지 않음 JSON으로 바꾸고 문자열 형식으로 리턴해줘야함!!!!!!!!!!!!!!!!
		JSONObject jo = new JSONObject(response);
		return jo.toString(); 
	}
	
	//=================================================================================
	
	
	
	
	
}
