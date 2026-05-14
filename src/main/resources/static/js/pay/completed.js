
const timerElement = document.getElementById("timer");

document.addEventListener("DOMContentLoaded", function() {
    let timeLeft = 3; // 기준 시간 (3초)
    const timerElement = document.getElementById('timer');

    // 1초(1000ms)마다 반복 실행하는 타이머 생성
    const countdown = setInterval(function() {
        timeLeft--; // 1씩 감소
        
        // 화면의 숫자 업데이트
        if (timerElement) {
            timerElement.innerText = timeLeft;
        }

        // 0초가 되면 이동
        if (timeLeft <= 0) {
            clearInterval(countdown); // 타이머 중지
            window.location.href = "/"; // 메인 페이지 또는 주문 목록 주소
        }
    }, 1000);
});