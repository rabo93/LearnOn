package com.itwillbs.learnon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.learnon.mapper.CartMapper;
import com.itwillbs.learnon.vo.CartVO;
import com.itwillbs.learnon.vo.MemberVO;

@Service
public class CartService {
	@Autowired
	private CartMapper mapper;
	
	//장바구니 목록 조회 요청
	public List<CartVO> getCartList(String sId) {
		return mapper.selectCart(sId);
	}

	//장바구니 상품 삭제 요청
	public int deleteCart(String cartitem) {
		return mapper.deleteCart(cartitem);
	}
	
	//체크박스 클릭된 상품들에 대한 삭제 요청
	public int deleteManyCart(List<Integer> cartItems) {
		return mapper.deleteCarts(cartItems);
	}
	
	//장바구니 갯수 조회 요청
	public int getCartCount(String sId) {
		return mapper.countCart(sId);
	}

	
	
}
