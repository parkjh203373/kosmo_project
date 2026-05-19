package com.book.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.book.app.interceptor.NotificationInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	
	@Autowired
    private NotificationInterceptor notificationInterceptor;
	
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(notificationInterceptor)
                .addPathPatterns("/**") // 모든 경로에서 가로채기
                .excludePathPatterns("/css/**", "/js/**", "/img/**", "/vendor/**", "/files/**"); // 정적 리소스는 제외
    }
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // "/" 경로로 접속하면 "index"라는 이름의 뷰(JSP)를 보여주도록 설정
        registry.addViewController("/").setViewName("index");
        
        // 추가로 "/index" 경로도 연결하고 싶다면 아래와 같이 작성
        registry.addViewController("/index").setViewName("index");
    }
}
