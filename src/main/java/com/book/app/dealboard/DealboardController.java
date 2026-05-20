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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@GetMapping("myboard")
	public String myboard(Pager pager, Model model, HttpSession session) throws Exception {
		// 1. 세션에서 로그인한 회원 정보 꺼내기
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
	    
	    // 로그인이 안 되어 있다면 로그인 페이지로 리다이렉트
	    if(memberDTO == null) {
	        return "redirect:/member/login";
	    }
	    
	    // 2. Pager 객체에 현재 로그인한 유저의 username 세팅
	    pager.setUsername(memberDTO.getUsername());
	    
	    // 3. 서비스 호출
	    List<DealboardDTO> ar = dealboardService.myboard(pager);
	    
	    model.addAttribute("list", ar);
	    model.addAttribute("pager", pager); 
	    
	    return "dealboard/myboard";
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
			@RequestParam("attach") MultipartFile attach, HttpSession session,
			RedirectAttributes redirectAttributes) throws Exception {
	    
	    MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
	    if(memberDTO == null) return "redirect:/member/login";
	    
	    if(oldbookDTO.getOldbookPrice() == null || oldbookDTO.getOldbookPrice() < 0) {
	    	System.out.println("가격은 음수일 수 없습니다.");
	    	
	    	// 일회성 세션에 메시지를 담아 보냅니다 (새로고침하면 사라짐)
	        redirectAttributes.addFlashAttribute("errorMessage", "금액은 0원 이상만 입력할 수 있습니다.");
	        
	        // 메인이 아닌, 원래 작성하던 등록 폼 페이지로 리다이렉트합니다.
	        return "redirect:/dealboard/create";

	    }
	    
	    dealboardDTO.setUsername(memberDTO.getUsername());
	    dealboardDTO.setMemberEmail(memberDTO.getMemberEmail());
	    
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
	        //dealboardService.deleteBoard(dealboardDTO, oldbookDTO, oldbookFileDTO);
	    	dealboardService.deleteBoard(dealboardDTO);
	        return "redirect:/";
	    }
	    
	    return "redirect:/dealboard/list"; 
	}
	
	@GetMapping("update")
	public String update(DealboardDTO dealboardDTO, Model model) throws Exception {
	    // 기존 데이터를 불러와서 수정 폼에 뿌려줘야 합니다.
	    dealboardDTO = dealboardService.detail(dealboardDTO);
	    model.addAttribute("dealboardDTO", dealboardDTO);
	    return "dealboard/update";
	}

	@PostMapping("update")
	public String update(DealboardDTO dealboardDTO, @RequestParam("attach") MultipartFile attach) throws Exception {
	    int result = dealboardService.update(dealboardDTO, attach);
	    // 수정 완료 후 상세 페이지로 이동
	    return "redirect:./detail?dealboardNum=" + dealboardDTO.getDealboardNum();
	}
	
}
