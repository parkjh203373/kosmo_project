package com.book.app.config;

import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class WebConfig implements WebMvcConfigurer{
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // "/" 경로로 접속하면 "index"라는 이름의 뷰(JSP)를 보여주도록 설정
        registry.addViewController("/").setViewName("index");
        
        // 추가로 "/index" 경로도 연결하고 싶다면 아래와 같이 작성
        registry.addViewController("/index").setViewName("index");
    }

}
