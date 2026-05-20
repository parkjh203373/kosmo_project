document.addEventListener("DOMContentLoaded", function() {
    // 1. JSP의 hidden input에서 서버가 보낸 에러 메시지를 읽어옵니다.
    const errorInput = document.getElementById("serverErrorMessage");
    
    // 태그가 존재할 때만 실행
    if (errorInput) {
        let errorMsg = errorInput.value;
        
        // 2. 메시지가 비어있지 않다면 모달을 띄웁니다.
        if (errorMsg && errorMsg.trim() !== "") {
            // Bootstrap 4 제이쿼리 방식
            $('#errorModal').modal('show');
            
        }
    }
});