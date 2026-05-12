package com.book.app.dealboard;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DealboardDTO {
	
	private Long dealboardNum;
	private String username;
	private Long oldbookNum;
	private String dealboardTitle;
	private String dealboardContents;
	
	private OldbookDTO oldbookDTO;
}
