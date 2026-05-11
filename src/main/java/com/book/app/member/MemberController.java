package com.book.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@PostMapping("create")
	public String create(MemberDTO memberDTO) throws Exception {
	    int result = memberService.create(memberDTO);

        return "redirect:/"; 
	}
	
	@GetMapping("login")
	public void login() throws Exception{}
	
	@PostMapping("login")
	public String login(MemberDTO memberDTO, HttpSession session) throws Exception{
		MemberDTO checkId = memberService.detail(memberDTO);
				
		if(checkId != null
				&& checkId.getPassword().equals(memberDTO.getPassword())) {
			System.out.println("로그인 성공");
			return "redirect:/";
		}
		else {
			System.out.println("로그인 실패");
			return "./login";
		}
				
	}
	
}
