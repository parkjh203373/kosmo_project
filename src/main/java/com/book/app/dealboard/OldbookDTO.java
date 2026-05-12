package com.book.app.dealboard;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OldbookDTO {

	private Long oldbookNum;
	private Long oldbookPrice;
	private String oldbookTitle;
	private String oldbookAuthor;
	private String oldbookPublisher;
	private LocalDate oldbookDate;
	
	private OldbookFileDTO oldbookFileDTO;
}
