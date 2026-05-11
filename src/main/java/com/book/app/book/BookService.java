package com.book.app.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.app.pager.Pager;

@Service
public class BookService {
	
	@Autowired
	private BookMapper bookMapper;
	
	public List<BookDTO> list(Pager pager) throws Exception {
		pager.makePageNum(bookMapper.getCount());
		pager.makeStartNum();
		return bookMapper.list(pager);
	}
	
	public BookDTO detail(BookDTO bookDTO) throws Exception {
		return bookMapper.detail(bookDTO);
	}
	
	public int create(BookDTO bookDTO) throws Exception {
		return bookMapper.create(bookDTO);
	}
	
	public int update(BookDTO bookDTO) throws Exception {
		return bookMapper.update(bookDTO);
	}
	
	public int delete(BookDTO bookDTO) throws Exception {
		return bookMapper.delete(bookDTO);
	}

}
