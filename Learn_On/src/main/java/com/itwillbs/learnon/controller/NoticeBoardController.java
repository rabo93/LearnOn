package com.itwillbs.learnon.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.learnon.service.NoticeBoardService;
import com.itwillbs.learnon.vo.NoticeBoardVO;
import com.itwillbs.learnon.vo.PageInfo;

@Controller
public class NoticeBoardController {
	@Autowired
	private NoticeBoardService noticeService;
	
	//	가상의 업로드 경로명
	String uploadPath = "/resources/upload";
	
	//	글쓰기폼 이동
	@GetMapping("NoticeWrite")
	public String noticeWriteForm(HttpSession session, Model model, HttpServletRequest request) {
		String id = (String)session.getAttribute("sId");
		//	미 로그인 시
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
		
		return "notice/notice_write_form";
	}
	
	//	글쓰기 로직
	@PostMapping("NoticeWrite")
	public String noticeWrite(NoticeBoardVO board, Model model, HttpSession session) {
		//	실제 업로드 경로
		String realPath = session.getServletContext().getRealPath(uploadPath);
		//	현재 시스템 날짜
		LocalDate today = LocalDate.now();
		//	날짜 포맷 패턴
		String datePattern = "yyyy/MM/dd";
		//	패턴 문자열 전달
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		
		//	날짜 형식으로 경로 저장
		String subDir = today.format(dtf);
		//	기존 실제 업로드 경로
		realPath += "/" + subDir;
		//	실제 경로 전달
		Path path = Paths.get(realPath);
		
		try {
			//	실제 경로 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//	------------------------------------------------------
		MultipartFile[] multis = board.getNotice_file_get();
		
		board.setNotice_file("");
		String fileName = "";
		
		try {
			for (MultipartFile multi : multis) {
				String origin = multi.getOriginalFilename();
				if (!origin.equals("")) {
					String temp = UUID.randomUUID().toString().substring(0, 8) + "_" + origin;
					multi.transferTo(new File(realPath, temp));
					fileName += subDir + "/" + temp + ",";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		if (!fileName.equals("")) {
			fileName = fileName.substring(0, fileName.length() - 1);
		}
		board.setNotice_file(fileName);
		
		System.out.println("split : " + Arrays.toString(fileName.split(",")));
		
		//	INSERT 작업
		noticeService.registBoard(board);
		
		return "redirect:/NoticeList";
	}
	
	
	//	공지사항 목록
	@GetMapping("NoticeList")
	public String noticeList (@RequestParam(defaultValue = "1") int pageNum,
							  @RequestParam(defaultValue = "latest") String sort,
							  @RequestParam(defaultValue = "") String searchKeyword,
							  @RequestParam(defaultValue = "") String searchType,
							  Model model) {
		System.out.println("페이지번호 : " + pageNum);
		System.out.println("검색어 : " + searchKeyword);
		System.out.println("검색타입 : " + searchType);
		
		int listLimit = 5;	//	페이지당 게시물 수
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = noticeService.getBoardListCount(searchKeyword, searchType);
//		System.out.println("게시물 수 : " + listCount);
		
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		if (maxPage == 0) {
			maxPage = 1;
		}
		
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		model.addAttribute("pageNum", pageNum);
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		List<NoticeBoardVO> noticeList = noticeService.getBoardList(startRow, listLimit, sort, searchKeyword, searchType);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("sort", sort);
		
		
		return "notice/notice_list";
	}
	
	//	글 상세조회
	@GetMapping("NoticeDetail")
	public String noticeDetail(int notice_idx, Model model) {
		
		NoticeBoardVO board = noticeService.getNoticeBoard(notice_idx);
		model.addAttribute("notice", board);
		
		String[] fileSplit = board.getNotice_file().split(",");
		List<String> fileList = new ArrayList<String>();
		
		for (String file : fileSplit) {
			fileList.add(file);
		}
		
		List<String> originalFileList = new ArrayList<String>();
		for (String file : fileList) {
			originalFileList.add(file.substring(file.indexOf("_") + 1));
		}
		
		model.addAttribute("fileList", fileList);
		model.addAttribute("originalFileList", originalFileList);
		
		return "notice/notice_detail";
	}
	
	//	글 삭제
	@GetMapping("NoticeDelete")
	public String noticeDelete(@RequestParam(defaultValue = "1") int pageNum,
							   NoticeBoardVO board,
							   Model model,
							   HttpSession session) {
		
		/*
		미 로그인 추가 예정
		*/
		
		
//		System.out.println("board : " + board.getNotice_idx());
//		System.out.println("pageNum : " + pageNum);
		board = noticeService.getNoticeBoard(board.getNotice_idx());
		
		if(board == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "result/fail";
		}
		
		int deleteCount = noticeService.removeNotice(board.getNotice_idx());
		
		if (deleteCount > 0) {
			String realPath = session.getServletContext().getRealPath(uploadPath);
			String file = board.getNotice_file();
			Path path = Paths.get(realPath, file);
			
			try {
				Files.delete(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "redirect:/NoticeList?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result/fail";
		}
		
	}
	
	@GetMapping("NoticeModify")
	public String noticeModifyForm(int notice_idx, Model model) {
		System.out.println("notice_idx : " + notice_idx);
		NoticeBoardVO board = noticeService.getNoticeBoard(notice_idx);
		System.out.println("board : " + board);
		
		String[] fileSplit = board.getNotice_file().split(",");
		List<String> fileList = new ArrayList<String>();
		
		for (String file : fileSplit) {
			fileList.add(file);
		}
		
		List<String> originalFileList = new ArrayList<String>();
		for (String file : fileList) {
			originalFileList.add(file.substring(file.indexOf("_") + 1));
		}
		
		model.addAttribute("notice" ,board);
		model.addAttribute("fileList", fileList);
		model.addAttribute("originalFileList", originalFileList);
		
		return "notice/notice_modify_form";
	}
	
	@PostMapping("NoticeModify")
	public String noticeModify(NoticeBoardVO board) {
		System.out.println(board);
		
		return "";
	}
}




