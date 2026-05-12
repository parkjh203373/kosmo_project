package com.book.app.wishlist;

import com.book.app.book.BookDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishlistDTO {
	
	private Long bookNum;
	private String username;
	private BookDTO bookDTO;

}
