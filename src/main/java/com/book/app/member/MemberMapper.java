package com.book.app.member;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

@Mapper
public interface MemberMapper {
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception;
	
	public int create(MemberDTO memberDTO) throws Exception;
	
	public int addProfile(ProfileDTO profileDTO) throws Exception;
	
}
