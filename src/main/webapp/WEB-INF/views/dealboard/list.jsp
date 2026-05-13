<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고책 거래 장터</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-img-top { height: 250px; object-fit: cover; background-color: #f8f9fa; }
        .book-condition { position: absolute; top: 10px; right: 10px; z-index: 10; }
        .card { transition: transform 0.2s; }
        .card:hover { transform: translateY(-5px); }
    </style>
</head>
<body class="bg-light">

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📗 중고책 거래 게시판</h2>
        <a href="./create" class="btn btn-primary shadow-sm">판매 글쓰기</a>
        <a href="/member/login" class="btn btn-primary shadow-sm">로그인</a>
    </div>

    <!-- 검색 바 -->
    <div class="row mb-4">
        <div class="col-md-6 mx-auto">
            <form action="./list" method="get" class="input-group shadow-sm">
                <input type="text" name="search" class="form-control" placeholder="도서명 또는 저자 검색" value="${param.search}">
                <button class="btn btn-dark" type="submit">검색</button>
            </form>
        </div>
    </div>

    <!-- 중고 도서 목록 시작 -->
    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        
        <c:forEach items="${list}" var="dto">
            <div class="col">
                <div class="card h-100 shadow-sm border-0 position-relative">
                    
                    <!-- [상태 표시] 필요 시 OldbookDTO에 상태 필드를 추가하여 연동하세요 -->
                    <span class="badge bg-success book-condition">판매중</span>

                    <!-- [이미지 처리] 파일이 있으면 해당 경로, 없으면 기본 이미지 -->
                    <c:choose>
                        <c:when test="${not empty dto.oldbookDTO.oldbookFileDTO.fileName}">
                            <img src="/files/dealboard/${dto.oldbookDTO.oldbookFileDTO.fileName}" class="card-img-top" alt="도서 이미지">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/no_image.png" class="card-img-top" alt="이미지 없음">
                        </c:otherwise>
                    </c:choose>

                    <div class="card-body">
                        <!-- 게시글 제목보다는 책 제목을 메인으로 보여주는 것이 좋습니다 -->
                        <h5 class="card-title text-truncate" title="${dto.oldbookDTO.oldbookTitle}">
                            ${dto.oldbookDTO.oldbookTitle}
                        </h5>
                        <p class="card-text text-muted small mb-1">저자: ${dto.oldbookDTO.oldbookAuthor}</p>
                        <p class="card-text text-muted small">판매자 아이디: ${dto.username}</p>
                        
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <!-- 금액 포맷팅 (3자리 콤마) -->
                            <strong class="text-primary fs-5">
                                <fmt:formatNumber value="${dto.oldbookDTO.oldbookPrice}" pattern="#,###"/>원
                            </strong>
                        </div>
                    </div>

                    <div class="card-footer bg-transparent border-top-0 pb-3">
                        <a href="./detail?dealboardNum=${dto.dealboardNum}" class="btn btn-sm btn-outline-secondary w-100">상세보기</a>
                    </div>
                </div>
            </div>		
		</c:forEach>
        </div>
		<div class="d-flex justify-content-center mt-5">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<!-- 이전 버튼 -->
					<li class="page-item ${pager.pre ? '' : 'disabled'}"><a
						class="page-link"
						href="./list?page=${pager.start - 1}&search=${pager.search}">Previous</a>
					</li>

					<!-- 페이지 번호 -->
					<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
						<li class="page-item ${pager.page == i ? 'active' : ''}"><a
							class="page-link" href="./list?page=${i}&search=${pager.search}">${i}</a></li>
					</c:forEach>

					<!-- 다음 버튼 -->
					<li class="page-item ${pager.next ? '' : 'disabled'}"><a
						class="page-link"
						href="./list?page=${pager.end + 1}&search=${pager.search}">Next</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>

</body>
</html>