document.addEventListener('DOMContentLoaded', function() {
    // 1. 요소 선택 (Vanilla JS)
    const bookContents = document.getElementById('bookContents');
    const apiSearchInput = document.getElementById('apiSearch');
    const apiSearchBtn = document.getElementById('apiSearchBtn');
    const searchResultDiv = document.getElementById('searchResult');
    
    const bookTitleInput = document.getElementById('bookTitle');
    const bookAuthorInput = document.getElementById('bookAuthor');
    const bookPublisherInput = document.getElementById('bookPublisher');
    const bookDateInput = document.getElementById('bookDate');
    const bookImageInput = document.getElementById('bookImage');
    const bookImagePreview = document.getElementById('bookImageImg');
    const noImgText = document.getElementById('noImgText');

    // 2. Summernote 초기화 (플러그인 명령 실행을 위해 $ 사용)
    if (bookContents) {
        $(bookContents).summernote({
            height: 150,
            placeholder: '도서 검색 시 자동으로 채워집니다.'
        });
    }

    // 3. 네이버 API 검색 버튼 클릭 이벤트 (EventListener 사용)
    apiSearchBtn.addEventListener('click', function() {
        const query = apiSearchInput.value;
        if (!query) {
            alert("검색어를 입력하세요.");
            return;
        }

        // 통신은 기존 $.ajax 유지 (원하시면 fetch로 변경 가능)
        $.ajax({
            url: "/book/api/bookSearch",
            type: "GET",
            data: { query: query },
            success: function(data) {
                const items = JSON.parse(data).items;
                let html = "";

                if (items.length === 0) {
                    html = "<div class='list-group-item'>검색 결과가 없습니다.</div>";
                } else {
                    items.forEach(item => {
                        let title = item.title.replace(/<[^>]*>?/gm, '').replace(/'/g, "").replace(/"/g, "");
                        let author = item.author.replace(/<[^>]*>?/gm, '').replace(/'/g, "").replace(/"/g, "");
                        let publisher = item.publisher.replace(/'/g, "").replace(/"/g, "");
                        let desc = item.description ? item.description.replace(/\r?\n|\r/g, " ").replace(/'/g, "").replace(/"/g, "") : "";

                        // 데이터 속성을 활용한 HTML 구성
                        html += `
                            <a href="javascript:void(0)" class="list-group-item list-group-item-action d-flex align-items-center select-book" 
                                data-title="${title}" 
                                data-author="${author}" 
                                data-image="${item.image}" 
                                data-pub="${publisher}"
                                data-date="${item.pubdate}"
                                data-desc="${desc}">
                                <img src="${item.image}" style="width:50px; height:70px; object-fit:cover; min-width:50px;" class="mr-3 shadow-sm border">
                                <div>
                                    <div class="font-weight-bold text-dark" style="font-size:1rem; margin-bottom:2px;">${title}</div>
                                    <small class="text-muted">${author} | ${publisher}</small>
                                </div>
                            </a>`;
                    });
                }

                // innerHTML로 결과 렌더링 및 스타일 제어
                searchResultDiv.innerHTML = html;
                searchResultDiv.style.display = 'block';
                searchResultDiv.style.visibility = 'visible';
                searchResultDiv.style.opacity = '1';
            }
        });
    });

    // 4. 검색 리스트에서 도서 선택 (이벤트 위임 방식)
    document.addEventListener('click', function(e) {
        // 클릭된 요소가 .select-book 클래스를 가지고 있거나 그 자식인지 확인
        const target = e.target.closest('.select-book');
        
        if (target) {
            // Vanilla JS의 dataset 객체로 데이터 가져오기
            const d = target.dataset;

            bookTitleInput.value = d.title;
            bookAuthorInput.value = d.author;
            bookPublisherInput.value = d.pub;
            bookDateInput.value = d.date;
            bookImageInput.value = d.image;

            if (d.image && d.image !== "undefined") {
                bookImagePreview.src = d.image;
                bookImagePreview.style.display = 'block';
                noImgText.style.setProperty('display', 'none', 'important');
            } else {
                bookImagePreview.style.display = 'none';
                noImgText.style.display = 'block';
            }

            // Summernote에 내용 삽입 (jQuery 문법 필수)
            $(bookContents).summernote('code', d.desc);

            // 결과창 숨기기 및 입력창 초기화
            searchResultDiv.style.display = 'none';
            apiSearchInput.value = "";
        }
    });
});

window.onload = function() {
    document.getElementById('apiSearch').focus();
};