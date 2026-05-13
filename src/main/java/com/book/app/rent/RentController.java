package com.book.app.rent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.app.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/rent/*")
public class RentController {
	
	@Autowired
	private RentService rentService;
	
	@PostMapping("create")
	@ResponseBody
	public int create(RentDTO rentDTO, HttpSession session) throws Exception {
	    MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
	    if(memberDTO == null) return -2; 
	    
	    rentDTO.setUsername(memberDTO.getUsername());
	    int result = rentService.create(rentDTO);
	    
	    // 추가: 대출 성공 시 세션 카운트 갱신
	    if(result == 1) {
	        List<RentDTO> list = rentService.myRentList(rentDTO);
	        session.setAttribute("rentCount", list.size());
	    }
	    
	    return result;
	}
	
	@GetMapping("list")
    public String myRentList(HttpSession session, Model model) throws Exception {
        MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
        if(memberDTO == null) return "redirect:/member/login";
        
        RentDTO rentDTO = new RentDTO();
        rentDTO.setUsername(memberDTO.getUsername());
        
        List<RentDTO> list = rentService.myRentList(rentDTO);
        model.addAttribute("list", list);
        
        session.setAttribute("rentCount", list.size());
        
        return "rent/list";
    }
	
	@PostMapping("delete")
	@ResponseBody
	public int delete(RentDTO rentDTO, HttpSession session) throws Exception {
	    MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
	    if(memberDTO == null) return -2;
	    
	    rentDTO.setUsername(memberDTO.getUsername());
	    int result = rentService.myRentDelete(rentDTO);
	    
	    if(result > 0) {
	        List<RentDTO> list = rentService.myRentList(rentDTO);
	        session.setAttribute("rentCount", list.size());
	    }
	    
	    return result;
	}

}
