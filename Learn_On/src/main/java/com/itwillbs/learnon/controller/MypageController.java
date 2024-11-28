package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.service.AdminService;
import com.itwillbs.learnon.service.MemberService;
import com.itwillbs.learnon.service.MypageService;
import com.itwillbs.learnon.vo.AttendanceVO;
import com.itwillbs.learnon.vo.MemberVO;
import com.itwillbs.learnon.vo.MyCourseVO;
import com.itwillbs.learnon.vo.MyCurriculumVO;
import com.itwillbs.learnon.vo.MyDashboardVO;
import com.itwillbs.learnon.vo.MyPaymentVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.PageInfo;
import com.itwillbs.learnon.vo.SupportBoardVO;
import com.itwillbs.learnon.vo.WishlistVO;

@Controller
public class MypageController {
	
	@Autowired
	private MypageService myService;
	
	@Autowired
	private AdminService admService;
	
	// 첨부파일 가상경로
	private String uploadPath = "/resources/upload";
	
	// 계정정보
//	@GetMapping("MyInfo")
//	public String mypageForm() {
//		return "my_page/mypage_info";
//	}
	
	// 관심목록
	@GetMapping("MyFav")
	public String myFav(@RequestParam(defaultValue = "") String filterType, HttpServletRequest request, HttpSession session, Model model) {
//		System.out.println("필터타입: " + filterType);
		savePreviousUrl(request, session);
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			
			return "result/fail";
		}
		
		List<WishlistVO> wishlist = myService.getWishlist(id, filterType);
		
		model.addAttribute("wishlist", wishlist);
		
		return "my_page/mypage_fav";
	}
	
	// 관심목록 추가
	@GetMapping("MyFavAdd")
	public String myFavAdd(WishlistVO wish, HttpServletRequest request, HttpSession session, Model model) {
//		System.out.println("추가할 관심클래스 : " + class_id);
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		wish.setMem_id(id);
		
		int insertCount = myService.registMyFav(wish);
		
		if (insertCount > 0) {
			return "redirect:" + session.getAttribute("prevURL");
		} else {
			model.addAttribute("msg", "추가 실패!");
			return "result/fail";
		}
	}
	
	// 관심목록 삭제
	@PostMapping("MyFavDel")
	public String myFavDel(String class_id, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("class_id: " + class_id);

		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		int deleteCount = myService.cancelMyFav(class_id);

		if (deleteCount > 0) {
			// 이전 페이지 저장 여부 판별 후 리다이렉트 또는 url로 이동
			if(session.getAttribute("prevURL") == null) {
				return "redirect:/";
			} else {
				// request.getServletPath() 메서드를 통해 이전 요청 URL 을 저장할 경우
				// "/요청URL" 형식으로 저장되므로 redirect:/ 에서 / 제외하고 결합하여 사용
				return "redirect:" + session.getAttribute("prevURL");
			}
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result/fail";
		}
		
	}
	
	// 카테고리 페이지에서 관심강의 삭제
	@GetMapping("MyFavDel")
	public String myFavDelete(String class_id, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("class_id: " + class_id);

		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		int deleteCount = myService.cancelMyFav(class_id);

		if (deleteCount > 0) {
			// 이전 페이지 저장 여부 판별 후 리다이렉트 또는 url로 이동
			if(session.getAttribute("prevURL") == null) {
				return "redirect:/";
			} else {
				// request.getServletPath() 메서드를 통해 이전 요청 URL 을 저장할 경우
				// "/요청URL" 형식으로 저장되므로 redirect:/ 에서 / 제외하고 결합하여 사용
				return "redirect:" + session.getAttribute("prevURL");
			}
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
		
		// 나의 강의실, 작성한 수강평 모두 이전 페이지 저장 필요함 (수정, 삭제 이후 리다이렉트 때문)
		savePreviousUrl(request, session);
		
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		List<MyCourseVO> myCourse = myService.getMyCourse(id, filterType, statusType);
		
		model.addAttribute("myCourse", myCourse);
		
		return "my_page/mypage_dashboard";
	}
	
	// 작성한 수강평 목록
	@GetMapping("MyReview")
	public String myReview(MyReviewVO review, HttpServletRequest request, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		
		// 나의 강의실, 작성한 수강평 모두 이전 페이지 저장 필요함 (수정, 삭제 이후 리다이렉트 때문)
		savePreviousUrl(request, session);
		
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			return "result/fail";
		}
		
		review.setMem_id(id);
		
		List<MyReviewVO> myReviewList = myService.getMyReview(review);
		int reviewCount = myService.getMyReviewCount(review);
		
		model.addAttribute("myReviewList", myReviewList);
		model.addAttribute("reviewCount", reviewCount);
		
		return "my_page/mypage_review";
	}
	
	// 수강평 작성하기
	@PostMapping("MyReviewWrite")
	public String myReviewWrite(MyReviewVO review, HttpServletRequest request, HttpSession session, Model model) {
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
	public String myReviewUpdateForm(MyReviewVO review, HttpServletRequest request, HttpSession session, Model model) {
		
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
	public String myReviewUpdate(MyReviewVO review, HttpServletRequest request, HttpSession session, Model model) {
		
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
	public String myReviewDelete(MyReviewVO review, HttpServletRequest request, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
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
	
	// 나의강의실 - 강의 시청 
	@GetMapping("MyCourseBoard")
	public String myCourseBoard(MyDashboardVO myDashboard, HttpServletRequest request, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		myDashboard.setMem_id(id);
		System.out.println(myDashboard);
		
		myDashboard = myService.getMyDashboard(myDashboard);
		List<MyCurriculumVO> myCurList = myService.getMyCurList(myDashboard);
		
		model.addAttribute("myDashboard", myDashboard);
		model.addAttribute("myCurList", myCurList);
		
		return "my_page/mypage_course";
	}
	
	// 커리큘럼 동영상 시청 - 완료 처리
	@GetMapping("CompletedVideo")
	public String completedVideo(MyCurriculumVO myCurriculum, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println(myCurriculum);
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		myCurriculum.setMem_id(id);
		int updateCount = myService.completedVideo(myCurriculum);
		
		if(updateCount > 0) {
			model.addAttribute("class_id", myCurriculum.getClass_id());
			model.addAttribute("cur_id", myCurriculum.getCur_id());
			return "redirect:/MyCourseBoard";
		} else {
			model.addAttribute("msg", "선택 실패!");
			return "result/fail";
		}
		
	}
	
		
	// 결제내역
	@GetMapping("MyPayment")
	public String myPayment(HttpServletRequest request, HttpSession session, Model model) {
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		
		Map<String, List<MyPaymentVO>> paymentList = myService.getMyPaymentList(id);
		System.out.println("결제 내역 리스트: "+ paymentList);
		
		model.addAttribute("paymentList", paymentList);
		
		return "my_page/mypage_payment";
	}
	
	// 보유한 쿠폰
	@GetMapping("MyCoupon")
	public String myCoupon(HttpServletRequest request, HttpSession session, Model model) {
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		List<Map<String, Object>> myCoupon = myService.getMyCouponList(id);
		int couponCount = myService.getMyCouponCount(id);
		
		model.addAttribute("myCoupon", myCoupon);
		model.addAttribute("couponCount", couponCount);
		
		return "my_page/mypage_coupon";
	}
	
	// 문의내역 글쓰기 폼
	@GetMapping("MySupportWrite")
	public String mySupportWriteForm(HttpServletRequest request, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		return "my_page/mypage_inquiry_write";
	}
	
	// 문의내역 글쓰기
	@PostMapping("MySupportWrite")
	public String mySupportWrite(SupportBoardVO support, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("1:1 문의글 쓰기 : " + support);
		
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		support.setMem_id(id);
		
		// 파일 첨부 업로드 경로 처리
		String realPath = getRealPath(session);
		
		// 디렉토리 생성
		String subDir = createDirectories(realPath);
		
		realPath += "/" + subDir;
		
		// 실제 파일 처리
		MultipartFile mFile1 = support.getFile1();
		System.out.println("원본파일명: " + mFile1);
		support.setSupport_file1("");
		
		String fileName = processDuplicateFileName(support, subDir);
		
		System.out.println("------- DB 저장파일" + support.getSupport_file1());
		System.out.println("-------- 1:1문의 글 작성 최종내용: " + support);
		
		// 글쓰기 서비스 요청
		int insertCount = myService.registSupport(support);
		
		if (insertCount > 0) {
			completeUpload(support, realPath, fileName);
			System.out.println();
			
			return "redirect:/MySupport";
		} else {
			model.addAttribute("msg", "글쓰기 실패!");
			return "result/fail";
		}
		
	}
	
	// 문의내역 목록
	@GetMapping("MySupport")
	public String mySupportList(@RequestParam(defaultValue = "1") int pageNum, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("페이지번호: " + pageNum);
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		// 페이징 설정
		int listLimit = 10; // 한 페이지당 게시물 수
		int startRow = (pageNum - 1) * listLimit;
		int listCount = myService.getSupportListCount(id);
		
		int pageListLimit = 5; // 페이징 개수 
		int maxPage = (listCount / listLimit) + (listCount % listLimit > 0 ? 1 : 0);
		
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		System.out.println("maxPage = " + maxPage);
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "MySupport?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", pageInfo);
		
		// 게시물 목록 조회
		List<SupportBoardVO> supportList = myService.getSupportList(startRow, listLimit, id);
		
		model.addAttribute("supportList", supportList);
		
		return "my_page/mypage_inquiry_list";
	}
	
	// 문의내역 상세
	@GetMapping("MySupportDetail")
	public String mySupportDetail(int support_idx, Model model) {
		SupportBoardVO support = myService.getSupportDetail(support_idx);
		
		if(support == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다");
			return "result/fail";
		}
		
		addFileToModel(support, model);
		model.addAttribute("support", support);
		
		return "my_page/mypage_inquiry_detail";
	}
	
	// 문의내역 수정 폼
	@GetMapping("MySupportModify")
	public String mySupportModifyForm(int support_idx, HttpSession session, HttpServletRequest request, Model model) {
		
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		SupportBoardVO support = myService.getSupportDetail(support_idx);
		
		if(support == null || !id.equals(support.getMem_id())) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "result/fail";
		}
		
		model.addAttribute("support", support);
		
		addFileToModel(support, model);
		
		return "my_page/mypage_inquiry_update";
	}
	
	// 문의내역 수정
	@PostMapping("MySupportModify")
	public String mySupportModify(SupportBoardVO support, @RequestParam(defaultValue = "1") int pageNum, HttpServletRequest request, HttpSession session, Model model) {
		
		String realPath = getRealPath(session);
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		
		String fileName = processDuplicateFileName(support, subDir);
		
		
		int updateCount = myService.modifySupport(support);
		
		if(updateCount > 0) {
			completeUpload(support, realPath, fileName);
			return "redirect:/MySupportDetail?support_idx=" + support.getSupport_idx() + "&pageNum=" + pageNum; 
 		} else {
 			model.addAttribute("msg", "글 수정 실패!");
 			return "result/fail";
 		}
	}
	
	// 문의내역 수정 시 첨부파일 삭제
	@ResponseBody
	@PostMapping("MySupportDeleteFile")
	public String mySupportDeleteFile(@RequestParam Map<String, String> map, HttpSession session) {
		
		int deleteCount = myService.removeSupportFile(map);
		
		if(deleteCount > 0) {
			String realPath = session.getServletContext().getRealPath(uploadPath);
			System.out.println(realPath);
			
			if(!map.get("file").equals("")) {
				Path path = Paths.get(realPath, map.get("file"));
				try {
					Files.deleteIfExists(path);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return "true";
	}
	
	
	// 문의내역 삭제
	@GetMapping("MySupportDelete")
	public String mySupportDelete(SupportBoardVO support, @RequestParam(defaultValue = "1") int pageNum, HttpServletRequest request, HttpSession session, Model model) {
		
		// 세션아이디 체크
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		support = myService.getSupportDetail(support.getSupport_idx());
		System.out.println("삭제할 1:1 문의글 : " + support);
		
		if(support == null || !id.equals(support.getMem_id())) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "result/fail";
		}
		
		int deleteCount = myService.removeSupport(support.getSupport_idx());
		
		if(deleteCount > 0) {
			String realPath = getRealPath(session);
			
			String fileName = support.getSupport_file1();
			System.out.println("삭제할 파일 : " + fileName);
			
			if(!fileName.equals("")) {
				Path path = Paths.get(realPath, fileName);
				
				try {
					Files.deleteIfExists(path);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			System.out.println("삭제완료!");
			return "redirect:/MySupport?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "삭제 실패");
			return "result/fail";
		}
	}
	
	// 출석체크
	@GetMapping("MyAttendance")
	public String myAttendanceForm(HttpServletRequest request, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n 로그인 페이지로 이동합니다!");
			model.addAttribute("targetURL", "MemberLogin");
			savePreviousUrl(request, session);
			
			return "result/fail";
		}
		
		AttendanceVO attendance = myService.getAttendance(id);
		model.addAttribute("attendance", attendance);
		
		return "my_page/mypage_attendance";
	}
	
	// 출석체크 ******************************************************
	@GetMapping("AttendanceButton")
	public String attendanceButton(AttendanceVO attendance, Model model, HttpSession session) {
		String id = (String)session.getAttribute("sId");
		
		int attend = myService.addDate(attendance);
		if(attend > 0) {
//			model.addAttribute("msg", "출석체크 완료!");
			model.addAttribute("attendance", attendance);
			return"redirect:/MyAttendance";
		}
		model.addAttribute("msg", "출석체크 실패");
		return"result/fail";
	}
	
	
	
	
	// ===========================================================================================
	// 이전 페이지 이동 저장
	private void savePreviousUrl(HttpServletRequest request, HttpSession session) {
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
//		System.out.println("prevURL : " + prevURL);
//		System.out.println("queryString : " + queryString);
		
		if (queryString != null) {
			prevURL += "?" + queryString;
		}
		
		session.setAttribute("prevURL", prevURL);
	}
	
	
	// 첨부파일 - 파일 목록 처리 (첨부파일 단일)
	private void addFileToModel(SupportBoardVO support, Model model) {
		String fileName = support.getSupport_file1();
		String originalFileName = "";
		
		if(fileName != null) {
			originalFileName = fileName.substring(fileName.indexOf("_") + 1);
		} else {
			originalFileName = fileName;
		}
		
		model.addAttribute("originalFileName", originalFileName);
		model.addAttribute("fileName", fileName);
	}
	
	// 첨부파일 - 실제 경로 리턴 처리
	private String getRealPath(HttpSession session) {
		String realPath = session.getServletContext().getRealPath(uploadPath);
		
		return realPath;
	}
	
	// 첨부파일 - 서브디렉토리 생성 처리
	private String createDirectories(String realPath) {
		String subDir = "";
		
		// 서브디렉토리명 만들기
		LocalDate today = LocalDate.now(); // 날짜로 폴더명 생성하기
//		System.out.println("작성날짜: " + today);
		String datePattern = "yyyy/MM/dd";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		
		subDir = today.format(dtf);
		realPath += "/" + subDir;
		System.out.println("실제 파일 업로드 경로: " + realPath);
		
		try {
			Path path = Paths.get(realPath);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return subDir;
	}
	
	// 첨부파일 -  첨부파일명 중복 대책 처리
	private String processDuplicateFileName(SupportBoardVO support, String subDir) {
		MultipartFile mFile1 = support.getFile1();
		System.out.println("원본파일명: " + mFile1);
		support.setSupport_file1("");
		
		String fileName = "";
		
		if(!mFile1.getOriginalFilename().equals("")) {
			fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			support.setSupport_file1(subDir + "/" + fileName);
		}
		
		return fileName;
	}
	
	// 첨부파일 - 실제 파일 업로드 처리(임시경로 -> 실제경로)
	private void completeUpload(SupportBoardVO support, String realPath, String fileName) {
		MultipartFile mFile1 = support.getFile1();
		
		try {
			if(!mFile1.getOriginalFilename().equals("")) {
				mFile1.transferTo(new File(realPath, fileName));
				System.out.println("----------- 업로드 실제 처리: " + mFile1);
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
}
