
const emailBtn = document.getElementById("emailAddress");
    
    if (emailBtn) {
        emailBtn.addEventListener("click", function() {
            // 내부의 이메일 텍스트만 추출 (공백 제거)
            const emailText = this.querySelector("span").innerText.trim();
            
            // 클립보드로 복사 실행
            navigator.clipboard.writeText(emailText).then(function() {
                // 복사 성공 시 알림 (alert 대신 커스텀 UI를 쓰면 더 예쁩니다)
                alert("이메일 주소가 클립보드에 복사되었습니다!\n(" + emailText + ")");
            }).catch(function(err) {
                console.error('복사 실패: ', err);
            });
        });
    }