package com.itwillbs.learnon.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.NoticeBoardMapper;
import com.itwillbs.learnon.vo.NoticeBoardVO;

@Service
public class NoticeBoardService {
	@Autowired
	private NoticeBoardMapper noticeMapper;

	public List<NoticeBoardVO> getBoardList(int startRow, int listLimit, String sort) {
		return noticeMapper.selectBoardList(startRow, listLimit, sort);
	}

	public int getBoardListCount() {
		return noticeMapper.selectBoardListCount();
	}

	public NoticeBoardVO getNoticeBoard(int notice_idx) {
		return noticeMapper.selectNoticeBoard(notice_idx);
	}
	
	public int registBoard(NoticeBoardVO board) {
		return noticeMapper.insertNoticeBoard(board);
	}
	
}
