package com.book.app.book;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.book.app.pager.Pager;

@Mapper
public interface BookMapper {
	
	public Long getCount(Pager pager) throws Exception;
	
	public List<BookDTO> list(Pager pager) throws Exception;
	
	public BookDTO detail(BookDTO bookDTO) throws Exception;
	
	public int create(BookDTO bookDTO) throws Exception;
	
	public int update(BookDTO bookDTO) throws Exception;
	
	public int updateStatus(BookDTO bookDTO) throws Exception;
	
	public int delete(BookDTO bookDTO) throws Exception;
	
	public List<BookDTO> getBestSeller() throws Exception;
	
	public List<BookDTO> getBestSellerByAge(@Param("age") Integer ageGroup) throws Exception;

}
