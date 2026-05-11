package com.book.app.rent;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentMapper {
	
	public int create(RentDTO rentDTO) throws Exception;

}
