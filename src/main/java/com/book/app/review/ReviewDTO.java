package com.book.app.review;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReviewDTO {
	
	private Long reviewNum;
	private String reviewContents;
	private LocalDateTime reviewDate;
	private Long reviewRating;
	private Long bookNum;
	private String username;
}
