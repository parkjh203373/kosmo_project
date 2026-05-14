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
                        <div class="col-md-4 mb-3 text-center animate__animated animate__fadeIn">
                            <a href="./detail?bookNum=${book.bookNum}">
                                <img src="${book.bookImage}" class="shadow-sm rounded mb-2" 
                                     style="height: 220px; width: 150px; object-fit: cover;" 
                                     onerror="this.src='/img/no-image.png'">
                            </a>
                            <div class="small font-weight-bold text-truncate">${book.bookTitle}</div>
                            <div class="text-xs text-muted">${book.bookAuthor}</div>
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