package com.book.app.book;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BookDTO {
	
    private Long bookNum;
    private String bookTitle;
    private String bookAuthor;
    private String bookPublisher;
    private String bookDate;
    private String bookStatus;
    private String bookImage;
    
//    public String getLateStatus() {
//        if (this.dueDate == null) return "대출 가능";
//        
//        LocalDate today = LocalDate.now();
//        // DUE_DATE(반납예정일)가 오늘보다 이전이면 연체!
//        if (today.isAfter(this.dueDate)) {
//            long days = ChronoUnit.DAYS.between(this.dueDate, today);
//            return "연체 중 (+" + days + "일)";
//        }
//        return "대출 중 (정상)";
//    }
        
}
