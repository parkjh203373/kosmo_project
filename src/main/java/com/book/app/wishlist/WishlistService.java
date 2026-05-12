package com.book.app.wishlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.app.pager.Pager;

@Service
public class WishlistService {
	
	@Autowired
	private WishlistMapper wishlistMapper;
	
	public List<WishlistDTO> list(WishlistDTO wishlistDTO, Pager pager) throws Exception {
		pager.makePageNum(wishlistMapper.getCount(pager));
		pager.makeStartNum();
		return wishlistMapper.list(wishlistDTO, pager);
	}
	
	public int create(WishlistDTO wishlistDTO) throws Exception {
		return wishlistMapper.create(wishlistDTO);
	}
	
	public int delete(WishlistDTO wishlistDTO) throws Exception {
		return wishlistMapper.delete(wishlistDTO);
	}

}
