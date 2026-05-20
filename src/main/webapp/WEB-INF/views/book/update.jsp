<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>도서 정보 수정 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <style>
        .note-editor {
            border-radius: 12px !important;
            border: 1px solid #e2e8f0 !important;
            overflow: hidden;
        }
        .form-control:focus {
            background-color: #fff !important;
            border-color: #2a5c43 !important;
            box-shadow: 0 0 0 0.2rem rgba(42, 92, 67, 0.15) !important;
        }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-4">
                    <h1 class="h4 mb-4 text-gray-900 font-weight-bold">도서 정보 수정</h1>
                    
                    <div class="row justify-content-center">
                        <div class="col-xl-10 col-lg-12">
                            <div class="card border-0 bg-white p-4">
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
                                            <div class="col-md-4 text-center pr-md-4 border-right">
                                                <label class="font-weight-bold text-secondary small text-uppercase mb-3">도서 현재 표지</label>
                                                <div id="imagePreview" class="mb-4 d-flex align-items-center justify-content-center" style="min-height: 250px;">
                                                    <c:choose>
                                                        <c:when test="${not empty d.bookImage}">
                                                            <img src="${d.bookImage}" id="bookImageImg" class="rounded shadow-md" style="max-height: 250px; width: 160px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div id="noImgText" class="bg-light rounded-lg w-100 d-flex align-items-center justify-content-center text-muted small" style="height: 230px; border: 2px dashed #e2e8f0;">등록된 이미지 없음</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="form-group text-left bg-light p-3 rounded-lg">
                                                    <label class="font-weight-bold small text-dark mb-1"><i class="fas fa-image mr-1 text-primary"></i> 표지 이미지 교체</label>
                                                    <input type="file" name="attach" class="form-control-file small text-secondary mt-1">
                                                </div>
                                            </div>
                                            
                                            <!-- 오른쪽: 기본 정보 입력 폼 섹션 -->
                                            <div class="col-md-8 pl-md-4">
                                                <div class="form-group mb-3">
                                                    <label class="font-weight-bold small text-dark" for="bookTitle">도서 제목</label>
                                                    <input type="text" name="bookTitle" id="bookTitle" class="form-control border-0 bg-light px-3" value="${d.bookTitle}" required placeholder="수정할 도서 명칭을 입력하세요.">
                                                </div>
                                                
                                                <div class="row">
                                                    <div class="form-group col-md-6 mb-3">
                                                        <label class="font-weight-bold small text-dark" for="bookAuthor">저자</label>
                                                        <input type="text" name="bookAuthor" id="bookAuthor" class="form-control border-0 bg-light px-3" value="${d.bookAuthor}" placeholder="저자 이름을 입력하세요.">
                                                    </div>
                                                    <div class="form-group col-md-6 mb-3">
                                                        <label class="font-weight-bold small text-dark" for="bookPublisher">출판사</label>
                                                        <input type="text" name="bookPublisher" id="bookPublisher" class="form-control border-0 bg-light px-3" value="${d.bookPublisher}" placeholder="출판사명을 입력하세요.">
                                                    </div>
                                                </div>
                                                
                                                <div class="row">
                                                    <div class="form-group col-md-6 mb-3">
                                                        <label class="font-weight-bold small text-dark" for="bookDate">출간일</label>
                                                        <input type="date" name="bookDate" id="bookDate" class="form-control border-0 bg-light px-3" value="${d.bookDate}">
                                                    </div>
                                                    <div class="form-group col-md-6 mb-3">
                                                        <label class="font-weight-bold small text-dark" for="bookStatus">현재 대출 상태</label>
                                                        <select name="bookStatus" id="bookStatus" class="form-control border-0 bg-light text-secondary font-weight-medium" style="padding-top: 0; padding-bottom: 0;">
                                                            <option value="대출가능" ${d.bookStatus eq '대출가능' ? 'selected' : ''}>🟢 대출 가능</option>
                                                            <option value="대출중" ${d.bookStatus eq '대출중' ? 'selected' : ''}>🔴 대출 중</option>
                                                            <option value="DNL" ${d.bookStatus eq 'DNL' ? 'selected' : ''}>⚙️ 파손, 분실 등</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 하단: 도서 소개 서머노트 -->
                                        <div class="form-group mt-4">
                                            <label class="font-weight-bold small text-dark" for="bookContents">도서 요약 및 소개글</label>
                                            <textarea name="bookContents" id="bookContents" class="form-control">${d.bookContents}</textarea>
                                        </div>

                                        <!-- 버튼 제어 구역 -->
                                        <div class="text-right mt-4 pt-2">
                                            <a href="./detail?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}" class="btn btn-link text-muted font-weight-bold text-decoration-none mr-2">변경 취소</a>
                                            <button type="button" class="btn btn-primary px-5 font-weight-bold shadow-sm" id="btn">도서 정보 수정</button>
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
                placeholder: '도서에 대한 감성적인 요약 소개글을 입력해 보세요.',
                tabsize: 2,
                height: 250,
                callbacks: {
                    onInit: function() {
                        // 서머노트 에디터 내부의 툴바 및 스타일을 테마와 어울리게 미세 조정
                        $('.note-toolbar').css({
                            'background-color': '#f8fafc',
                            'border-bottom': '1px solid #e2e8f0'
                        });
                    }
                }
            });
        });
    </script>
    <script src="/js/book/update.js"></script>
</body>
</html>