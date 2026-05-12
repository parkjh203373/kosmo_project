package com.book.app.member;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class MemberServiceTest {
	
	@Autowired
	private MemberMapper memberMapper;

//	@Test
//	void testDeleteId() throws Exception{
//		MemberDTO memberDTO = new MemberDTO();
//		ProfileDTO profileDTO = new ProfileDTO();
//				
//		memberDTO.setMemberNum(9L);
//		profileDTO.setMemberNum(memberDTO.getMemberNum());
//				
//		memberMapper.deleteProfile(profileDTO);
//		memberMapper.deleteId(memberDTO);
//		
//	}
	
//	@Test
//	void testDetail() throws Exception{
//		MemberDTO memberDTO = new MemberDTO();
//	    memberDTO.setMemberNum(2L); // 조회하고 싶은 번호 세팅
//		
//		System.out.println(memberMapper.detail(memberDTO));
//	}

//	@Test
//	void testCreate() throws Exception{
//		MemberDTO memberDTO = new MemberDTO();
//		
//		memberDTO.setUsername("user1");
//		memberDTO.setPassword("user1");
//		memberDTO.setMemberName("홍길동");
//		memberDTO.setMemberBirth(LocalDate.parse("2000-01-01"));
//		memberDTO.setMemberEmail("asdf@naver.com");
//		
//		memberMapper.create(memberDTO);
//	}

}
