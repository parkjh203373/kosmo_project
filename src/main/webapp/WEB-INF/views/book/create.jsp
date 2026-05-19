<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 등록 입고 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <style>
    	.card.position-relative {
	        position: relative !important;
	        z-index: 10 !important;
	    }
	    
	    #searchResult {
	        position: absolute !important;
	        z-index: 1050 !important;
	        background: white !important;
	        border-radius: 12px;
	        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
	        width: 94%;
	    }
	    .select-book {
	        cursor: pointer;
	        transition: background 0.2s;
	        border: 0 !important;
	        border-bottom: 1px solid #f1f5f9 !important;
	    }
	    .select-book:hover {
	        background-color: #f7fafc !important;
	    }
	    .note-editor {
	    	border-radius: 12px !important;
	    	border: 1px solid #e2e8f0 !important;
	    	overflow: hidden;
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
                    <h1 class="h4 mb-4 text-gray-900 font-weight-bold">신규 도서 입고 시스템</h1>
                    
                    <div class="row justify-content-center">
                        <div class="col-xl-10 col-lg-12">
                        
                        	<!-- 네이버 도서 검색 카드 -->
                            <div class="card p-3 mb-4 bg-white border-0 position-relative">
                                <div class="card-body">
                                    <label class="font-weight-bold text-primary mb-2"><i class="fas fa-network-wired mr-1"></i> 네이버 도서 데이터베이스 검색 매핑</label>
                                    <div class="input-group">
                                        <input type="text" id="apiSearch" class="form-control border-0 bg-light pl-3" placeholder="도서 제목 키워드를 기입해주세요.">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary px-4" type="button" id="apiSearchBtn">
                                                <i class="fas fa-search mr-1"></i> 조회
                                            </button>
                                        </div>
                                    </div>
                                    <!-- 실시간 조작 검색 리스트 레이어 드롭다운형태화 -->
                                    <div id="searchResult" class="list-group mt-2" style="max-height: 300px; overflow-y: auto; display: none;"></div>
                                </div>
                            </div>

                            <!-- 등록 최종 폼 카드 -->
                            <div class="card border-0 bg-white p-4">
							    <div class="card-body">
							        <form action="./create" method="post" id="frm">
							            <div class="row">
							                <!-- 커버 이미지 프리뷰 세션 부드러운 그레이 백그라운딩화 -->
							                <div class="col-md-4 text-center pr-md-4 border-right">
							                    <label class="font-weight-bold text-secondary small text-uppercase">서적 연동 이미지</label>
							                    <div id="imagePreview" class="mt-2 mb-3 d-flex align-items-center justify-content-center" style="min-height: 250px;">
							                        <img src="" id="bookImageImg" class="rounded shadow-md" style="max-height: 250px; width: 160px; object-fit: cover; display: none;">
							                        <div id="noImgText" class="bg-light rounded-lg w-100 d-flex align-items-center justify-content-center text-muted small" style="height: 230px; border: 2px dashed #e2e8f0;">데이터 연동 대기중</div>
							                    </div>
							                    <input type="hidden" name="bookImage" id="bookImage">
							                </div>
							                
							                <!-- 서적 상세 주입 필드 (읽기전용 매핑) -->
							                <div class="col-md-8 pl-md-4">
							                    <div class="form-group mb-3">
							                        <label class="font-weight-bold small text-dark" for="bookTitle">연동된 도서 제목</label>
							                        <input type="text" name="bookTitle" id="bookTitle" class="form-control bg-light border-0 font-weight-bold text-dark" readonly required placeholder="조회 매핑 시 자동 주입되는 영역입니다.">
							                    </div>
							                    <div class="row">
							                        <div class="form-group col-md-6 mb-3">
							                            <label class="font-weight-bold small text-dark" for="bookAuthor">저자</label>
							                            <input type="text" name="bookAuthor" id="bookAuthor" class="form-control bg-light border-0" readonly>
							                        </div>
							                        <div class="form-group col-md-6 mb-3">
							                            <label class="font-weight-bold small text-dark" for="bookPublisher">출판사</label>
							                            <input type="text" name="bookPublisher" id="bookPublisher" class="form-control bg-light border-0" readonly>
							                        </div>
							                    </div>
							                    <div class="row">
							                        <div class="form-group col-md-6 mb-3">
							                            <label class="font-weight-bold small text-dark" for="bookDate">발행일</label>
							                            <input type="text" name="bookDate" id="bookDate" class="form-control bg-light border-0" readonly>
							                        </div>
							                        <div class="form-group col-md-6 mb-3">
							                            <label class="font-weight-bold small text-dark" for="bookStatus">대출 상태</label>
							                            <select name="bookStatus" class="form-control border-0 bg-light text-secondary font-weight-medium" style="padding-top: 0; padding-bottom: 0;">
							                                <option value="대출가능">🟢 대출 가능 상태</option>
							                                <option value="대출중">🔴 대출 중인 상태</option>
							                            </select>
							                        </div>
							                    </div>
							                </div>
							            </div>
							
							            <div class="form-group mt-4">
							                <label class="font-weight-bold small text-dark" for="bookContents">서적 요약 설명 및 본문 소개</label>
							                <textarea name="bookContents" id="bookContents" class="form-control"></textarea>
							            </div>
							
							            <div class="text-right mt-4 pt-2">
							                <a href="./list" class="btn btn-link text-muted font-weight-bold text-decoration-none mr-2">돌아가기</a>
							                <button type="submit" class="btn btn-primary px-5 shadow-sm font-weight-bold" id="submitBtn">도서 신규 등록</button>
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