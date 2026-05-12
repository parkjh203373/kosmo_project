package com.book.app.wishlist;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.book.app.pager.Pager;

@Mapper
public interface WishlistMapper {
	
	public Long getCount(Pager pager) throws Exception;
	
	public List<WishlistDTO> list(@Param("wish") WishlistDTO wishlistDTO, @Param("pager") Pager pager) throws Exception;
	
	public int create(WishlistDTO wishlistDTO) throws Exception;
	
	public int delete(WishlistDTO wishlistDTO) throws Exception;

}
