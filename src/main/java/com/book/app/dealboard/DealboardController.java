package com.book.app.dealboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.book.app.member.MemberDTO;
import com.book.app.pager.Pager;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/dealboard/*")
public class DealboardController {

	@Autowired
	private DealboardService dealboardService;
	
	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {
	    List<DealboardDTO> ar = dealboardService.list(pager);
	    
	    model.addAttribute("list", ar);
	    model.addAttribute("pager", pager); // JSP에서 번호를 찍기 위해 pager 객체 전달
	    
	    return "dealboard/list";
	}
	
	@GetMapping("detail")
	public String detail(DealboardDTO dealboardDTO, Model model) throws Exception {
		System.out.println("전달받은 번호: " + dealboardDTO.getDealboardNum());
		dealboardDTO = dealboardService.detail(dealboardDTO);
		System.out.println(dealboardDTO);
		model.addAttribute("dealboardDTO", dealboardDTO);
		return "dealboard/detail";
	}
	
	@GetMapping("create")
	public void create() throws Exception{}
	
	@PostMapping("create")
	public String create(OldbookDTO oldbookDTO, DealboardDTO dealboardDTO, 
			@RequestParam("attach") MultipartFile attach, HttpSession session) throws Exception {
	    
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
	    if(memberDTO == null) return "redirect:/member/login";
	    
	    dealboardDTO.setUsername(memberDTO.getUsername());
	    
	    dealboardService.create(dealboardDTO, oldbookDTO, attach);
	    
	    return "redirect:/dealboard/list";
	}
	
	@GetMapping("delete")
	public String delete(DealboardDTO dealboardDTO, OldbookFileDTO oldbookFileDTO,
	        OldbookDTO oldbookDTO, HttpSession session) throws Exception {

	    // 1. "member"라는 이름으로 저장된 객체를 꺼냄 (형변환 필요)
	    MemberDTO loginMember = (MemberDTO) session.getAttribute("member");
	    DealboardDTO boardData = dealboardService.detail(dealboardDTO);
	    
	    // 2. 객체가 null인지 확인 (로그인 여부)
	    if (loginMember == null) {
	        return "redirect:/member/login";
	    }

	    // 3. 객체에서 ID를 꺼냄
	    String id = loginMember.getUsername();

	    // 4. 작성자 본인 확인 및 삭제 로직
	    if (id.equals(boardData.getUsername())) {
	        dealboardService.deleteBoard(dealboardDTO, oldbookDTO, oldbookFileDTO);
	        return "redirect:/";
	    }
	    
	    return "redirect:/dealboard/list"; 
	}
	
}
