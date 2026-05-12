package com.book.app.member;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	
	private String username;
	private String password;
	private String memberName;
	private LocalDate memberBirth;
	private String memberEmail;
	
	private ProfileDTO profileDTO;
}
