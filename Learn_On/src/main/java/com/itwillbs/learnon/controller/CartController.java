package com.itwillbs.learnon.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.CartService;
import com.itwillbs.learnon.vo.CartVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	//=================================================================================
	// Cart 서블릿 주소 로드시 장바구니 목록 조회 (회원아이디를 받아서 그 회원id에 해당하는 장바구니 목록 조회)
	// 클래스제목(class_title), 강사이름(mem_name), 클래스가격(class_price) 
	@GetMapping("Cart")
	public String cartList(HttpSession session, Model model) {
		//------------------------------------------------------
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		log.info("로그인 아이디: " + sId);
		
		// sId가 null인지 확인 (로그인하지 않은 경우)
		if(sId == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			
			return "result/fail";
		}
		//------------------------------------------------------
		// CartService - getCartList() 메서드 호출하여 장바구니 목록 조회 요청
	    List<CartVO> cartList = cartService.getCartList(sId);
	    log.info("장바구니 목록: " + cartList);
	    
	    // Model 객체에 cartList 객체 결과값 저장하고 jsp뷰페이지로 객체 전달
		model.addAttribute("cartList", cartList); 
		
		// 장바구니 페이지(Cart)로 포워딩
		return "cart_payment/cart";
	
	}
	//=================================================================================
	@ResponseBody
	@PostMapping("SubcribeClassCheck")
	public ResponseEntity<Integer> subcribeClassCheck(@RequestParam("cartitem_idx") String cartitem) {
		
		// cartitem_idx를 콤마로 구분(분리)하여 각각의 요소를 List<Integer>객체(배열)에 묶어서 저장
		List<Integer> cartItems = Arrays.stream(cartitem.split(",")) //Arrays.stream()은 배열을 스트림으로 변환
								.map(Integer::parseInt) //map()은 스트림의 각 요소에 대해 변환 작업, 지금은 String 값을 Integer로 변환하는 작업 
								.collect(Collectors.toList());//Stream<Integer>로 변환된 값을 다시 List<Integer>로 변환
		
		log.info("체크된 강의 리스트: " + cartItems);
		
		// CartService - alreadySubcribeClass() 메서드 호출
		// 파라미터 : cartItems(여러개)    리턴타입 : int(조회갯수)
		int alreadySubCounts = cartService.alreadySubcribeClass(cartItems);
		log.info("조회된 결과: " + alreadySubCounts); //0
		
		// 갯수 그대로 반환
	    return ResponseEntity.ok(alreadySubCounts);
		
	}
	
	
	//=================================================================================
	// DeleteItem 서블릿 주소 로드시 비즈니스 로직
	// 1) X 버튼 클릭시 cartitem_idx 확인 후 장바구니 상품 삭제 
	@GetMapping("DeleteItem")
	public String deleteItem(@RequestParam("cartitem_idx") String cartitem,
							  Model model) {
		// CartService - deleteCart() 메서드 호출
		// 파라미터 : cartitem(1개)    리턴타입 : int(삭제갯수)
		int deleteCount = cartService.deleteCart(cartitem);
		
		//DB 삭제 결과 
		if(deleteCount > 0) { //삭제 성공시
			model.addAttribute("msg", "삭제 성공");
		} else { //실패시
			model.addAttribute("msg", "삭제 실패");
		}
		
		//장바구니 페이지로 리다이렉트
		return "redirect:/Cart";
	}
	
	//=================================================================================
	// DeleteItems 서블릿 주소 로드시 비즈니스 로직
	// 2) '선택삭제' 버튼 클릭시 체크한 여러개의 cartitem_idx 확인 후 장바구니 상품 삭제
	@GetMapping("DeleteItems")
	public String deleteItems(@RequestParam("cartitem_idx") String cartitem, Model model) {
		
		// cartitem_idx를 콤마로 구분(분리)하여 각각의 요소를 List<Integer>객체(배열)에 묶어서 저장
		List<Integer> cartItems = Arrays.stream(cartitem.split(",")) //Arrays.stream()은 배열을 스트림으로 변환
								.map(Integer::parseInt) //map()은 스트림의 각 요소에 대해 변환 작업, 지금은 String 값을 Integer로 변환하는 작업 
								.collect(Collectors.toList());//Stream<Integer>로 변환된 값을 다시 List<Integer>로 변환
		
		// CartService - deleteManyCart() 메서드 호출
		// 파라미터 : cartItems(여러개)    리턴타입 : int(삭제갯수)
		int deleteCounts = cartService.deleteManyCart(cartItems);
		
		//DB 삭제 결과 
		if(deleteCounts > 0) { //삭제 성공시
			model.addAttribute("msg", "삭제 성공");
		} else { //실패시
			model.addAttribute("msg", "삭제 실패");
		}
		
		//장바구니 페이지로 리다이렉트
		return "redirect:/Cart";
	}
	
	//=================================================================================
	// top.jsp 페이지 헤더부분 장바구니 아이콘에 장바구니 갯수 표시 => AJAX로 요청받음(비동기)
	@ResponseBody
	@GetMapping("CartCount")
	public String cartCount(HttpSession session, Model model) {
		// 로그인 정보 가져오기 (세션 아이디값 확인)
		String sId = (String) session.getAttribute("sId");
		log.info("로그인 아이디: " + sId);
		
		//JSON 형식으로 응답하기 위해 Map에 담아서 반환
		Map<String, Object> data = new HashMap<String, Object>();
		
		if(sId == null) { // 로그인하지 않은 경우
			data.put("isLogin", false);
		} else {
			//해당 로그인아이디로 담긴 장바구니 갯수 조회 요청 => 리턴받은 갯수를 cartCount에 저장
			int cartCount = cartService.getCartCount(sId);
			
			data.put("isLogin", true);
			data.put("cartCount", cartCount);
			// { isLogin : true, cartCount : 4 }
		}
		
		//Map으로 담은 JSON을 화면에 표출하기 위해서는 JSONObject으로 생성
		JSONObject jo = new JSONObject(data);
		
		return jo.toString(); //문자열로 변환하여 리턴
	}
	
	
}