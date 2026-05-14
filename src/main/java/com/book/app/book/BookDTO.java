package com.book.app.book;

import java.io.Serializable;

import com.book.app.rent.RentDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BookDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
    private Long bookNum;
    private String bookTitle;
    private String bookAuthor;
    private String bookPublisher;
    private String bookDate;
    private String bookStatus;
    private String bookImage;
    private String bookContents;
    private RentDTO rentDTO;
    private Long rentCount;
    
    public BookDTO() {}
    
        
}
