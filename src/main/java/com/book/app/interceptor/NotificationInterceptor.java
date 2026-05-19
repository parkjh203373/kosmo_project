package com.book.app.interceptor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.book.app.dealboard.DealboardDTO;
import com.book.app.dealboard.DealboardService;
import com.book.app.member.MemberDTO;
import com.book.app.pager.Pager;
import com.book.app.rent.RentDTO;
import com.book.app.rent.RentService;
import com.book.app.wishlist.WishlistDTO;
import com.book.app.wishlist.WishlistService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class NotificationInterceptor implements HandlerInterceptor {
	
	@Autowired
    private RentService rentService;
    
    @Autowired
    private DealboardService dealboardService;
    
    @Autowired
    private WishlistService wishlistService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HttpSession session = request.getSession();
        MemberDTO loginMember = (MemberDTO) session.getAttribute("member");

        if (loginMember != null && modelAndView != null) {
            try {
                // 1. 최신 정보 조회
                RentDTO rentDTO = new RentDTO();
                rentDTO.setUsername(loginMember.getUsername());
                List<RentDTO> lateList = rentService.lateRent(rentDTO);
                
                List<DealboardDTO> soldList = dealboardService.getSoldList(loginMember);
                
                WishlistDTO wishlistDTO = new WishlistDTO();
                wishlistDTO.setUsername(loginMember.getUsername());
                List<WishlistDTO> wishList = wishlistService.list(wishlistDTO, new Pager()); 

                // 2. 세션 갱신 (기존 코드 유지)
                session.setAttribute("lateList", lateList);
                session.setAttribute("lateCount", lateList.size());
                session.setAttribute("soldList", soldList);
                session.setAttribute("wishCount", wishList.size());

                // 3. 💡 ModelAndView에 직접 추가 (JSP에서 가장 확실하게 읽어오는 방법)
                modelAndView.addObject("lateList", lateList);
                modelAndView.addObject("lateCount", lateList.size());
                modelAndView.addObject("soldList", soldList);
                modelAndView.addObject("wishCount", wishList.size());
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
