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
import java.util.StringJoiner;
import java.util.UUID;

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
import com.itwillbs.learnon.vo.PageInfo2;

@Controller
public class NoticeBoardController {
	@Autowired
	private NoticeBoardService noticeService;
	
	//	글쓰기폼 이동
	@GetMapping("NoticeWrite")
	public String noticeWriteForm() {
		
		//	로그인 여부 추가 예정
		
		
		return "notice/notice_write_form";
	}
	
	//	글쓰기 로직
	@PostMapping("NoticeWrite")
	public String noticeWrite(NoticeBoardVO board, Model model, HttpSession session) {
		//	가상의 업로드 경로명
		String uploadPath = "/resources/upload";
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
		MultipartFile[] multis = board.getNOTICE_FILE_GET();
		
		board.setNOTICE_FILE("");
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
		
		if (!fileName.equals("")) {	// 첨부파일이 없을 경우에만
			fileName = fileName.substring(0, fileName.length() - 1);
		}
		board.setNOTICE_FILE(fileName);
		
		System.out.println("split : " + Arrays.toString(fileName.split(",")));
		
		noticeService.registBoard(board);
		
		return "redirect:/NoticeList";
	}
	
	
	//	공지사항 목록
	@GetMapping("NoticeList")
	public String noticeList (@RequestParam(defaultValue = "1") int pageNum,
							  @RequestParam(defaultValue = "latest") String sort,
							  Model model) {
		System.out.println("페이지번호 : " + pageNum);
		
		
		int listLimit = 5;	//	페이지당 게시물 수
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = noticeService.getBoardListCount();
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
		
		PageInfo2 pageInfo = new PageInfo2(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pageInfo", pageInfo);
		
		List<NoticeBoardVO> noticeList = noticeService.getBoardList(startRow, listLimit, sort);
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("sort", sort);
		
		
		return "notice/notice_list";
	}
	
	//	글 상세조회
	@GetMapping("NoticeDetail")
	public String noticeDetail(int notice_idx, Model model) {
		
		
		NoticeBoardVO board = noticeService.getNoticeBoard(notice_idx);
		model.addAttribute("notice", board);
		
		String[] fileSplit = board.getNOTICE_FILE().split(",");
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
	
	
	
}




