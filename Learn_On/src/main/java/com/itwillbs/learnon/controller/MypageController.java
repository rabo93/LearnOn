package com.itwillbs.learnon.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
							  HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		List<MyCourseVO> mycourse = myService.getMyCourse(id, filterType, statusType);
		
		for(MyCourseVO course : mycourse) {
			try {
				course.setCompletion_rate(myService.getCompletionRate(id, course.getClass_id()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			course.setIs_reviewed(myService.isReviewWrited(id, course.getClass_id()));
		}
		
		System.out.println(mycourse);
		
		model.addAttribute("mycourse", mycourse);
		
		return "my_page/mypage_dashboard";
	}
	
	// 나의 강의실 - 수강 후기 작성
	@PostMapping("MyReview")
	public String MyReviewWrite(MyReviewVO review, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		
//		int insertCount = myService.registReview(review);
		int insertCount = 0;
		
		return "";
	}
	
	// 작성한 수강평
	@GetMapping("MyReview")
	public String myReview() {
		return "my_page/mypage_review";
	}
		
	// 결제내역
	@GetMapping("MyPayment")
	public String myPayment() {
		return "my_page/mypage_payment";
	}
	
	// 보유한 쿠폰
	@GetMapping("MyCoupon")
	public String myCoupon() {
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
