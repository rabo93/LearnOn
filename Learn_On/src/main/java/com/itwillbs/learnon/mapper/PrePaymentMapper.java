package com.itwillbs.learnon.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.learnon.vo.PayVO;

@Mapper
public interface PrePaymentMapper {

	void save(PayVO pay);
}
