const createBtn = document.getElementById("create");
const reviewListDiv = document.getElementById("review_list");
const reviewAddBtn = document.getElementById("review_add");
const reviewContentsInput = document.getElementById("review_contents");
const updateSaveBtn = document.getElementById("update_save");

if (createBtn) {
    createBtn.addEventListener("click", () => {
        let pn = createBtn.getAttribute("data-pn");
        let p = new URLSearchParams();
        p.append('bookNum', pn);
        fetch("/wishlist/create", { method: "POST", body: p })
            .then(r => r.text())
            .then(r => {
                if (r.trim() > 0) {
                    if (confirm("찜 목록으로 이동하시겠습니까?")) location.href = "/wishlist/list";
                } else {
                    alert("로그인이 필요한 서비스입니다.");
                    location.href = "/member/login";
                }
            });
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