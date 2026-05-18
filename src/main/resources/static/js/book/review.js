const createBtn = document.getElementById("create");
const reviewListDiv = document.getElementById("review_list");
const reviewAddBtn = document.getElementById("review_add");
const reviewContentsInput = document.getElementById("review_contents");
const updateSaveBtn = document.getElementById("update_save");
const wishBtnArea = document.getElementById("wishBtnArea");

if (wishBtnArea) {
    wishBtnArea.addEventListener("click", (e) => {
        
        // 1. [찜하기] 버튼을 눌렀을 때
        const createBtn = e.target.closest("#create");
        if (createBtn) {
            let pn = createBtn.getAttribute("data-pn");
            let p = new URLSearchParams();
            p.append('bookNum', pn);

            fetch("/wishlist/create", { method: "POST", body: p })
                .then(r => r.text())
                .then(r => {
                    if (r.trim() > 0) {
                        if (confirm("찜 목록에 등록되었습니다. 이동하시겠습니까?")) {
                            location.href = "/wishlist/list";
                        } else {
                            // 페이지 이동 안 하면 그 자리에서 바로 '관심도서 해제' 버튼으로 UI 전환
                            wishBtnArea.insertAdjacentHTML('afterbegin', `
                                <button type="button" class="btn btn-link text-danger text-decoration-none small" id="deleteWishBtn" data-bn="${pn}">
                                    <i class="fas fa-heart-broken mr-1"></i> 관심도서 해제
                                </button>
                            `);
                            createBtn.remove(); // 기존 찜하기 버튼 제거
                        }
                    } else {
                        alert("로그인이 필요한 서비스입니다.");
                        location.href = "/member/login";
                    }
                })
                .catch(err => console.error("찜하기 실패:", err));
            return;
        }

        // 2. [관심도서 해제] 버튼을 눌렀을 때 (비동기 삭제 요청)
        const deleteWishBtn = e.target.closest("#deleteWishBtn");
        if (deleteWishBtn) {
            if (!confirm('관심 도서목록에서 제외할까요?')) return;
            
            let bn = deleteWishBtn.getAttribute("data-bn");
            let p = new URLSearchParams();
            p.append('bookNum', bn);

            fetch("/wishlist/delete", { method: "POST", body: p })
                .then(r => {
                    alert("관심도서 목록에서 제외되었습니다.");
                    // 성공 시 그 자리에서 바로 '찜하기' 버튼으로 UI 전환
                    wishBtnArea.insertAdjacentHTML('afterbegin', `
                        <button type="button" class="btn btn-light border btn-sm text-secondary px-3 py-2" id="create" data-pn="${bn}">
                            <i class="far fa-heart text-danger mr-1"></i> 찜하기
                        </button>
                    `);
                    deleteWishBtn.remove(); // 기존 해제 버튼 제거
                })
                .catch(err => console.error("찜해제 실패:", err));
            return;
        }
    });
}

if (reviewAddBtn) {
    reviewAddBtn.addEventListener("click", () => {
        let contents = reviewContentsInput.value;
        let bookNum = document.getElementById("book_num_data").value;
        let rating = document.getElementById("review_rating").value;

        if (contents.trim() == "") {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        let p = new URLSearchParams();
        p.append('bookNum', bookNum);
        p.append('reviewContents', contents);
        p.append('reviewRating', rating);

        fetch("../review/add", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: p
        })
        .then(d => d.text())
        .then(d => {
            if (d.trim() > 0) {
                alert("댓글이 등록되었습니다.");
                reviewContentsInput.value = "";
                getList();
            } else {
                alert("로그인이 필요한 서비스입니다.");
                location.href = "../member/login";
            }
        });
    });
}

if (reviewListDiv) {
    reviewListDiv.addEventListener("click", (e) => {
        if (e.target.classList.contains("review_del")) {
            if (!confirm("해당 댓글을 삭제하시겠습니까?")) return;
            let reviewNum = e.target.getAttribute("data-num");
            let p = new URLSearchParams();
            p.append("reviewNum", reviewNum);
            fetch("../review/delete", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: p
            })
            .then(r => r.text())
            .then(r => {
                if (r.trim() > 0) { alert("삭제되었습니다."); getList(); }
            });
        }
        
        if (e.target.classList.contains("review_update")) {
            const reviewNum = e.target.getAttribute("data-num");
            const oldRating = e.target.getAttribute("data-rating");
            const oldContents = e.target.getAttribute("data-contents");
            document.getElementById("contents_update").value = oldContents;
            document.getElementById("rating_update").value = oldRating;
            updateSaveBtn.setAttribute("data-num", reviewNum);
        }
    });
}

if (updateSaveBtn) {
    updateSaveBtn.addEventListener("click", () => {
        const reviewNum = updateSaveBtn.getAttribute("data-num");
        const newContents = document.getElementById("contents_update").value;
        const newRating = document.getElementById("rating_update").value;
        
        let p = new URLSearchParams();
        p.append('reviewNum', reviewNum);
        p.append('reviewContents', newContents);
        p.append('reviewRating', newRating);

        fetch("../review/update", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: p
        })
        .then(r => r.text())
        .then(r => {
            if (r.trim() > 0) {
                alert("댓글 수정이 완료되었습니다.");
                $('#review_modal').modal('hide');
                getList();
            }
        });
    });
}

function getList() {
    const dataInput = document.getElementById("book_num_data");
    if (!dataInput) return;
    
    fetch("../review/list?bookNum=" + dataInput.value)
        .then(d => d.text())
        .then(d => {
            if (reviewListDiv) reviewListDiv.innerHTML = d;
        })
        .catch(err => console.error("리뷰 로드 실패:", err));
}

getList();