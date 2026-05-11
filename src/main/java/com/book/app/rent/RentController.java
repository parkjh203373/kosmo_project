package com.book.app.rent;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.book.app.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/rent/*")
public class RentController {
	
	@Autowired
	private RentService rentService;
	
	@PostMapping("create")
	public String create(RentDTO rentDTO, HttpSession session) throws Exception {
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		
		// 로그인 체크
	    if(memberDTO == null) {
	        return "redirect:/member/login"; 
	    }
		
		rentDTO.setMemberNum(memberDTO.getMemberNum());
		
		int result = rentService.create(rentDTO);
		
		return "redirect:/book/detail?bookNum=" + rentDTO.getBookNum();
	}

}
