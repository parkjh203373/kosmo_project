<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고책 상세 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container { max-width: 800px; margin: 50px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        .section-title { border-left: 5px solid #0d6efd; padding-left: 10px; margin-bottom: 20px; font-weight: bold; }
        .img-container { text-align: center; margin-bottom: 20px; }
        .img-container img { max-width: 100%; height: auto; border-radius: 5px; }
    </style>
</head>
<body class="bg-light">

<div class="container">
    <div class="form-container shadow">
        <h2 class="text-center mb-5">📖 중고책 상세 정보</h2>

        <!-- 상세 정보는 보통 form보다는 div 구조로 보여주지만, 기존 스타일 유지를 위해 readonly input 사용 -->
        <div class="mb-3">
            <label class="form-label fw-bold">게시글 제목</label>
            <input type="text" class="form-control bg-white" value="${dealboardDTO.dealboardTitle}" readonly>
        </div>
        
        <div class="mb-4">
            <label class="form-label fw-bold">상세 설명</label>
            <!-- textarea는 value 속성 대신 태그 사이에 값을 넣습니다 -->
            <textarea class="form-control bg-white" rows="5" readonly>${dealboardDTO.dealboardContents}</textarea>
        </div>

        <div class="section-title">중고책 상세 정보</div>
        
        <!-- 이미지 출력 부분 -->
        <div class="img-container">
            <c:if test="${not empty dealboardDTO.oldbookDTO.oldbookFileDTO.fileName}">
                <img src="/files/dealboard/${dealboardDTO.oldbookDTO.oldbookFileDTO.fileName}" alt="도서 이미지">
            </c:if>
        </div>

        <div class="row">
            <div class="col-md-8 mb-3">
                <label class="form-label">도서명</label>
                <input type="text" class="form-control bg-white" value="${dealboardDTO.oldbookDTO.oldbookTitle}" readonly>
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">판매 가격</label>
                <input type="text" class="form-control bg-white" value="${dealboardDTO.oldbookDTO.oldbookPrice} 원" readonly>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">저자</label>
                <input type="text" class="form-control bg-white" value="${dealboardDTO.oldbookDTO.oldbookAuthor}" readonly>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">출판사</label>
                <input type="text" class="form-control bg-white" value="${dealboardDTO.oldbookDTO.oldbookPublisher}" readonly>
            </div>
        </div>

        <div class="mb-5">
            <label class="form-label">출판일</label>
            <input type="text" class="form-control bg-white" value="${dealboardDTO.oldbookDTO.oldbookDate}" readonly>
        </div>

        <div class="d-grid gap-2">
            <button type="button" class="btn btn-primary btn-lg">구매문의 하기</button>
            <a href="./list" class="btn btn-outline-secondary">목록으로</a>
            
            <!-- 작성자 본인일 경우 수정/삭제 버튼을 보여주는 로직을 추가하면 좋습니다 -->
            <c:if test="${member.username eq dealboardDTO.username}">
                <div class="mt-2 text-end">
                    <a href="./update?dealboardNum=${dealboardDTO.dealboardNum}" class="btn btn-sm btn-warning">수정</a>
                    <a href="./delete?dealboardNum=${dealboardDTO.dealboardNum}" class="btn btn-sm btn-danger">삭제</a>
                </div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>