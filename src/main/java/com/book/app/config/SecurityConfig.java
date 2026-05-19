package com.book.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.book.app.member.MemberController;
import com.book.app.security.LoginFailHandler;
import com.book.app.security.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private LoginSuccessHandler loginSuccessHandler;
		
	private final MemberController memberController;

    SecurityConfig(MemberController memberController) {
        this.memberController = memberController;
    }
	
	// footer, header등 사이트에 사용되는 정적자원(front에서 보여지는 자원들)에 대한 설정
	@Bean
	WebSecurityCustomizer customizer() {
		return web -> {
			web.ignoring()
				.requestMatchers("/css/**")
				.requestMatchers("/images/**", "/img/**", "/js/**", "/vendor/**")
				.requestMatchers("/files/**", "/fileDown/**");
		};
	}
	
	
	//인증과 인가에 대한 설정
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity security) throws Exception{
		security
			.cors(cors->{cors.disable();})
			.csrf(csrf->{csrf.disable();})
			.authorizeHttpRequests(auth->{ //인가에 대한 설정(권한설정)
				auth
				.requestMatchers("/book/create", "/book/update", "/book/delete", "/book/deleteAll")
							.hasAnyRole("ADMIN", "MANAGER")
				.requestMatchers("/book/list", "/book/detail", 
						"/dealboard/create", "/dealboard/detail", "/dealboard/list", "/dealboard/update",
						"/order/completed", "/order/fail",
						"/rent/list", "/review/list", "/wishlist/list")
							.hasAnyRole("ADMIN", "MANAGER", "MEMBER")
				.requestMatchers("/member/logout", "/member/mypage", "/member/update", "/member/delete").authenticated()
				.requestMatchers("/member/login").permitAll()
				.anyRequest().permitAll()
				;
			})
			//login form 과 관련된 설정
			.formLogin(form->{
				form
					.loginPage("/member/login")
					.usernameParameter("username")
					.passwordParameter("password")
					.loginProcessingUrl("/member/login")
					.successHandler(loginSuccessHandler) // 로그인을 성공한 뒤 추가 작업을 실행하고 싶을 때 사용
					.failureHandler(new LoginFailHandler())
					;
			})
			
			.logout(logout->{
				logout.logoutUrl("/member/logout")
				.invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")
				.logoutSuccessUrl("/")
				;
			})
		; 
			
		return security.build();
	}
	
}
