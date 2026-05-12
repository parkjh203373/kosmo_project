<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 정보 수정</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">도서 정보 수정</h1>
                    
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">도서 상세 정보 수정</h6>
                                </div>
                                <div class="card-body">
                                    <form action="./update" method="post" enctype="multipart/form-data" id="frm">
                                        <!-- 수정 및 페이징 유지를 위한 Hidden 필드 -->
                                        <input type="hidden" name="bookNum" value="${d.bookNum}">
                                        <input type="hidden" name="page" value="${pager.page}">
                                        <input type="hidden" name="kind" value="${pager.kind}">
                                        <input type="hidden" name="search" value="${pager.search}">
                                        <input type="hidden" name="bookImage" value="${d.bookImage}">

                                        <div class="row">
                                            <!-- 왼쪽: 이미지 섹션 -->
                                            <div class="col-md-4 text-center border-right">
                                                <label class="font-weight-bold">도서 표지</label>
                                                <div id="imagePreview" class="mt-2 mb-3">
                                                    <c:choose>
                                                        <c:when test="${not empty d.bookImage}">
                                                            <img src="${d.bookImage}" id="bookImageImg" class="img-fluid rounded shadow" style="max-height: 250px;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div id="noImgText" class="bg-light rounded d-flex align-items-center justify-content-center" style="height: 200px; color:#ccc;">이미지 없음</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="form-group text-left">
                                                    <label class="small">이미지 변경 (선택)</label>
                                                    <input type="file" name="attach" class="form-control-file small">
                                                </div>
                                            </div>
                                            
                                            <!-- 오른쪽: 기본 정보 섹션 -->
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <label for="bookTitle">도서 제목</label>
                                                    <input type="text" name="bookTitle" id="bookTitle" class="form-control" value="${d.bookTitle}" required>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="bookAuthor">저자</label>
                                                        <input type="text" name="bookAuthor" id="bookAuthor" class="form-control" value="${d.bookAuthor}">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="bookPublisher">출판사</label>
                                                        <input type="text" name="bookPublisher" id="bookPublisher" class="form-control" value="${d.bookPublisher}">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="bookDate">출판일</label>
                                                        <input type="date" name="bookDate" id="bookDate" class="form-control" value="${d.bookDate}">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="bookStatus">대출 상태</label>
                                                        <select name="bookStatus" id="bookStatus" class="form-control">
                                                            <option value="대출가능" ${d.bookStatus eq '대출가능' ? 'selected' : ''}>대출 가능</option>
                                                            <option value="대출중" ${d.bookStatus eq '대출중' ? 'selected' : ''}>대출 중</option>
                                                            <option value="DNL" ${d.bookStatus eq 'DNL' ? 'selected' : ''}>파손, 분실 등</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 하단: 도서 소개 (Summernote) -->
                                        <div class="form-group mt-3">
                                            <label for="bookContents">도서 소개</label>
                                            <textarea name="bookContents" id="bookContents" class="form-control">${d.bookContents}</textarea>
                                        </div>

                                        <!-- 버튼 영역 -->
                                        <div class="text-right mt-4">
                                            <a href="./detail?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}" class="btn btn-secondary mr-2">취소</a>
                                            <button type="button" class="btn btn-primary px-5" id="btn">정보 수정</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
        </div>
    </div>

    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#bookContents').summernote({
                placeholder: '도서 소개를 입력하세요.',
                tabsize: 2,
                height: 200
            });
        });
    </script>
    <script src="/js/book/update.js"></script>
</body>
</html>