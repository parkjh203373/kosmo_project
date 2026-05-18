document.addEventListener("DOMContentLoaded", function() {
    loadAgeBest(20);

    const ageSelector = document.getElementById("ageSelector");
    if (ageSelector) {
        ageSelector.addEventListener("change", function() {
            const age = this.value;
            loadAgeBest(age);
        });
    }

    function loadAgeBest(age) {
        fetch(`./ageBest?ageGroup=${age}`, {
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("네트워크 응답에 문제가 발생했습니다.");
                }
                return response.json();
            })
            .then(data => {
                const resultArea = document.getElementById("ageBestResult");
                let html = "";

                if (data && data.length > 0) {
                    data.forEach(book => {
                        html += `
						<div class="col-4 mb-3 text-center d-flex flex-column align-items-center animate__animated animate__fadeIn">
							<div class="position-relative mb-2 shadow rounded-lg overflow-hidden" style="height: 200px; width: 140px; min-width: 140px;">
						    	<a href="./detail?bookNum=${book.bookNum}" class="d-block h-100 w-100">
						        	<img src="${book.bookImage}" class="h-100 w-100" 
						            	style="object-fit: cover;" 
						                onerror="this.src='/img/no-image.png'" alt="도서 이미지">
						        </a>
						    </div>
						    <div class="w-100 px-1 text-center" style="height: 42px;">
						    	<div class="small font-weight-bold text-gray-800 text-truncate mb-0" title="${book.bookTitle}">
						        	${book.bookTitle}
						        </div>
						        <div class="text-xs text-muted text-truncate mt-0.5">
						            ${book.bookAuthor}
						        </div>
						    </div>
						</div>
                    `;
                    });
                } else {
                    html = "<div class='col-12 text-center py-5 text-muted small'>해당 연령대의 대출 데이터가 없습니다.</div>";
                }

                resultArea.innerHTML = html;
            })
            .catch(error => {
                console.error("Error:", error);
                alert("연령대별 데이터를 가져오는 데 실패했습니다.");
            });
    }
});