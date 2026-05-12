package com.book.app.member;

import com.book.app.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProfileDTO extends FileDTO{

	private String username;
}
