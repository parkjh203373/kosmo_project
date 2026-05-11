document.addEventListener('DOMContentLoaded', function() {
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

    if (bookContents) {
        $(bookContents).summernote({
            height: 150,
            placeholder: '도서 검색 시 자동으로 채워집니다.'
        });
    }

    if (apiSearchBtn) {
        apiSearchBtn.addEventListener('click', function() {
            const query = apiSearchInput.value;
            if (!query) {
                alert("검색어를 입력하세요.");
                return;
            }

            const params = new URLSearchParams({ query: query });
            
            fetch(`/book/api/bookSearch?${params.toString()}`, {
                method: 'GET'
            })
            .then(response => {
                if (!response.ok) throw new Error('네트워크 응답에 문제가 발생했습니다.');
                return response.text();
            })
            .then(data => {
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

                searchResultDiv.innerHTML = html;
                searchResultDiv.style.display = 'block';
                searchResultDiv.style.visibility = 'visible';
                searchResultDiv.style.opacity = '1';
            })
            .catch(error => {
                console.error('Error:', error);
                alert("도서 검색 중 오류가 발생했습니다.");
            });
        });
    }

    document.addEventListener('click', function(e) {
        const target = e.target.closest('.select-book');
        
        if (target) {
            const d = target.dataset;

            bookTitleInput.value = d.title;
            bookAuthorInput.value = d.author;
            bookPublisherInput.value = d.pub;
            bookDateInput.value = d.date;
            bookImageInput.value = d.image;

            if (d.image && d.image !== "undefined" && d.image !== "") {
                bookImagePreview.src = d.image;
                bookImagePreview.style.display = 'block';
                noImgText.style.setProperty('display', 'none', 'important');
            } else {
                bookImagePreview.style.display = 'none';
                noImgText.style.display = 'block';
            }

            $(bookContents).summernote('code', d.desc);

            searchResultDiv.style.display = 'none';
            apiSearchInput.value = "";
        }
    });

    if (apiSearchInput) {
        apiSearchInput.focus();
    }
});