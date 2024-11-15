package com.itwillbs.learnon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.CartVO;

@Mapper
public interface CartMapper {
	// 장바구니 목록 조회 (조회후 목록 list타입으로 리턴)
	List<CartVO> selectCart(String sId);

	// 장바구니 상품 1개 삭제 (삭제 갯수 int타입으로 리턴)
	int deleteCart(String cartitem);

	// 장바구니 상품 여러개 삭제 (삭제 갯수 int타입으로 리턴)
	int deleteCarts(List<Integer> cartItems);
	
	// 장바구니 갯수 조회 (갯수 int 리턴)
	int countCart(String sId);
	
	
	
}
