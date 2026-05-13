package com.book.app.rent;

import java.util.List;
import com.book.app.config.FileMappingConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.book.app.book.BookDTO;
import com.book.app.book.BookMapper;

@Service
@Transactional(rollbackFor = Exception.class)
public class RentService {

    private final FileMappingConfig fileMappingConfig;
	
	@Autowired
	private RentMapper rentMapper;
	@Autowired
	private BookMapper bookMapper;

    RentService(FileMappingConfig fileMappingConfig) {
        this.fileMappingConfig = fileMappingConfig;
    }
	
	public int create(RentDTO rentDTO) throws Exception {
		Long count = rentMapper.countMyRent(rentDTO);
		if(count >= 3) {
			return -1;
		}
		int result = rentMapper.create(rentDTO);
		
		if(result > 0) {
	        BookDTO bookDTO = new BookDTO();
	        bookDTO.setBookNum(rentDTO.getBookNum());
	        bookDTO.setBookStatus("대출중");
	        bookMapper.updateStatus(bookDTO);
	    }
		
		return result;
	}
	
	public List<RentDTO> myRentList(RentDTO rentDTO) throws Exception {
		return rentMapper.myRentList(rentDTO);
	}
	
	public int myRentDelete(RentDTO rentDTO) throws Exception {
		int result = rentMapper.myRentDelete(rentDTO);
		
		if(result > 0) {
			BookDTO bookDTO = new BookDTO();
			bookDTO.setBookNum(rentDTO.getBookNum());
			bookDTO.setBookStatus("대출가능");
			bookMapper.updateStatus(bookDTO);
		}
		
		return result;
	}
	
	public boolean rentHistory(RentDTO rentDTO) throws Exception {
		return rentMapper.rentHistory(rentDTO) > 0;
	}
	
	public List<RentDTO> lateRent(RentDTO rentDTO) throws Exception {
		return rentMapper.lateRent(rentDTO);
	}

}
