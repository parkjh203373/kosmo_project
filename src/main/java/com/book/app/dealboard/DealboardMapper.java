package com.book.app.dealboard;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.book.app.pager.Pager;

@Mapper
public interface DealboardMapper {

	public Long getTotalCount(Pager pager) throws Exception;
	
	public List<DealboardDTO> list(Pager pager) throws Exception;
	
	public DealboardDTO detail(DealboardDTO dealboardDTO) throws Exception;
	
	public int createOldbook(OldbookDTO oldbookDTO) throws Exception;
	
	public int createOldbookFile(OldbookFileDTO oldbookFileDTO) throws Exception;

	public int createBoard(DealboardDTO dealboardDTO) throws Exception;
	

}
