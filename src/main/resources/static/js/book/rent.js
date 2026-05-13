function handleResponse(res, successMsg, redirectUrl) {
    if (res === 1) {
        alert(successMsg);
        location.href = redirectUrl;
    } else if (res === -1) {
        alert("최대 3권까지만 대출 가능합니다.");
    } else if (res === -2) {
        alert("로그인이 필요한 서비스입니다.");
        location.href = "/member/login";
    } else {
        alert("처리 중 오류가 발생했습니다.");
    }
}

const rentBtn = document.getElementById('rentBtn');
if (rentBtn) {
    rentBtn.addEventListener('click', function() {
        if (!confirm("해당 도서를 대출하시겠습니까?")) return;
		
		const bookNum = this.getAttribute('data-bn');

        const p = new URLSearchParams();
        p.append('bookNum', bookNum);

        fetch('/rent/create', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: p
        })
            .then(r => r.json())
            .then(data => {
                handleResponse(data, "대출이 완료되었습니다.", "/book/detail?bookNum=" + bookNum);
            })
            .catch(error => console.error('Error:', error));
    });
}

document.addEventListener('click', function(e) {
    if (e.target && (e.target.id === 'returnBtn' || e.target.classList.contains('return-btn'))) {
        if (!confirm("정말 반납하시겠습니까?")) return;
        
        const btn = e.target;
        const bookNum = btn.getAttribute('data-bn');
        const p = new URLSearchParams();
        p.append('bookNum', bookNum);

        const currentPath = window.location.pathname;
        let redirectUrl = "/rent/list";

        if (currentPath.includes("/book/detail")) {
            redirectUrl = "/book/list";
        }

        fetch('/rent/delete', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: p
        })
        .then(r => r.json())
        .then(data => {
            handleResponse(data, "반납이 완료되었습니다.", redirectUrl);
        })
        .catch(error => console.error('Error:', error));
    }
});