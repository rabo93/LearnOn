package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.service.CourseService;
import com.itwillbs.learnon.service.MemberService;
import com.itwillbs.learnon.service.MypageService;
import com.itwillbs.learnon.vo.CommonCodeTypeVO;
import com.itwillbs.learnon.vo.CourseSupportVO;
import com.itwillbs.learnon.vo.CourseVO;
import com.itwillbs.learnon.vo.MyReviewVO;
import com.itwillbs.learnon.vo.PageInfo;

@Controller
public class CourseController {
	@Autowired
	CourseService courseService;
	@Autowired
	MemberService memberService;
	@Autowired
	MypageService myService;
	
	
	// 이클립스 상의 가상의 업로드 경로명 저장(프로젝트 상에서 보이는 경ㅇ로)
	private String uploadPath = "/resources/upload";

	@ResponseBody
	@GetMapping("TopMenu")
	public String topMenu (Model model) {
//		List<CommonCodeTypeVO> codeTypeAll = courseService.getCodeTypeAll();
//		List<CommonCodeTypeVO> commonCode = courseService.getCommonCode();
//
//		model.addAttribute("commonCode", commonCode);
//		model.addAttribute("codeTypeAll", codeTypeAll);
		
//		return "inc/top";
		// =========================================
		List<Map<String, String>> menuList = courseService.getMenuList();
//		System.out.println(menuList);
		JSONArray jo = new JSONArray(menuList);
		
		return jo.toString();
	}
	
	
	@GetMapping("Category")
	public String courseList(CourseVO course 
							,@RequestParam(defaultValue = "") String searchType
							, HttpSession session
							, HttpServletRequest request
							, Model model) {
		String id = (String)session.getAttribute("sId");
		
		List<CommonCodeTypeVO> codeType = courseService.getCodeType(course.getCodetype());
		List<CourseVO> courseList = courseService.getCourseList(course, searchType);
		List<CommonCodeTypeVO> codeTypeAll = courseService.getCodeTypeAll();
		List<CommonCodeTypeVO> commonCode = courseService.getCommonCode();
		
		// 관심목록 조회
		List<Map<String, Object>> wishList = myService.getWishlistForCategoryList(id);
		JSONArray jsonToWishList = new JSONArray(wishList);
		System.out.println("jsonToWishList : " + jsonToWishList);
		model.addAttribute("wishList", jsonToWishList);

		model.addAttribute("commonCode", commonCode);
		model.addAttribute("codeTypeAll", codeTypeAll);
		
		model.addAttribute("courseList", courseList);	
		model.addAttribute("codeType", codeType);
		
		// 현재페이지 prevURL로 저장
		String prevURL = request.getServletPath();
		String queryString = request.getQueryString();
		if(queryString != null) {
			prevURL += "?" + queryString;
		} 
		session.setAttribute("prevURL", prevURL);
		
		return "course/course_list"; 
	}
	
	@GetMapping("CourseDetail")
	public String courseDetail(
				int class_id, 
				Model model) {
		List<CourseVO> course = courseService.getCourse(class_id);
		List<MyReviewVO> myReviewList = courseService.getReviewList(class_id);
		List<CommonCodeTypeVO> codeTypeAll = courseService.getCodeTypeAll();
		List<CommonCodeTypeVO> commonCode = courseService.getCommonCode();

		
		model.addAttribute("commonCode", commonCode);
		model.addAttribute("codeTypeAll", codeTypeAll);
		model.addAttribute("course", course);
		model.addAttribute("myReview", myReviewList);
		
		return "course/course_detail";
	}
	
	
	@GetMapping("CourseSupportList")
	public String courseSupportList(@RequestParam(defaultValue = "1") int pageNum,
			int class_id, 
			Model model) {
		
		
		// [ 페이징 처리 ]		
		int startRow = (pageNum - 1) * paging(pageNum).getPageListLimit();
		if(pageNum < 1 || pageNum > paging(pageNum).getMaxPage()) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
			model.addAttribute("targetURL", "CourseDetail?pageNum=1");
			return "result/fail";
		}
		// 페이징 처리한 문의사항 항목가져옴. 
		List<CourseSupportVO> courseSupportList = courseService.getCourseSupportList(class_id, startRow, paging(pageNum).getPageListLimit());
		List<CourseVO> course = courseService.getCourse(class_id);
		// -------------------------------------------------------------------
		// Model 객체에 페이징 정보 저장
		model.addAttribute("pageInfo", paging(pageNum));
		// -------------------------------------------------------------------
		
		model.addAttribute("course", course);
		model.addAttribute("courseSupportList", courseSupportList);
		return "course/course_support_list"; 
	}
	
	@GetMapping("CourseSupport")
	public String courseSupportWriteForm(HttpSession session, Model model, HttpServletRequest request) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n로그인 페이지로 이동합니다.");
			model.addAttribute("targetURL", "MemberLogin");
			
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			System.out.println("prevURL: " + prevURL);
			System.out.println("요청 파라미터: " + request.getQueryString());
			
			if(queryString != null) {
				prevURL += "?" + queryString;
			} 
			
			session.setAttribute("prevURL", prevURL);
			return "result/fail";
		}
		return "course/course_support_write_form";
	}
	
	@PostMapping("CourseSupportWrite") 
	public String courseSupportWrite(CourseSupportVO cSupport, 
			int class_id,
			@RequestParam(defaultValue = "1") String pageNum,
			HttpSession session, 
			Model model) {
		System.out.println("CourseSupportWrite???" + cSupport);
		String id = (String)session.getAttribute("sId");
		cSupport.setMem_id(id);
		cSupport.setC_class_id(class_id);

		// --------------------------------------------------------
		// [ 답글등록 과정에서 파일 업로드 처리 ]
		String realPath = session.getServletContext().getRealPath(uploadPath); // request대신 session을 써도 똑같은 메서드가 존재함.
		String subDir = "";// 서브 디렉토리명을 저장할 변수 선언
		LocalDate today = LocalDate.now();//현재 시스템의 날짜 정보 생성
		String datePattern ="yyyy/MM/dd"; // 날짜 포맷 변경에 사용할 패턴 문자열 지정
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		subDir = today.format(dtf);  // LocalDate - DateTimeFormatter
		realPath += "/" + subDir;
		
		try {
			Path path = Paths.get(realPath); // 파라미터로 실제 업로드 경로전달
			Files.createDirectories(path); // IOException 예외 처리 필요(임시로 현재 클래스에서 처리) - 이거쓰면 그냥 10월29일 날짜 폴더 만들어져 있으면 알아서 안만든다. exist*() 메서드로 폴더있나 없나 확인안해도 됨.
		} catch(Exception e) {
			e.printStackTrace();
		}
		// ------------------------------------
		// [업로드 되는 실제 파일 처리]
		// 실제 파일은 BoardVO 객체의 MultipartFile 타입 객체로 관리함(멤버변수명 fileXXX)
		MultipartFile mFile1 = cSupport.getFile(); 
		cSupport.setC_support_file("");
		
		String fileName1 = "";
		
		// 업로드 파일명이 널스트링이 아닐 경우를 판별하여 파일명 저장
		if(!mFile1.getOriginalFilename().equals("")) {
			fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			cSupport.setC_support_file(fileName1);
		}
		
		//----------------------------
		 // BoradService - registReplyBoard() 메서드 호출하여 게시물 등록 작업요청
		 // => 파라미터: BoardVO 객체, 리턴타입 : int(insrtCount)
		int insertCount = courseService.registCourseSupport(cSupport);
		if(insertCount > 0) { // 등록 성공
			
			model.addAttribute("class_id", class_id);
			return "redirect:/CourseSupportList?class_id="+ class_id;
		} else {
			model.addAttribute("msg", "문의글쓰기실패");
			return "result/fail";
		}
	}
	
	@GetMapping("CourseSupportDetail")
	public String courseSupportDetail(
					int c_support_idx,
					int class_id,
					@RequestParam(defaultValue = "1") int pageNum,
					Model model) {

		CourseSupportVO courseSupport = courseService.getCourseSupport(c_support_idx);
		model.addAttribute("courseSupport", courseSupport);
		return "course/course_support_detail"; 
		
	}
	
	@GetMapping("CourseSupportModifyForm")
	public String courseSupportModifyForm(
			int c_support_idx,
			Model model,
			HttpSession session,
			HttpServletRequest request) {
		
		
		String id = (String)session.getAttribute("sId");
		if (id == null) {
			model.addAttribute("msg", "로그인이 필요합니다\\n로그인 페이지로 이동합니다.");
			model.addAttribute("targetURL", "MemberLogin");
			
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			System.out.println("prevURL : " + prevURL);
			System.out.println("queryString : " + queryString);
			
			if (queryString != null) {
				prevURL += "?" + queryString;
			}
			
			session.setAttribute("prevURL", prevURL);
			return "result/fail";
		}
		
		// 자기 아이디 아니면 수정 권한 없다고 하기
		// 조회된 게시물이 존재하지 않거나, 조회된 게시물의 작성자가 세션 아이디와 다를 경우 
		// "잘못된 접근입니다!" 처리하기 위해 "result/fail.jsp"페이지로 포워딩 처리
		CourseSupportVO courseSupport = courseService.getCourseSupport(c_support_idx);
		if(courseSupport == null || !id.equals(courseSupport.getMem_id())) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "result/fail";
		}
		
		model.addAttribute("courseSupport", courseSupport);
		// ----------------------------------------------------------------
		// 뷰페이지에서 파일 목록의 효율적 처리를 위해 addFileListToModel() 메서드 활용
		addFileListToModel(courseSupport, model);
		return "course/course_support_modify_form"; 
	}
	
	@PostMapping("CourseSupportModify")
	public String courseSupportModify(
			CourseSupportVO cSupport,
			@RequestParam() int pageNum,
			Model model, HttpSession session, HttpServletRequest request
			) {
		
		// 파일 업로드 처리 준비
		String realPath = getRealPath(session); // 실제 경로 알아내기
		String subDir = createDirectories(realPath); // 디렉토리 생성하기
		// 기존 realPth 경로에 subDir 경로 결합
		realPath += "/" + subDir;
		
		List<String> fileNames = processDuplicateFileNames(cSupport, subDir); // 중복 처리된 파일명 리턴
		int updateCount = courseService.modifyCourseSupport(cSupport);
		
		int class_id = cSupport.getC_support_idx();
		CourseSupportVO courseSupport = courseService.getCourseSupport(class_id);
		
		if (updateCount > 0) {
			completeUpload(cSupport, realPath, fileNames);
			return "redirect:/CourseSupportDetail?c_support_idx=" + cSupport.getC_support_idx() 
			+ "&class_id=" + courseSupport.getC_class_id()
			+ "&pageNum=" + pageNum ; 
		} else {
			model.addAttribute("msg", "글 수정에 실패했습니다");
			return "result/fail";
		}
		
	}
	
	// [ 게시물 내의 파일 삭제 비즈니스 로직("CourseSupportDeleteFile - POST") - AJAX 요청 ]
	@ResponseBody 
	@PostMapping("CourseSupportDeleteFile")
	public String courseSupportDeleteFile(@RequestParam Map<String, String> map, HttpSession session) {
		
		// courseService - removeBoardFile() 메서드 호출하여 지정된 파일명 삭제 요청
		// => 파라미터 : Map 객체   리턴타입 : int(deleteCount)
		int deleteCount = courseService.removeBoardFile(map); 
		
//		System.out.println("map???@#!$@$      :   " + map);
		// DB 에서 해당 파일명 삭제 성공 시 실제 파일 삭제 처리
		if(deleteCount > 0) {
			// 실제 업로드 경로 알아내기
			String realPath = session.getServletContext().getRealPath(uploadPath);
			
			// 파일명이 널스트링이 아닐 경우에만 파일 삭제
			if(!map.get("c_support_file").equals("")) {
				// 업로드 경로와 파일명(서브디렉토리 경로 포함) 결합하여 Path 객체 생성
				Path path = Paths.get(realPath, map.get("c_support_file"));
				
				// java.nio.file 패키지의 Files 클래스의 deleteIfExists() 메서드 호출하여
				// 해당 파일이 실제 서버 상에 존재할 경우에만 삭제 처리
				try {
					Files.deleteIfExists(path);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return "true";
	}
	@GetMapping("CourseSupportDelete")
	public String courseSupportDelete(
			int class_id,
			int c_support_idx,
			CourseSupportVO cSupport, 	
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, 
			HttpServletRequest request,
			Model model) {

		// 미 로그인 처리 
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필수!\\n로그인 페이지로 이동합니다.");
			model.addAttribute("targetURL", "MemberLogin");
			
			// 로그인 성공 후 다시 현재페이지로 돌아오기 위해 prevURL 세션 속성값 설정
			// => 경로를 직접 입력하지 않고 request 객체의 getServletPath() 메서드로 서블릿 주소 추출 가능
			String prevURL = request.getServletPath();
			String queryString = request.getQueryString();
			System.out.println("prevURL: " + prevURL);
			System.out.println("요청 파라미터: " + request.getQueryString());
			
			// UTL 파라미터(쿼리)가 null이 아닐 경우 prevURL에 결합(?포함
			if(queryString != null) {
				prevURL += "?" + queryString;
			} 
			
			// 세션 객체에 prevURL 갑 저장
			session.setAttribute("prevURL", prevURL);
			return "result/fail";
		}
		
		// -------------------------------------------------------------------
		// 게시물 삭제 후 실제 업로드 된 파일도 서버상에서 삭제해야 하므로
		// DB에서 게시물에 해당하는 레코드 삭제 전 파일명을 미리 조회해야 함
		cSupport = courseService.getCourseSupport(c_support_idx); 
		
		// 조회된 게시물이 존재하지 않거나, 조회된 게시물의 작성자가 세션 아이디와 다를 경우 
		// "잘못된 접근입니다!" 처리하기 위해 "result/fail.jsp"페이지로 포워딩 처리
		if(cSupport == null || !id.equals(cSupport.getMem_id())) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "result/fail";
		}
		
		// -------------------------------------------------------------------
		// BoardService - removeBoard() 메서드 호출하여 게시물 삭제 요청
		// => 파라미터 : boardVO 객체 리턴타입 : int(deleteCount)
		int deleteCount = courseService.removeCourseSupport(c_support_idx);
		
		// DB 게시물 정보 삭제 처리 결과 판별 후 성공시 파일 삭제 작업처리 
		if(deleteCount > 0) {
			String realPath = session.getServletContext().getRealPath(uploadPath);
			List<String> fileList = new ArrayList<String>();
			fileList.add(cSupport.getC_support_file());
			for(String file : fileList) {
				Path path = Paths.get(realPath, file); // Path는 인터페이스이다. 
				if(!file.equals("")) {
					try {
						Files.deleteIfExists(path);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			// ----------------------------------------------------------
			// URL주소에 붙어있는 파라미터를 가지고 온다!
			System.out.println("삭제됨???");
			return "redirect:/CourseSupportList?class_id="+ class_id + "&pageNum=" + pageNum;
			
			
		} else {
			model.addAttribute("msg", "삭제실패");
			return "result/fail";
		}
	}
	
	// 파일 업로드에 사용될 실제 업로드 디렉토리 경로를 리턴하는 메서드
	public String getRealPath(HttpSession session) {
		String realPath = session.getServletContext().getRealPath(uploadPath);
		return realPath;
	}
	// 파일 업로드 과정에서 서브디렉토리까지 생성하는 메서드
	// => 생성 후 서브디렉토리명 리턴
	public String createDirectories(String realPath) {
		// [ 경로 관리 ]
		// 업로드 파일에 대한 관리 용이성을 증대시키기 위해 서브(하위) 디렉토리 활용하여 분산 관리
		// => 날짜별로 하위 디렉토리를 분류
		String subDir = ""; // 서브 디렉토리명을 저장할 변수 선언
		
		// 파일 업로드 시점에 맞는 날짜별 서브디렉토리 생성
		// => java.util.Date 또는 java.time.LocalXXX 클래스 활용(LocalXXX 클래스가 더 효율적)
		// 1. 현재 시스템의 날짜 정보를 갖는 객체 생성
		// 1-1) java.util.Date 클래스 활용
//				Date now = new Date(); // 기본 생성자 호출 시 시스템(톰캣)의 현재 날짜 및 시각 정보 생성
//				System.out.println(now); // Tue Oct 29 11:37:27 KST 2024
		
		// 1-2) java.time.LocalXXX 클래스 활용
		// => 날짜 정보만 관리할 경우 LocalDate, 시각 정보는 LocalTime, 날짜 및 시각 정보는 LocalDateTime 클래스 활용
		LocalDate today = LocalDate.now(); // 현재 시스템의 날짜 정보 생성
//				System.out.println(today); // 2024-10-29
		// -----------------------
		// 2. 날짜 포맷을 디렉토리 형식에 맞게 변경(ex. 2024-10-29 => 2024/10/29)
		// => 단, 윈도우 운영체제 기준으로 디렉토리 구분자는 백슬래시(\)로 표기하지만
		//    자바 또는 자바스크립트 문자열로 지정할 때 이스케이스 문자로 취급되므로
		//    백슬래시 2번(\\) 또는 슬래시(/) 기호로 경로 구분자 사용
		String datePattern = "yyyy/MM/dd"; // 날짜 포맷 변경에 사용될 패턴 문자열 생성
		
		// 2-1) Date 타입 객체의 날짜 포맷 변경 - java.text.SimpleDateFormat 클래스 활용
		// SimpleDateFormat 클래스 인스턴스 생성 시 생성자 파라미터로 패턴 문자열 전달
//				SimpleDateFormat sdf = new SimpleDateFormat(datePattern);
		// SimpleDateFormat 객체의 format() 메서드 호출하여 파라미터로 전달된 Date 객체 날짜 변환
//				System.out.println(sdf.format(now)); // 변환된 날짜 형식에 맞게 문자열로 리턴됨()
		
		// 2-2) LocalXXX 타입 객체의 날짜 포맷 변경 - java.time.format.DateTimeFormatter 클래스 활용
		// DateTimeFormatter 클래스의 ofPattern() 메서드 호출하여 파라미터로 패턴 문자열 전달
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		// LocalDate 객체의 format() 메서드 호출하여 파라미터로 DateTimeFormatter 객체 전달하여 날짜 변환
//				System.out.println(today.format(dtf)); // 변환된 날짜 형식에 맞게 문자열로 리턴됨()
		// -----------------
		// 3. 지정한 포맷을 적용하여 날짜 형식 변경 결과를 경로 변수 subDir 에 저장
//				subDir = sdf.format(now); // Date - SimpleDateFormat
		subDir = today.format(dtf); // LocalDate - DateTimeFormatter
		// -----------------
		// 4. 기존 실제 업로드 경로(realPath)에 서브 디렉토리(날짜 경로) 결합(구분자 "/" 추가)
		realPath += "/" + subDir;
//				System.out.println("realPath : " + realPath);
		// => realPath : D:\Shared\Backend\Spring\workspace_spring3\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload/2024/10/29
		// -----------------
		try {
			// 5. 해당 디렉토리를 실제 경로 상에 생성(단, 존재하지 않는 경로만 자동 생성)
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출하여
			//      실제 업로드 경로를 관리할 java.nio.file.Path 객체 리턴받기
			Path path = Paths.get(realPath); // 파라미터로 실제 업로드 경로 전달
			
			// 5-2) Files 클래스의 createDirectories() 메서드 호출하여 실제 경로 생성
			//      => 파라미터로 Path 객체 전달
			//      => 이 때, 경로 상에서 생성되지 않은 모든 디렉토리를 생성해준다!
			//      => 만약, 최종 서브디렉토리 1개만 생성 시 createDirectory() 메서드도 사용 가능
			Files.createDirectories(path); // IOException 예외 처리 필요(임시로 현재 클래스에서 처리)
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 생성된 디렉토리의 서브디렉토리명 리턴
		return subDir;
	}
	// ===============
	// 파일명 중복대책처리
	private List<String> processDuplicateFileNames(CourseSupportVO cSupport, String subDir) {
		// [ 업로드 되는 실제 파일 처리 ]
		// 실제 파일은 BoardVO 객체의 MultipartFile 타입 객체로 관리함(멤버변수명 fileXXX)
		MultipartFile mFile1 = cSupport.getFile();
		cSupport.setC_support_file("");
		
		String fileName1 = "";
		
		// 업로드 파일명이 널스트링이 아닐 경우 판별하여 파일명 저장(각 파일을 별개의 if 문으로 판별)
		if(!mFile1.getOriginalFilename().equals("")) {
			fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			cSupport.setC_support_file(subDir + "/" + fileName1);
		}
		
		// 중복처리된 파일명을 List 객체에 추가 후 리턴
		List<String> fileNames = new ArrayList<String>();
		fileNames.add(fileName1);
		
		return fileNames;
	}
	// 실제 파일 업로드 처리(임시경로 -> 실제경로)
	private void completeUpload(CourseSupportVO cSupport, String realPath, List<String> fileNames) {
		// 실제 파일은 BoardVO 객체의 MultipartFile 타입 객체로 관리함(멤버변수명 fileXXX)
		MultipartFile mFile1 = cSupport.getFile();

		try {
			if(!mFile1.getOriginalFilename().equals("")) {
				mFile1.transferTo(new File(realPath, fileNames.get(0)));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private void addFileListToModel(CourseSupportVO cSupport, Model model) {
		// 뷰 페이지에서 파일목록의 효율적 처리를 위해 별도의 가공 후 전달
//		1. 파일명을 별도의 list 객체에 저장(제네릭 타입 : String)
		List<String> fileList = new ArrayList<String>();
		fileList.add(cSupport.getC_support_file());
		System.out.println(fileList);
		//----------------------
		// 2. 만약, 컨트롤러 측에서 원본 파일명을 추출하여 전달할 경우
		// => 파일명이 저장된 List 객체를 반복하면서 원본 파일명을 추출하여 별도의 List에 저장
		List<String> originalFileList = new ArrayList<String>();
		
		for(String file : fileList) {
//			System.out.println("file: " + file);
			if(!file.equals("")) {
				// 실제 파일명에서 "-" 기호 다음(인덱스값 + 1)부터 끝까지 추출하여 리스트에 추가
//				originalFileList.add(file.substring(file.indexOf("_") + 1));
				originalFileList.add(file);
			} else {
				// 파일이 존재하지 않을 경우 원본 파일명도 파일명과 동일하게 null 로 저장
				originalFileList.add(file);
			}
		}
		System.out.println("originalFileList" + originalFileList); // 자동적으로 위치도 구분해서 나온다.
		//----------------
		// Model 객체에 파일 목록 객체 2개 저장
		model.addAttribute("fileList", fileList);
		model.addAttribute("originalFileList", originalFileList); // model은 파라미터에서 보내주니까 void가 맞다. 같은 객체이므로
		// Model 객체를 별도로 리턴하지 않아도 객체 자체를 전달받았으므로
				// 메서드 호출한 곳에서 저장된 속성 그대로 공유 가능
	}
	
	public PageInfo paging(@RequestParam(defaultValue = "1") int pageNum) {
		// -------------------------------------------------------------------
		// [ 페이징 처리 ]
		int listLimit = 5; // 페이지 당 게시물 수
		int listCount = courseService.getCSupportListCount();
		int pageListLimit = 5; 
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		// 페이징 정보 관리하는 PageInfo 객체 생성 및 계산 결과 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		return pageInfo;
	}
}
