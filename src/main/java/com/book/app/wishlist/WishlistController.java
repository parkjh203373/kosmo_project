package com.book.app.wishlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.app.member.MemberDTO;
import com.book.app.pager.Pager;
import com.book.app.rent.RentDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/wishlist/*")
public class WishlistController {
	
	@Autowired
    private WishlistService wishlistService;

    // 1. 찜 목록 조회
    @GetMapping("list")
    public String list(Pager pager, HttpSession session, Model model) throws Exception {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        
        // 로그인 체크
        if (memberDTO == null) {
            return "redirect:/member/login";
        }
        
        pager.setUsername(memberDTO.getUsername());

        WishlistDTO wishlistDTO = new WishlistDTO();
        wishlistDTO.setUsername(memberDTO.getUsername());

        List<WishlistDTO> list = wishlistService.list(wishlistDTO, pager);
        
        model.addAttribute("list", list);
        model.addAttribute("pager", pager);
        session.setAttribute("wishCount", list.size());
        
        return "wishlist/list";
    }
    
    @PostMapping("create")
    @ResponseBody
    public int create(WishlistDTO wishlistDTO, HttpSession session) throws Exception {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        
        if (memberDTO == null) {
            return -1;
        }
        
        wishlistDTO.setUsername(memberDTO.getUsername());
        int result = wishlistService.create(wishlistDTO);
        if(result == 1) {
	        List<WishlistDTO> list = wishlistService.list(wishlistDTO, new Pager());
	        session.setAttribute("wishCount", list.size());
	    }
        return result;
    }
    
    @PostMapping("delete")
    public String delete(WishlistDTO wishlistDTO, HttpSession session) throws Exception {
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        
        if (memberDTO != null) {
        	wishlistDTO.setUsername(memberDTO.getUsername());
        	int result = wishlistService.delete(wishlistDTO);
        	if(result == 1) {
    	        List<WishlistDTO> list = wishlistService.list(wishlistDTO, new Pager());
    	        session.setAttribute("wishCount", list.size());
    	    }
        }
        
        return "redirect:./list";
    }
	
}
