package com.book.app.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.book.app.pager.Pager;
import com.book.app.rent.RentDTO;
import com.book.app.rent.RentService;
import com.book.app.wishlist.WishlistDTO;
import com.book.app.wishlist.WishlistService;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private RentService rentService;
	
	@Autowired
	private WishlistService wishlistService;
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@PostMapping("create")
	public String create(MemberDTO memberDTO, @RequestParam("attach") MultipartFile attach) throws Exception {
	    int result = memberService.create(memberDTO, attach);

        return "redirect:/"; 
	}
	
	@GetMapping("idCheck")
	@ResponseBody // 데이터만 그대로 반환 (JSON/String)
	public int idCheck(@RequestParam("username") String username) throws Exception {
	    // memberService.detail은 아이디가 없으면 null을 반환한다고 가정
	    MemberDTO memberDTO = new MemberDTO();
	    memberDTO.setUsername(username);
	    
	    int result = memberService.idCheck(memberDTO);
	    return result; // 0이면 사용 가능, 1이면 중복
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
			
			RentDTO rentDTO = new RentDTO();
	        rentDTO.setUsername(memberDTO.getUsername());
	        List<RentDTO> rentList = rentService.myRentList(rentDTO);
	        session.setAttribute("rentCount", rentList.size());
	        

	        WishlistDTO wishlistDTO = new WishlistDTO();
	        wishlistDTO.setUsername(memberDTO.getUsername());
	        List<WishlistDTO> wishList = wishlistService.list(wishlistDTO, new Pager()); 
	        session.setAttribute("wishCount", wishList.size());
			
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
	public String deleteId(MemberDTO memberDTO, HttpSession session) throws Exception {
		int result = memberService.deleteId(memberDTO);
		this.logout(session);
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
