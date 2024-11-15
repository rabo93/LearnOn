package com.itwillbs.learnon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.learnon.service.MypageService;
import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.WishlistVO;

@Controller
public class MypageController {
	
	@Autowired
	private MypageService myService;
	
	
	
	// 계정정보
	@GetMapping("MyInfo")
	public String mypageForm() {
		return "my_page/mypage_info";
	}
	
	// 관심목록
	@GetMapping("MyFav")
	public String myFav(@RequestParam(defaultValue = "") String filterType, HttpSession session, Model model) {
//		System.out.println("필터타입: " + filterType);
		
		String id = (String)session.getAttribute("sId");
		System.out.println(id);
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		List<WishlistVO> wishlist = myService.getWishlist(id, filterType);
		
		model.addAttribute("wishlist", wishlist);
		
		return "my_page/mypage_fav";
	}
	
	// 관심목록 삭제
	@PostMapping("MyFavDel")
	public String myFavDel(String class_id, HttpSession session, Model model) {
		System.out.println("class_id: " + class_id);

		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		int deleteCount = myService.cancelMyFav(class_id);

		if (deleteCount > 0) {
			return "redirect:/MyFav";
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result/fail";
		}
		
	}
	
	// 나의 강의실
	@GetMapping("MyDashboard")
	public String myDashboard(@RequestParam(defaultValue = "") String filterType,
							  @RequestParam(defaultValue = "") String statusType,
							  HttpServletRequest request, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		List<MyCourseVO> myCourse = myService.getMyCourse(id, filterType, statusType);
		
		for(MyCourseVO course : myCourse) {
			try {
				course.setCompletion_rate(myService.getCompletionRate(id, course.getClass_id()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			course.setIs_reviewed(myService.isReviewWrited(id, course.getClass_id()));
		}
		
//		System.out.println(myCourse);
	
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
		
		if(queryString != null) {
			prevURL += "?" + queryString;
		}
		
		session.setAttribute("prevURL", prevURL);
		
		model.addAttribute("myCourse", myCourse);
		
		return "my_page/mypage_dashboard";
	}
	
	// 작성한 수강평 목록
	@GetMapping("MyReview")
	public String myReview(MyReviewVO review, HttpServletRequest request, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		review.setMem_id(id);
		
		List<MyReviewVO> myReviewList = myService.getMyReview(review);
		int reviewCount = myService.getMyReviewCount(review);
		
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
		
		if(queryString != null) {
			prevURL += "?" + queryString;
		}
		
		session.setAttribute("prevURL", prevURL);
		
		model.addAttribute("myReviewList", myReviewList);
		model.addAttribute("reviewCount", reviewCount);
		
		return "my_page/mypage_review";
	}
	
	// 수강평 작성하기
	@PostMapping("MyReviewWrite")
	public String myReviewWrite(MyReviewVO review, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		review.setMem_id(id);
		
		int insertCount = myService.registReview(review);
			
		if(insertCount > 0) {
			return "redirect:/MyDashboard";
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result/fail";
		}
		
	}
	
	// 작성된 수강후기 폼
	@ResponseBody
	@GetMapping("MyReviewUpdateForm")
	public String myReviewUpdateForm(MyReviewVO review, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		review.setMem_id(id);
		
		review = myService.getMyReviewDetail(review);
		
		JSONObject jo = new JSONObject(review);
		
		return jo.toString();
	}
	
	// 작성된 수강후기 수정
	@PostMapping("MyReviewUpdate")
	public String myReviewUpdate(MyReviewVO review, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		review.setMem_id(id);
		
		int updateCount = myService.modifyMyReview(review);
		
		if(updateCount > 0) {
			System.out.println("이전주소: " + session.getAttribute("prevURL"));
			return "redirect:" + session.getAttribute("prevURL");
		} else {
			model.addAttribute("msg", "수정 실패!");
			return "result/fail";
		}
		
	}
	
	// 수강평 삭제하기
	@PostMapping("MyReviewDelete")
	public String myReviewDelete(MyReviewVO review, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		int deleteCount = myService.removeReview(review);
		
		if(deleteCount > 0) {
			System.out.println("삭제 성공!");
			return "redirect:/MyReview";
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result/fail";
		}
	}
	
	@GetMapping("MyCourseBoard")
	public String myCourseBoard() {
		
		return "my_page/mypage_course";
	}
	
		
	// 결제내역
	@GetMapping("MyPayment")
	public String myPayment() {
		return "my_page/mypage_payment";
	}
	
	// 보유한 쿠폰
	@GetMapping("MyCoupon")
	public String myCoupon(HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		List<Map<String, Object>> myCoupon = myService.getMyCouponList(id);
		int couponCount = myService.getMyCouponCount(id);
		
		model.addAttribute("myCoupon", myCoupon);
		model.addAttribute("couponCount", couponCount);
		
		System.out.println(myCoupon);
		
		return "my_page/mypage_coupon";
	}
	
	// 문의내역
	@GetMapping("MyInquiry")
	public String myInquiry() {
		return "my_page/mypage_inquiry_list";
	}
	
	// 출석체크
	@GetMapping("MyAttendance")
	public String myAttendance() {
		return "my_page/mypage_attendance";
	}
	
	
}
