<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>중고 장터 수정 - ${dealboardDTO.oldbookDTO.oldbookTitle}</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .form-label { font-weight: 700; color: #2d3748; font-size: 0.9rem; margin-bottom: 0.5rem; display: block; }
        .form-control-custom { border-radius: 10px; border: 1px solid #e2e8f0; padding: 0.75rem 1rem; transition: all 0.2s; }
        .form-control-custom:focus { border-color: #2a5c43; box-shadow: 0 0 0 3px rgba(42, 92, 67, 0.1); outline: none; }
        .img-preview-container { border: 2px dashed #edf2f7; border-radius: 15px; padding: 20px; text-align: center; background: #f8fafc; }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="d-flex align-items-center mb-4">
                                <a href="./detail?dealboardNum=${dealboardDTO.dealboardNum}" class="btn btn-light rounded-circle mr-3">
                                    <i class="fas fa-arrow-left"></i>
                                </a>
                                <h2 class="h4 mb-0 font-weight-bold text-gray-900">판매글 수정하기</h2>
                            </div>

                            <form action="./update" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="dealboardNum" value="${dealboardDTO.dealboardNum}">
                                <input type="hidden" name="oldbookDTO.oldbookNum" value="${dealboardDTO.oldbookDTO.oldbookNum}">
                                <input type="hidden" name="username" value="${member.username}">

                                <div class="row">
                                    <div class="col-lg-4 mb-4">
                                        <label class="form-label">도서 사진 수정</label>
                                        <div class="img-preview-container mb-3">
                                            <c:choose>
                                                <c:when test="${not empty dealboardDTO.oldbookDTO.oldbookFileDTO.fileName}">
                                                    <img id="preview" src="/files/dealboard/${dealboardDTO.oldbookDTO.oldbookFileDTO.fileName}" class="img-fluid rounded shadow-sm" style="max-height: 250px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img id="preview" src="" class="img-fluid rounded shadow-sm d-none" style="max-height: 250px;">
                                                    <div id="no-img-text" class="text-muted small py-5">새 사진을 등록해주세요.</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" name="attach" id="attach" onchange="readURL(this);">
                                            <label class="custom-file-label" for="attach">파일 선택</label>
                                        </div>
                                        <small class="text-muted mt-2 d-block">* 사진 수정 시 기존 사진은 삭제됩니다.</small>
                                    </div>

                                    <div class="col-lg-8">
                                        <div class="card border-0 shadow-sm p-4 mb-4" style="border-radius: 15px;">
                                            <div class="form-group mb-4">
                                                <label class="form-label" for="dealboardTitle">게시글 제목</label>
                                                <input type="text" class="form-control form-control-custom" id="dealboardTitle" name="dealboardTitle" value="${dealboardDTO.dealboardTitle}" required>
                                            </div>

                                            <div class="form-group mb-4">
                                                <label class="form-label" for="dealboardContents">상세 설명</label>
                                                <textarea class="form-control form-control-custom" id="dealboardContents" name="dealboardContents" rows="6" style="resize: none;" required>${dealboardDTO.dealboardContents}</textarea>
                                            </div>

                                            <hr class="my-4">
                                            <h5 class="font-weight-bold text-dark mb-4"><i class="fas fa-book mr-2 text-primary"></i>도서 상세 정보 수정</h5>

                                            <div class="row">
                                                <div class="col-md-8 form-group mb-3">
                                                    <label class="form-label" for="oldbookTitle">책 제목</label>
                                                    <input type="text" class="form-control form-control-custom" id="oldbookTitle" name="oldbookDTO.oldbookTitle" value="${dealboardDTO.oldbookDTO.oldbookTitle}" required>
                                                </div>
                                                <div class="col-md-4 form-group mb-3">
                                                    <label class="form-label" for="oldbookPrice">판매 가격 (원)</label>
                                                    <input type="number" class="form-control form-control-custom" id="oldbookPrice" name="oldbookDTO.oldbookPrice" value="${dealboardDTO.oldbookDTO.oldbookPrice}" required>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 form-group mb-3">
                                                    <label class="form-label" for="oldbookAuthor">저자</label>
                                                    <input type="text" class="form-control form-control-custom" id="oldbookAuthor" name="oldbookDTO.oldbookAuthor" value="${dealboardDTO.oldbookDTO.oldbookAuthor}" required>
                                                </div>
                                                <div class="col-md-6 form-group mb-3">
                                                    <label class="form-label" for="oldbookPublisher">출판사</label>
                                                    <input type="text" class="form-control form-control-custom" id="oldbookPublisher" name="oldbookDTO.oldbookPublisher" value="${dealboardDTO.oldbookDTO.oldbookPublisher}" required>
                                                </div>
                                            </div>

                                            <div class="form-group mb-0">
                                                <label class="form-label" for="oldbookDate">출판일</label>
                                                <input type="date" class="form-control form-control-custom" id="oldbookDate" name="oldbookDTO.oldbookDate" value="${dealboardDTO.oldbookDTO.oldbookDate}" required>
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-end">
                                            <button type="reset" class="btn btn-light px-4 py-2 font-weight-bold mr-2" style="border-radius:10px;">초기화</button>
                                            <button type="submit" class="btn btn-primary px-5 py-2 font-weight-bold" style="border-radius:10px; background-color: #2a5c43; border: none;">수정 완료</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
        </div>
    </div>

    <script>
        // 이미지 미리보기 스크립트
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#preview').attr('src', e.target.result).removeClass('d-none');
                    $('#no-img-text').addClass('d-none');
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 파일 선택 시 파일명 표시
        $(".custom-file-input").on("change", function() {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>
    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>