// 전역 변수로 중복 확인 상태 저장
let isIdChecked = false;

// 문서가 준비되면 실행
$(document).ready(function() {
    
    // 1. 중복 확인 버튼 클릭 이벤트
    $('#btn-check').click(function() {
        const username = $('#username').val();

        if(username === "") {
            alert("아이디를 입력해주세요.");
            return;
        }

        $.ajax({
            url: "./idCheck", // 현재 위치 기준 상대 경로
            type: "get",
            data: { username: username },
            success: function(res) {
                if(res === 0) {
                    $('#id-msg').text("사용 가능한 아이디입니다.").css("color", "blue");
                    isIdChecked = true;
                } else {
                    $('#id-msg').text("이미 사용 중인 아이디입니다.").css("color", "red");
                    isIdChecked = false;
                }
            },
            error: function() {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    });

    // 2. 아이디 입력창 값이 바뀌면 다시 중복 확인 필요
    $('#username').on('input', function() {
        isIdChecked = false;
        $('#id-msg').text("아이디 중복 확인이 필요합니다.").css("color", "orange");
    });

    // 3. 폼 전송 시 최종 체크
    $('#frm').submit(function(e) {
        if(!isIdChecked) {
            alert("아이디 중복 확인을 해주세요.");
            e.preventDefault(); // 서버로 전송 막기
        }
    });
});