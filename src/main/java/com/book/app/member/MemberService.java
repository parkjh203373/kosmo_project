package com.book.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		
		return memberMapper.detail(memberDTO);
	}
	
	public int create(MemberDTO memberDTO) throws Exception {
		return memberMapper.create(memberDTO);
	}
}
