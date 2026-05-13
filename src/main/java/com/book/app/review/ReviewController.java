package com.book.app.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.app.member.MemberDTO;
import com.book.app.rent.RentDTO;
import com.book.app.rent.RentService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private RentService rentService;
	
	@PostMapping("add")
	@ResponseBody
	public int create(ReviewDTO reviewDTO, HttpSession session) throws Exception {
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		
		if(memberDTO == null) {
			return -1;
		}
		
		RentDTO rentDTO = new RentDTO();
	    rentDTO.setBookNum(reviewDTO.getBookNum());
	    rentDTO.setUsername(memberDTO.getUsername());
	    
	    if(!rentService.rentHistory(rentDTO)) {
	        return -2;
	    }
		
		reviewDTO.setUsername(memberDTO.getUsername());
		
		return reviewService.create(reviewDTO);
	}
	
	@GetMapping("list")
	public String getList(ReviewDTO reviewDTO, Model model, HttpSession session) throws Exception {
	    List<ReviewDTO> list = reviewService.list(reviewDTO);
	    model.addAttribute("list", list);
	    
	    MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
	    model.addAttribute("member", memberDTO);
	    
	    return "review/list";
	}
	
	@PostMapping("update")
	@ResponseBody
	public int update(ReviewDTO reviewDTO, HttpSession session) throws Exception {
	    MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
	    if(memberDTO == null) {
	        return -1;
	    }
	    
	    reviewDTO.setUsername(memberDTO.getUsername());
	    
	    return reviewService.update(reviewDTO);
	}
	
	@PostMapping("delete")
	@ResponseBody
	public int delete(ReviewDTO reviewDTO, HttpSession session) throws Exception {
	    MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
	    
	    if(memberDTO == null) {
	        return -1;
	    }

	    reviewDTO.setUsername(memberDTO.getUsername());
	    
	    return reviewService.delete(reviewDTO);
	}

}
