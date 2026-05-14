const pName = document.getElementById('pName').innerText;
const pPrice = parseInt(document.getElementById('pPrice').innerText);
const dealboardNum = document.getElementById('dealboardNum').value;

$(function() {
    $("#btn-pay-ready").click(function(e) {
        e.preventDefault(); // 폼 제출 등 기본 동작 중단

        let data = {
            name: pName,
            dealboardNum: dealboardNum,
            totalPrice: pPrice
        };
      
        $.ajax({
            type: 'POST',
            url: '/order/pay/ready', 
            data: JSON.stringify(data),
            contentType: 'application/json',
            // 인증 헤더(Secret Key)가 누락되면 여기서 다시 에러가 날 수 있습니다.
            success: function(response) {
                location.href = response.next_redirect_pc_url;
            },
            error: function(err) {
                console.error("결제 준비 실패:", err);
            }
        });
    });
});