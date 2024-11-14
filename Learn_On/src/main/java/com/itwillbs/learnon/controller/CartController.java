package com.itwillbs.learnon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.learnon.service.CartService;
import com.itwillbs.learnon.vo.CartVO;
import com.itwillbs.learnon.vo.MemberVO;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	//=================================================================================
	// 장바구니 목록 조회 (회원아이디를 받아서 그 회원id에 해당하는 장바구니 목록 조회)
	// 클래스제목(CLASS_TITLE), 강사이름(MEM_NAME), 클래스가격(CLASS_PRICE) 
	@GetMapping("Cart")
	public String cartList( @RequestParam(value = "memId", required = false, defaultValue = "rabo") String memId
			//컨트롤러 메서드에서 memId 파라미터에 기본값을 설정하면, memId가 전달되지 않았을 때 기본값을 사용하도록 할 수 있음
			//이 경우 memId가 하드코딩으로 설정되는데, 사용자가 미리 로그인하거나 멤버 정보를 선택하여야 할 수 있음
			, Model model) {
		
		//로그인 정보 가져오기
//		MemberVO loginInfo = (MemberVO)(session.getAttribute("loginInfo"));
		
		// loginInfo가 null인지 확인 (로그인하지 않은 경우)
//		if(loginInfo == null) {
//			return "redirect:/MemberLogin"; //로그인 페이지로 리다이렉트
//		}
		
		//--------------------------------------------------------------
		//CartService - getCartList() 메서드 호풀하여 장바구니 조회 요청
		// MEM_ID 가져와서 cartService로 장바구니 목록 조회
//	    String memId = loginInfo.getMEM_ID();
	    List<CartVO> cartList = cartService.getCartList(memId);
//		List<CartVO> cartList = cartService.getCartList(loginInfo.getMEM_ID());
//		System.out.println(cartList);// [CartVO(CARTITEM_IDX=0, CLASS_ID=0, MEM_ID=null, CLASS_TITLE=자바 초급 강의 4편, MEM_NAME=김선생, CLASS_PRICE=70000, cnt=0), ..., CartVO(CARTITEM_IDX=0, CLASS_ID=0, MEM_ID=null, CLASS_TITLE=자바 고급 강의 1편, MEM_NAME=김선생, CLASS_PRICE=55000, cnt=0)]

		model.addAttribute("cartList", cartList); //jsp뷰페이지로 cartList 객체 전달
		
		//-------------------------------
		// 장바구니 페이지(Cart)로 포워딩
		return "cart_payment/cart";
	}
	
	
	
	//=================================================================================
	// 상품 정보 내역 클릭시 강의 상세 페이지로 이동(CLASS_ID 전달)
	@GetMapping("CourseDetail")
	public String CourseDetail() {
		return "course_detail"; 
	}
	
	
	
	//=================================================================================
	// X 버튼 클릭시 CARTITEM_IDX 확인 후 장바구니 상품 삭제 
//	@GetMapping("DeleteItem")
//	public String deleteItem(CartVO cart, HttpSession session, Model model) {
//		System.out.println(cart);
//		System.out.println(cart.getCARTITEM_IDX());
//		
////		// CartService - deleteCart() 메서드 호출
////		// 파라미터 : CARTITEM_IDX    리턴타입 : int(삭제갯수)
////		int cartId = cart.getCARTITEM_IDX();
////		int deleteCount = cartService.deleteCart(cartId);
////		
////		//DB 삭제 결과 
////		if(deleteCount > 0) { //삭제 성공시
////			model.addAttribute("carList", cart);
////			model.addAttribute("msg", "삭제 성공");
////			
////		} else { //실패시
////			
////			model.addAttribute("msg", "삭제 실패");
////			
////		}
//		
//		
////		//장바구니 페이지로 리다이렉트
//		return "redirect:/Cart";
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
