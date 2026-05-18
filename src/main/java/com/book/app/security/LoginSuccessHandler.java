package com.book.app.security;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.book.app.member.MemberDTO;
import com.book.app.pager.Pager;
import com.book.app.rent.RentDTO;
import com.book.app.rent.RentService;
import com.book.app.wishlist.WishlistDTO;
import com.book.app.wishlist.WishlistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private RentService rentService;
	
	@Autowired
	private WishlistService wishlistService;
		
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
        
        // 시큐리티 인증이 성공하면 principal에 MemberDTO(UserDetails)가 담겨 있습니다.
        MemberDTO loginMember = (MemberDTO) authentication.getPrincipal();
        
        // 1. 세션에 로그인 유저 정보 저장
        session.setAttribute("member", loginMember);
        
        try {
            // 2. 대여 및 연체 정보 조회 후 세션 저장
            RentDTO rentDTO = new RentDTO();
            rentDTO.setUsername(loginMember.getUsername());
            
            List<RentDTO> rentList = rentService.myRentList(rentDTO);
            session.setAttribute("rentCount", rentList.size());
            
            List<RentDTO> lateList = rentService.lateRent(rentDTO);
            session.setAttribute("lateList", lateList);        
            session.setAttribute("lateCount", lateList.size());
            System.out.println(lateList.size());
            
            // 3. 위시리스트 조회 후 세션 저장
            WishlistDTO wishlistDTO = new WishlistDTO();
            wishlistDTO.setUsername(loginMember.getUsername());
            List<WishlistDTO> wishList = wishlistService.list(wishlistDTO, new Pager()); 
            session.setAttribute("wishCount", wishList.size());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        		
		String s = request.getParameter("rememberId");
		try {
			if (s.equals("1")) {
				log.info("Login Success {}", authentication.getName());
				Cookie cookie = new Cookie("rememberId", authentication.getName());
				cookie.setMaxAge(600);
				cookie.setPath("/");
				response.addCookie(cookie);
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			Cookie cookie = new Cookie("rememberId", "");
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}

		// ⭐ 리다이렉트는 모든 로직이 정상적으로 끝난 '맨 마지막'에 딱 한 번만 호출합니다.
		response.sendRedirect("/");

	}

}
