package com.itwillbs.learnon.mapper;

import java.util.List;

import com.itwillbs.learnon.vo.PurchaseVO;

public interface PayMapper {
	
	//결제 상품 목록 조회
	List<PurchaseVO> selectedCart(List<String> checkItems);
}
