package com.book.app.rent;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RentDTO {
	
	private Long rentNum;
	private String rentDate;
	private String dueDate;
	private Long bookNum;
	private Long memberNum;
	
	public String getLateStatus() {
	    if (this.dueDate == null) return "대출 가능";
	  
	    // 1. 네이버/DB에서 온 데이터가 '20240520' 형태일 때의 포맷터
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	    
	    try {
	        LocalDate today = LocalDate.now();
	        // 2. 문자열을 포맷에 맞춰 LocalDate로 변환
	        LocalDate due = LocalDate.parse(this.dueDate, formatter); 
	        
	        if (today.isAfter(due)) {
	            long days = ChronoUnit.DAYS.between(due, today);
	            return "연체 중 (+" + days + "일)";
	        }
	    } catch (Exception e) {
	        return "날짜 확인 불가";
	    }
	    return "대출 중";
	}

}
