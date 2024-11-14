package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.learnon.mapper.CartMapper;
import com.itwillbs.learnon.vo.CartVO;

@Service
public class CartService {
	@Autowired
	private CartMapper mapper;
	
	//장바구니 목록 조회 요청
	public List<CartVO> getCartList(String memId) {
		return mapper.selectCart(memId);
	}

	//장바구니 상품 삭제 요청
//	public int deleteCart(int cartId) {
//		return mapper.deleteCart(cartId);
//	}
	
	
}
