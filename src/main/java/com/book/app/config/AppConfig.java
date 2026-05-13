package com.book.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {

	@Bean
    public RestTemplate restTemplate() {
        // 커넥션 풀, 타임아웃 설정 등을 추가할 수 있습니다.
        return new RestTemplate();
    }
}
