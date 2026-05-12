package com.book.app.book;

import com.book.app.rent.RentDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BookDTO {
	
    private Long bookNum;
    private String bookTitle;
    private String bookAuthor;
    private String bookPublisher;
    private String bookDate;
    private String bookStatus;
    private String bookImage;
    private String bookContents;
    private RentDTO rentDTO;
    
        
}
