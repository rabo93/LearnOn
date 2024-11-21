package com.itwillbs.learnon.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.learnon.service.FaqService;
import com.itwillbs.learnon.vo.FaqVO;

@Controller
public class FaqController {
	@Autowired
	private FaqService faqService;

	@GetMapping("FaqList")
	public String faq(Model model) {

		List<FaqVO> faqList = faqService.getBoardList();
		model.addAttribute("faqList", faqList);

		return "faq/faq";
	}

	@GetMapping("FaqWrite")
	public String faqWriteForm() {

		//	로그인 추가 예정

		return "faq/faq_write_form";
	}

	@PostMapping("FaqWrite")
	public String faqWrite(FaqVO faq, Model model) {

		faqService.registFaq(faq);

		return "redirect:/FaqList";
	}

	//	=================== 관리자 페이지용 ===============
	@GetMapping("AdminFaqWrite")
	public String faqAdmWriteForm() {

		return "admin/faq_write_form";
	}

	@PostMapping("AdminFaqWrite")
	public String AdminFaqWrite(FaqVO faq, Model model) {
		int insertCount = faqService.registFaq(faq);
		if(insertCount > 0) {
			return "redirect:/AdmFaq";
		} else {
			model.addAttribute("msg", "글쓰기에 실패했습니다.");
			return "result/fail";
		}
	}

	@GetMapping("AdminFaqModify")
	public String AdminFaqModifyFrom (int faq_idx, Model model) {
		FaqVO board = faqService.getIdxBoardList(faq_idx);
		model.addAttribute("faq", board);
		return "admin/faq_modify_form";
	}

	@PostMapping("AdminFaqModify")
	public String AdminFaqModify(FaqVO board, Model model) {
		System.out.println(board);

		int updateCount = faqService.modifyFaqBoard(board);

		if(updateCount > 0) {
			return "redirect:/AdmFaq";
		} else {
			model.addAttribute("msg", "글쓰기에 실패했습니다.");
			return "result/fail";
		}
	}

	@GetMapping("AdminFaqDelete")
	public String adminFaqDelete(int[] faq_idxs, Model model, HttpSession session) {
		for (int faq_idx : faq_idxs) {
			FaqVO board = faqService.getIdxBoardList(faq_idx);

			if (board.equals(null)) {
				model.addAttribute("msg", "잘못된 접근입니다!");
				return "result/fail";
			}

			int deleteCount = faqService.removeFaq(board.getFaq_idx());

			if (deleteCount < 0) {
				model.addAttribute("msg", "삭제 실패!");
				return "result/fail";
			}
		}
		return "redirect:/AdmFaq";
	}
}