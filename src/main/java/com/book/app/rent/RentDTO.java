package com.book.app.rent;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import com.book.app.book.BookDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RentDTO {
	
	private Long rentNum;
	private LocalDateTime rentDate;
	private LocalDateTime dueDate;
	private Long bookNum;
	private String username;
	private BookDTO bookDTO;
	
	private static final DateTimeFormatter VIEW_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // JSP에서 ${d.rentDTO.rentDate} 호출 시 실행됨
    public String getRentDate() {
        return this.rentDate != null ? this.rentDate.format(VIEW_FORMATTER) : "";
    }

    // JSP에서 ${d.rentDTO.dueDate} 호출 시 실행됨
    public String getDueDate() {
        return this.dueDate != null ? this.dueDate.format(VIEW_FORMATTER) : "";
    }

    public String getLateStatus() {
        if (this.dueDate == null) return "정보 없음";

        // LocalDateTime을 날짜 비교를 위해 LocalDate로 변환
        LocalDate today = LocalDate.now();
        LocalDate due = this.dueDate.toLocalDate();

        if (today.isAfter(due)) {
            long days = ChronoUnit.DAYS.between(due, today);
            return "연체 중 (+" + days + "일)";
        }
        
        return "대출 중";
    }

}
