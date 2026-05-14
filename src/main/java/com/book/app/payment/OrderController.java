package com.book.app.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.app.dealboard.DealboardDTO;
import com.book.app.dealboard.DealboardService;
import com.book.app.dealboard.OldbookDTO;
import com.book.app.dealboard.OldbookFileDTO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/order/pay/*")
@Slf4j
public class OrderController {

	@Autowired
	private KakaoPayService kakaoPayService;
	
	@Autowired
	private DealboardService dealboardService;
	
	@GetMapping("ready")
	public void payReady() throws Exception {}
	
	@PostMapping("ready")
    public @ResponseBody ReadyResponse payReady(@RequestBody OrderCreateForm orderCreateForm
    		, DealboardDTO dealboardDTO, HttpSession session) {

		// JS에서 보낸 번호를 확인 (Dumb 객체가 아닌 실제 번호를 세션에 저장)
	    session.setAttribute("dealboardNum", orderCreateForm.getDealboardNum());
		
        String name = orderCreateForm.getName();
        int totalPrice = orderCreateForm.getTotalPrice();
        
        log.info("주문 상품 이름: " + name);
        log.info("주문 금액: " + totalPrice);

        // 카카오 결제 준비하기
        ReadyResponse readyResponse = kakaoPayService.payReady(name, totalPrice, session);
        // 세션에 결제 고유번호(tid) 저장
        SessionUtil.addAttribute("tid", readyResponse.getTid());
        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

	@GetMapping("approve")
	public String payCompleted(@RequestParam(value = "pg_token", required = false) String pgToken
			,HttpSession session) throws Exception {
	    if (pgToken == null) {
	        // 토큰이 없는데 이 페이지에 접속했다면 에러 페이지나 메인으로 리다이렉트
	        log.error("pg_token이 전달되지 않았습니다.");
	        return "redirect:/order/fail"; 
	    }
	    
	    String tid = SessionUtil.getStringAttributeValue("tid");
	    log.info("결제승인 요청 토큰: " + pgToken);
	    log.info("결제 고유번호: " + tid);

	    // 승인 요청 로직...
	    kakaoPayService.payApprove(tid, pgToken, session);
	    
	    // 1. 세션에서 번호만 꺼냄
	    Long dealboardNum = (Long) session.getAttribute("dealboardNum");
	    
	    // 2. DB에서 풀 데이터 조회 (Join 쿼리가 포함된 detail 메서드 호출)
	    DealboardDTO boardData = new DealboardDTO();
	    boardData.setDealboardNum(dealboardNum);
	    boardData = dealboardService.detail(boardData); 
	    log.info("게시판 번호" + dealboardNum);
	    log.info("{}" + boardData);
	    
	    // 4. 안전하게 데이터 삭제 진행
	    if (boardData != null && boardData.getOldbookDTO() != null) {
	        OldbookDTO oldbookDTO = boardData.getOldbookDTO();
	        OldbookFileDTO oldbookFileDTO = oldbookDTO.getOldbookFileDTO();
	        dealboardService.deleteBoard(boardData, oldbookDTO, oldbookFileDTO);
	    }

	    return "redirect:/order/pay/completed";
	}
	
	@GetMapping("completed")
    public String showCompletedPage() {
        // /WEB-INF/views/order/completed.jsp 를 찾아감
        return "order/completed"; 
    }
	
	@GetMapping("fail")
    public String showFailPage() {
        // /WEB-INF/views/order/completed.jsp 를 찾아감
        return "order/fail"; 
    }
}
