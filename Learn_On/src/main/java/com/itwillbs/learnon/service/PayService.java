package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.PayMapper;
import com.itwillbs.learnon.vo.PurchaseVO;

@Service
public class PayService {
	@Autowired
	private PayMapper mapper;

	//결제 상품 목록 조회
	public List<PurchaseVO> getSelectedCart(List<String> checkItems) {
		System.out.println("Service checkItems: " + checkItems);  // checkItems 값 확인
		return mapper.selectedCart(checkItems);
	}
	
	
}
