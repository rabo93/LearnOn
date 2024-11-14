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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.CartService;
import com.itwillbs.learnon.vo.CartVO;
import com.itwillbs.learnon.vo.MemberVO;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;
	
	//=================================================================================
	// 장바구니 목록 조회 (회원아이디를 받아서 그 회원id에 해당하는 장바구니 목록 조회)
	// 클래스제목(class_title), 강사이름(mem_name), 클래스가격(class_price) 
	@GetMapping("Cart")
	public String cartList( 
			@RequestParam(value = "sId", defaultValue = "bborara") String sId
			//이 경우 sId가 하드코딩으로 설정(테스트용), 사용자가 미리 로그인하거나 멤버 정보를 선택하여야 할 수 있음
			//컨트롤러 메서드에서 sId 파라미터에 기본값을 설정하면, sId가 전달되지 않았을 때 기본값을 사용하도록 할 수 있음
			, HttpSession session
			, Model model) {
		
		// 로그인 정보 가져오기 (세션 아이디값 확인) => 나중에 로그인 페이지 다 구현되고 작업하기
//		String sId = (String) session.getAttribute("sId");
//		System.out.println(sId);
		
		// sId가 null인지 확인 (로그인하지 않은 경우)
//		if(sId == null) {
//			model.addAttribute("msg", "로그인 후 진행해주세요.");
//			return "redirect:/MemberLogin"; //로그인 페이지로 리다이렉트
//		}
		
		//--------------------------------------------------------------
		// CartService - getCartList() 메서드 호출하여 장바구니 목록 조회 요청
	    List<CartVO> cartList = cartService.getCartList(sId);
//		System.out.println(cartList);// [CartVO(CARTITEM_IDX=7, CLASS_ID=240107, MEM_ID=teacher01, CLASS_TITLE=자바 초급 강의 4편, MEM_NAME=이선생, CLASS_PRICE=70000, CLASS_PIC1=, cnt=0), CartVO(CARTITEM_IDX=6, CLASS_ID=240106...
	    
	    // Model 객체에 cartList 객체 결과값 저장하고 jsp뷰페이지로 객체 전달
		model.addAttribute("cartList", cartList); 
		
		// 장바구니 페이지(Cart)로 포워딩
		return "cart_payment/cart";
	
	}//Cart-Get매핑 끝
	
	//=================================================================================
	// 상품 정보 내역 클릭시 강의 상세 페이지로 이동(class_id 전달)
	@GetMapping("CourseDetail")
	public String CourseDetail() {
		return "course_detail"; 
	}//CourseDetail-Get매핑 끝
	
	
	//=================================================================================
	// DeleteItem 서블릿 주소 매핑시 비즈니스 로직
	// 1) X 버튼 클릭시 cartitem_idx 확인 후 장바구니 상품 삭제 
	@GetMapping("DeleteItem")
	public String deleteItem(@RequestParam("cartitem_idx") String cartitem,
							  Model model) {
		
		// CartService - deleteCart() 메서드 호출
		// 파라미터 : CARTITEM_IDX    리턴타입 : int(삭제갯수)
		int deleteCount = cartService.deleteCart(cartitem);
		
		
		//DB 삭제 결과 
		if(deleteCount > 0) { //삭제 성공시
			model.addAttribute("msg", "삭제 성공");
		} else { //실패시
			model.addAttribute("msg", "삭제 실패");
		}
		
		//장바구니 페이지로 리다이렉트
		return "redirect:/Cart";
	}//DeleteItem-Get매핑끝
	
	
	// 2) '선택삭제' 버튼 클릭시 체크한 여러개의 cartitem_idx 확인 후 장바구니 상품 삭제
	@GetMapping("DeleteItems")
	public String deleteItems(@RequestParam("cartitem_idx") String cartItemsParam, Model model) {
//		System.out.println("DeleteItems 호출됨");
		
		// cartitem_idx를 콤마로 구분(분리)하여 각각의 요소를 List<Integer>객체(배열)에 묶어서 저장
		List<Integer> cartItems = Arrays.stream(cartItemsParam.split(",")) //Arrays.stream()은 배열을 스트림으로 변환
								.map(Integer::parseInt) //map()은 스트림의 각 요소에 대해 변환 작업, 지금은 String 값을 Integer로 변환하는 작업 
								.collect(Collectors.toList());//Stream<Integer>로 변환된 값을 다시 List<Integer>로 변환
//		System.out.println(cartItems); //[8, 7, 6, 3]
		
		
		// CartService - deleteManyCart() 메서드 호출
		// 파라미터 : CARTITEM_IDXS(List객체..?)    리턴타입 : int(삭제갯수)
		int deleteCounts = cartService.deleteManyCart(cartItems);
		

		//INFO : jdbc.sqltiming - DELETE FROM CART WHERE CARTITEM_IDX IN ( 5 , 4 ) 
//		 {executed in 66 msec}
//		System.out.println("삭제된 항목 수: " + deleteCounts); //삭제된 항목 수: 4
		
		
		//DB 삭제 결과 
		if(deleteCounts > 0) { //삭제 성공시
			model.addAttribute("msg", "삭제 성공");
		} else { //실패시
			model.addAttribute("msg", "삭제 실패");
		}
		
		//장바구니 페이지로 리다이렉트
		return "redirect:/Cart";
	}//DeleteItem-Get매핑끝
	
	
	//=================================================================================
	// 장바구니 갯수 표시
	@ResponseBody
	@GetMapping("CartCount")
	public String cartCount(@RequestParam(value = "sId", defaultValue = "bborara") String sId,
							HttpSession session) {
		
		//세션아이디값 가져오기 => 멤버로그인 연동하고 설정
//		String sId = (String) session.getAttribute("sId");
//		System.out.println(sId);
		
		//로그인 여부
//		if (sId == null) {
//	        return "redirect:/MemberLogin"; //로그인 페이지로 리다이렉트
//			return Collections.singletonMap("cartCount", 0);  // 로그인되지 않은 경우 0 반환
//	    }
		
		//해당 로그인아이디로 담긴 장바구니 갯수 조회 요청
		int cartCount = cartService.getCartCount(sId);
		
		//JSON 형식으로 응답하기 위해 Map에 담아서 반환
		Map<String, Integer> result = new HashMap<String, Integer>();
		result.put("cartCount", (Integer)cartCount);
		
		//Map으로 담은 JSON을 화면에 표출하기 위해서는 JSONObject으로 생성
		JSONObject jo = new JSONObject(result);
		
		return jo.toString(); //문자열로 변환하여 리턴
	}
	
	//=================================================================================
	
	
	
}
