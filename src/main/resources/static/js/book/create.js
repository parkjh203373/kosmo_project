$(document).ready(function() {
    // Summernote 초기화
    $('#bookContents').summernote({
        height: 150,
        placeholder: '도서 검색 시 자동으로 채워집니다.'
    });

    // 네이버 API 검색 버튼 클릭
    $('#apiSearchBtn').click(function() {
        const query = $('#apiSearch').val();
        if (!query) {
            alert("검색어를 입력하세요.");
            return;
        }

        $.ajax({
            url: "/book/api/bookSearch", // 본인의 API 대행 컨트롤러 경로
            type: "GET",
            data: { query: query },
            success: function(data) {
                console.log("받은 데이터:", data);
                const items = JSON.parse(data).items;
                let html = "";

                if (items.length === 0) {
                    html = "<div class='list-group-item'>검색 결과가 없습니다.</div>";
                } else {
                    $.each(items, function(index, item) {
                        // 1. 태그 제거 및 특수문자 안전 처리 (정규식 사용)
                        let title = item.title.replace(/<[^>]*>?/gm, '').replace(/'/g, "").replace(/"/g, "");
                        let author = item.author.replace(/<[^>]*>?/gm, '').replace(/'/g, "").replace(/"/g, "");
                        let publisher = item.publisher.replace(/'/g, "").replace(/"/g, "");

                        // 2. 설명글(Description)에서 줄바꿈과 따옴표를 완전히 제거 (가장 위험한 요소)
                        let desc = "";
                        if (item.description) {
                            desc = item.description.replace(/\r?\n|\r/g, " ").replace(/'/g, "").replace(/"/g, "");
                        }

                        // 3. 백틱 대신 안전한 문자열 연결 방식 사용
                        html += '<a href="javascript:void(0)" class="list-group-item list-group-item-action d-flex align-items-center select-book" ' +
                            'data-title="' + title + '" ' +
                            'data-author="' + author + '" ' +
                            'data-image="' + item.image + '" ' +
                            'data-pub="' + publisher + '" ' +
                            'data-date="' + item.pubdate + '" ' +
                            'data-desc="' + desc + '">' +
                            '<img src="' + item.image + '" style="width:50px; height:70px; object-fit:cover; min-width:50px;" class="mr-3 shadow-sm border">' +
                            '<div>' +
                            '<div class="font-weight-bold text-dark" style="font-size:1rem; margin-bottom:2px;">' + title + '</div>' +
                            '<small class="text-muted">' + author + ' | ' + publisher + '</small>' +
                            '</div>' +
                            '</a>';
                    });
                }

                // 4. 화면 표시 로직 강화
                $('#searchResult').html(html).css({
                    'display': 'block',
                    'visibility': 'visible',
                    'opacity': '1'
                }).show();
            }
        });
    });

    // 검색 리스트에서 도서 선택 시
    $(document).on('click', '.select-book', function() {
        const d = $(this).data();

        $('#bookTitle').val(d.title);
        $('#bookAuthor').val(d.author);
        $('#bookPublisher').val(d.pub);
        $('#bookDate').val(d.date);
        $('#bookImage').val(d.image);

        if (d.image) {
            $('#bookImageImg').attr('src', d.image).show();
            $('#noImgText').attr('style', 'display: none !important;');
        } else {
            $('#bookImageImg').hide();
            $('#noImgText').show();
        }

        // Summernote에 설명 넣기
        $('#bookContents').summernote('code', d.desc);

        $('#searchResult').slideUp();
        $('#apiSearch').val("");
    });
});