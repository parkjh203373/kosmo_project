package com.book.app.rent;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.app.book.BookDTO;
import com.book.app.book.BookMapper;

@Service
public class RentService {
	
	@Autowired
	private RentMapper rentMapper;
	@Autowired
	private BookMapper bookMapper;
	
	public int create(RentDTO rentDTO) throws Exception {
		int result = rentMapper.create(rentDTO);
		
		if(result > 0) {
	        BookDTO bookDTO = new BookDTO();
	        bookDTO.setBookNum(rentDTO.getBookNum());
	        bookDTO.setBookStatus("대출중");
	        bookMapper.updateStatus(bookDTO);
	    }
		
		return result;
	}

}
