<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고책 판매 등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container { max-width: 800px; margin: 50px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        .section-title { border-left: 5px solid #0d6efd; padding-left: 10px; margin-bottom: 20px; font-weight: bold; }
    </style>
</head>
<body class="bg-light">

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-5">📖 중고책 판매 글쓰기</h2>

        <form action="./create" method="post" enctype="multipart/form-data">
            
            <!-- [SECTION 1] 게시글 정보 (DealboardDTO) -->
            <div class="section-title">게시글 정보</div>
            <div class="mb-3">
                <label for="dealboardTitle" class="form-label">게시글 제목</label>
                <input type="text" class="form-control" name="dealboardTitle" id="dealboardTitle" placeholder="판매글 제목을 입력하세요" required>
            </div>
            <div class="mb-4">
                <label for="dealboardContents" class="form-label">상세 설명</label>
                <textarea class="form-control" name="dealboardContents" id="dealboardContents" rows="5" placeholder="책의 상태나 직거래 장소 등 상세 내용을 적어주세요"></textarea>
            </div>

            <!-- [SECTION 2] 중고책 상세 정보 (OldbookDTO) -->
            <div class="section-title">중고책 상세 정보</div>
            <div class="row">
                <div class="col-md-8 mb-3">
                    <label for="oldbookTitle" class="form-label">도서명</label>
                    <input type="text" class="form-control" name="oldbookTitle" id="oldbookTitle" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="oldbookPrice" class="form-label">판매 가격</label>
                    <input type="number" class="form-control" name="oldbookPrice" id="oldbookPrice" placeholder="원" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="oldbookAuthor" class="form-label">저자</label>
                    <input type="text" class="form-control" name="oldbookAuthor" id="oldbookAuthor">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="oldbookPublisher" class="form-label">출판사</label>
                    <input type="text" class="form-control" name="oldbookPublisher" id="oldbookPublisher">
                </div>
            </div>

            <div class="mb-4">
                <label for="oldbookDate" class="form-label">출판일</label>
                <input type="date" class="form-control" name="oldbookDate" id="oldbookDate">
            </div>

            <!-- [SECTION 3] 파일 첨부 (OldbookFileDTO) -->
            <div class="section-title">책 사진 첨부</div>
            <div class="mb-5">
                <label for="attach" class="form-label">상품 이미지 (최대한 깨끗하게 찍어주세요!)</label>
                <input type="file" class="form-control" name="attach" id="attach">
            </div>

            <!-- 버튼 영역 -->
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">판매 등록하기</button>
                <a href="./list" class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>