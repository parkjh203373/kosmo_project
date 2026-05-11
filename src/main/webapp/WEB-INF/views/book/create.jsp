<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 등록</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <style>
	    #searchResult {
	        position: relative !important;
	        z-index: 1050 !important;
	        background: white !important;
	    }
	    .select-book {
	        cursor: pointer;
	    }
	    .select-book:hover {
	        background-color: #f8f9fc !important;
	    }
	</style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">새 도서 등록</h1>
                    
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="card border-left-info shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-info">네이버 도서 검색 (먼저 검색하여 선택하세요)</h6>
                                </div>
                                <div class="card-body">
                                    <div class="input-group">
                                        <input type="text" id="apiSearch" class="form-control bg-light border-0 small" placeholder="검색할 도서 제목을 입력하세요...">
                                        <div class="input-group-append">
                                            <button class="btn btn-info" type="button" id="apiSearchBtn">
                                                <i class="fas fa-search fa-sm"></i> 검색
                                            </button>
                                        </div>
                                    </div>
                                    <div id="searchResult" class="list-group mt-3" style="max-height: 350px; overflow-y: auto; display: none;">
                                    </div>
                                </div>
                            </div>

                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form action="./create" method="post" id="frm">
                                        <div class="row">
                                            <div class="col-md-4 text-center border-right">
                                                <label class="font-weight-bold">도서 표지</label>
                                                <div id="imagePreview" class="mt-2 mb-3">
                                                    <img src="" id="bookImageImg" class="img-fluid rounded shadow" style="max-height: 250px; display: none;">
                                                    <div id="noImgText" class="bg-light rounded d-flex align-items-center justify-content-center" style="height: 200px; color:#ccc;">이미지 없음</div>
                                                </div>
                                                <input type="hidden" name="bookImage" id="bookImage">
                                            </div>
                                            
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <label for="bookTitle">도서 제목</label>
                                                    <input type="text" name="bookTitle" id="bookTitle" class="form-control" readonly required placeholder="검색을 통해 자동 입력됩니다.">
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="bookAuthor">저자</label>
                                                        <input type="text" name="bookAuthor" id="bookAuthor" class="form-control" readonly>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="bookPublisher">출판사</label>
                                                        <input type="text" name="bookPublisher" id="bookPublisher" class="form-control" readonly>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="bookDate">출판일</label>
                                                        <input type="text" name="bookDate" id="bookDate" class="form-control" readonly>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="bookStatus">초기 상태</label>
                                                        <select name="bookStatus" class="form-control">
                                                            <option value="대출가능">대출 가능</option>
                                                            <option value="대출중">대출 중</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group mt-3">
                                            <label for="bookContents">도서 소개</label>
                                            <textarea name="bookContents" id="bookContents" class="form-control"></textarea>
                                        </div>

                                        <div class="text-right mt-4">
                                            <a href="./list" class="btn btn-secondary mr-2">취소</a>
                                            <button type="submit" class="btn btn-primary px-5">도서 등록</button>
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
    
    <script src="/js/book/create.js"></script>
</body>
</html>