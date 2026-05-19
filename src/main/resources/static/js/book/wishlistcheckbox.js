const checkAll = document.getElementById("checkAll");
const checkboxes = document.querySelectorAll(".wish-checkbox");
const deleteSelectedBtn = document.getElementById("deleteSelectedBtn");
const deleteAllBtn = document.getElementById("deleteAllBtn");

if(checkAll) {
	checkAll.addEventListener("change", function(){
		checkboxes.forEach(cb => {
			cb.checked = checkAll.checked
		})
	})
}

checkboxes.forEach(cb => {
	cb.addEventListener("change", function(){
		const checkedCount = document.querySelectorAll(".wish-checkbox:checked").length
		if(checkAll) {
			checkAll.checked = (checkedCount === checkboxes.length)
		}
	})
})

if(deleteSelectedBtn) {
	deleteSelectedBtn.addEventListener("click", function(){
		const checkedBoxes = document.querySelectorAll(".wish-checkbox:checked")
		
		if(checkedBoxes.length === 0) {
			alert("삭제할 도서를 선택해주세요.")
			return
		}
		
		if(!confirm("선택한 " + checkedBoxes.length + "개의 도서를 관심 목록에서 삭제하시겠습니까?")) {
			return
		}
		
		const bookNums = Array.from(checkedBoxes).map(cb => cb.value)
		
		deleteWishlistItems(bookNums);
	})
}

if (deleteAllBtn) {
    deleteAllBtn.addEventListener("click", function() {
        if (checkboxes.length === 0) {
            alert("삭제할 도서가 없습니다.");
            return;
        }

        if (!confirm("관심 목록에 있는 모든 도서를 삭제하시겠습니까?")) {
            return;
        }

        // 화면에 있는 모든 체크박스의 value(bookNum)를 배열로 추출
        const bookNums = Array.from(checkboxes).map(cb => cb.value);

        // Fetch 삭제 함수 호출
        deleteWishlistItems(bookNums);
    });
}

function deleteWishlistItems(bookNums) {
    // 현재 Controller가 한 번에 하나의 bookNum만 처리하므로, 배열 내 모든 bookNum에 대해 각각 fetch 요청을 만듭니다.
    const requests = bookNums.map(bookNum => {
        return fetch("/wishlist/delete", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded" // Controller가 DTO로 바인딩할 수 있도록 content-type 설정
            },
            body: "bookNum=" + encodeURIComponent(bookNum) // 쿼리스트링 형태로 데이터 전달
        });
    });

    // Promise.all을 사용해 모든 fetch 요청이 끝날 때까지 기다립니다.
    Promise.all(requests)
        .then(responses => {
            // 정상적으로 모든 처리가 끝났다면 알림 후 새로고침
            alert("삭제가 완료되었습니다.");
            location.reload(); // 페이지가 새로고침되면서 Controller가 세션 카운트 및 페이징을 재계산합니다.
        })
        .catch(error => {
            console.error("Fetch 에러 발생:", error);
            alert("삭제 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
        })
}
