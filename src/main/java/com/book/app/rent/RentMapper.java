package com.book.app.rent;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentMapper {
	
	public int create(RentDTO rentDTO) throws Exception;
	
	public Long countMyRent(RentDTO rentDTO) throws Exception;
	
	public List<RentDTO> myRentList(RentDTO rentDTO) throws Exception;
	
	public int myRentDelete(RentDTO rentDTO) throws Exception;
	
	public Long rentHistory(RentDTO rentDTO) throws Exception;

}
