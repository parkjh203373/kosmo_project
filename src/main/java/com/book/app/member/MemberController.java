package com.book.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@PostMapping("create")
	public String create(MemberDTO memberDTO, @RequestParam("attach") MultipartFile attach) throws Exception {
	    int result = memberService.create(memberDTO, attach);

        return "redirect:/"; 
	}
	
	@GetMapping("login")
	public void login() throws Exception{}
	
	@PostMapping("login")
	public String login(MemberDTO memberDTO, Model model, HttpSession session) throws Exception{
		MemberDTO checkLogin = memberService.detail(memberDTO);
				
		if(checkLogin != null
				&& checkLogin.getPassword().equals(memberDTO.getPassword())) {
			System.out.println("로그인 성공");
			session.setAttribute("member", checkLogin);
			return "redirect:/";
		}
		else {
			System.out.println("로그인 실패");
			System.out.println(model.getAttribute("memberDTO"));
			return "/member/login";
		}
				
	}
	
	@GetMapping("mypage")
	public String mypage(HttpSession session, Model model) throws Exception {
	    
	    MemberDTO loginMember = (MemberDTO) session.getAttribute("member");

	    if (loginMember == null) {
	        return "redirect:/member/login";
	    }

	    MemberDTO memberDTO = memberService.detail(loginMember);
	    
	    model.addAttribute("member", memberDTO);
	    return "member/mypage";
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
	    return "redirect:/";
	}
	
	@GetMapping("delete")
	public String deleteId(MemberDTO memberDTO) throws Exception {
		int result = memberService.deleteId(memberDTO);
		return "redirect:/";
	}
	
	@GetMapping("update")
	public String update(HttpSession session, Model model) throws Exception{
		MemberDTO loginMember = (MemberDTO) session.getAttribute("member");

	    System.out.println("세션에서 가져온 회원 정보: " + loginMember);
	    if (loginMember == null) {
	        return "redirect:/member/login";
	    }

	    MemberDTO memberDTO = memberService.detail(loginMember);
	    System.out.println(memberDTO.getProfileDTO().getFileName());
	    model.addAttribute("member", memberDTO);
	    return "member/update";
	}
	
	@PostMapping("update")
	public String update(MemberDTO memberDTO, @RequestParam("attach") MultipartFile attach, HttpSession session) throws Exception{
		int result = memberService.updateId(memberDTO, attach);
		
		this.logout(session);
		return "redirect:/member/login";
	}
}
