package com.book.app.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginFailHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		String message = "로그인 실패";
		
		if(exception instanceof AccountExpiredException) {
			//계정 만료 
			message = "계정 만료";
		}
		if(exception instanceof LockedException) {
			//계정 잠김
			message = "계정 잠김";
		}
		if(exception instanceof CredentialsExpiredException) {
			// 비밀번호 유효기간 만료
			message = "비밀번호 유효기간 만료";
		}
		if(exception instanceof DisabledException) {
			// 휴면 계정
			message = "휴면 계정";
		}
		
		if(exception instanceof BadCredentialsException) {
			// 비밀번호가 틀린경우
			message = "틀린 비밀번호";
		}
		
		if(exception instanceof InternalAuthenticationServiceException) {
			// 아이디가 틀린경우
			message = "틀린 아이디";
		}
		
		message = URLEncoder.encode(message, "UTF-8");
		response.sendRedirect("./login?message="+message);
	}
		
}