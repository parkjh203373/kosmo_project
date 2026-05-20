<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>중고책 판매 등록 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        .form-control:focus, .form-select:focus {
            background-color: #fff !important;
            border-color: #2a5c43 !important;
            box-shadow: 0 0 0 0.2rem rgba(42, 92, 67, 0.15) !important;
        }
        .market-section-title {
            font-size: 1rem;
            font-weight: 700;
            color: #2a5c43;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #edf2f7;
        }
        .fixed-height-input {
            height: calc(2.25rem + 10px);
            font-size: 0.95rem;
        }
        .modern-date-input {
	        appearance: none;
	        -webkit-appearance: none;
	        color: #4a5568;
	        border: 0 !important;
	        background-color: #f8fafc !important; /* 다른 입력창과 배경 통일 */
	        border-radius: 12px !important;
	        padding: 10px 15px !important;
	        cursor: pointer;
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
                    <h1 class="h4 mb-4 text-gray-900 font-weight-bold">중고 도서 등록하기</h1>
                    
                    <div class="row justify-content-center">
                        <div class="col-xl-9 col-lg-12">
                            <div class="card border-0 bg-white p-4">
                                <div class="card-body">
                                    <form action="./create" method="post" enctype="multipart/form-data">
                                        
                                        <div class="market-section-title"><i class="fas fa-pen-fancy mr-1"></i> 장터 게시글 기본 정보</div>
                                        <div class="form-group mb-3">
                                            <label for="dealboardTitle" class="font-weight-bold small text-dark">글 제목</label>
                                            <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="dealboardTitle" id="dealboardTitle" placeholder="다른 독자의 눈길을 끌 만한 제목을 입력하세요." required>
                                        </div>
                                        <div class="form-group mb-4">
                                            <label for="dealboardContents" class="font-weight-bold small text-dark">상세 설명</label>
                                            <textarea class="form-control border-0 bg-light p-3" name="dealboardContents" id="dealboardContents" rows="5" placeholder="책의 보존 상태(낙서, 얼룩 정도)나 희망하는 직거래 위치 등 공유할 정보를 적어주세요." style="resize: none; border-radius: 12px;"></textarea>
                                        </div>

                                        <div class="market-section-title"><i class="fas fa-book-open mr-1"></i>도서 상세 정보</div>
                                        <div class="row">
                                            <div class="form-group col-md-8 mb-3">
                                                <label for="oldbookTitle" class="font-weight-bold small text-dark">정식 도서명</label>
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="oldbookTitle" id="oldbookTitle" placeholder="책 제목" required>
                                            </div>
                                            <div class="form-group col-md-4 mb-3">
                                                <label for="oldbookPrice" class="font-weight-bold small text-dark">책정 가격</label>
                                                <div class="input-group">
                                                    <input type="number" 
                                                    	min="0"
                                                     	class="form-control border-0 bg-light px-3 fixed-height-input" name="oldbookPrice" id="oldbookPrice" placeholder="원 단위 숫지만 입력" required>
                                                    <div class="input-group-append">
                                                        <span class="input-group-text border-0 bg-light font-weight-bold text-secondary">원</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="form-group col-md-6 mb-3">
                                                <label for="oldbookAuthor" class="font-weight-bold small text-dark">원본 저자</label>
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="oldbookAuthor" id="oldbookAuthor" placeholder="지은이 이름">
                                            </div>
                                            <div class="form-group col-md-6 mb-3">
                                                <label for="oldbookPublisher" class="font-weight-bold small text-dark">발행 출판사</label>
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="oldbookPublisher" id="oldbookPublisher" placeholder="출판사명">
                                            </div>
                                        </div>

                                        <div class="form-group mb-4">
                                            <label for="oldbookDate" class="font-weight-bold small text-dark">인쇄/출간 시점</label>
                                            <input type="date" class="form-control modern-date-input fixed-height-input" name="oldbookDate" id="oldbookDate">
                                        </div>

                                        <div class="market-section-title"><i class="fas fa-camera mr-1"></i> 상품 실물 증명 사진</div>
                                        <div class="form-group mb-5 p-3 bg-light rounded-lg" style="border: 2px dashed #cbd5e0;">
                                            <label for="attach" class="font-weight-bold small text-secondary">정면, 뒤표지 등 도서 보존 상태 판별이 쉬운 이미지를 업로드해 주세요.</label>
                                            <input type="file" class="form-control-file text-muted mt-2" name="attach" id="attach">
                                        </div>

										<div class="form-group mb-3">
											<label class="font-weight-bold small text-dark d-block">도서	보존 상태</label>
											<div class="d-flex gap-3 mt-2">
												<div
													class="custom-control custom-radio custom-control-inline">
													<input type="radio" id="stateNew" name="oldbookState" class="custom-control-input" value="새상품" checked>
													<label class="custom-control-label small font-weight-bold text-secondary" for="stateNew">새상품</label>
												</div>
												<div class="custom-control custom-radio custom-control-inline">
													<input type="radio" id="stateUsed" name="oldbookState" class="custom-control-input" value="중고"> 
													<label class="custom-control-label small font-weight-bold text-secondary" for="stateUsed">중고 (사용감 있음)</label>
												</div>
											</div>
										</div>

										<div class="text-right pt-2">
                                            <button type="button" class="btn btn-link text-muted font-weight-bold text-decoration-none mr-2" data-toggle="modal" data-target="#cancelModal">
											    취소하고 돌아가기
											</button>
                                            <button type="submit" class="btn btn-primary px-5 font-weight-bold shadow-sm fixed-height-input" style="border-radius:10px; line-height:22px;">글 작성 완료</button>
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
    
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
	<!-- 취소 모달 -->
	<div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="cancelModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content border-0 shadow">
	            <div class="modal-header bg-light">
	                <h5 class="modal-title font-weight-bold text-dark" id="cancelModalLabel">작성 취소</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body py-4 text-center">
	                <i class="fas fa-exclamation-triangle text-warning fa-2x mb-3"></i>
	                <p class="mb-0 font-weight-bold text-secondary">지금 취소하시면 입력하신 모든 내용이 사라집니다.<br>정말 판매 등록을 취소하시겠습니까?</p>
	            </div>
	            <div class="modal-footer border-0 bg-light">
	                <button type="button" class="btn btn-secondary font-weight-bold" data-dismiss="modal">계속 작성하기</button>
	                <a href="./list" class="btn btn-danger font-weight-bold px-4">작성 취소</a>
	            </div>
	        </div>
	    </div>
	</div>

	<!-- 에러 알림 모달 -->
	<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content border-0 shadow">
	            <div class="modal-header bg-danger text-white">
	                <h5 class="modal-title font-weight-bold" id="errorModalLabel">입력 오류</h5>
	                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body py-4 text-center">
	                <i class="fas fa-exclamation-circle text-danger fa-2x mb-3"></i>
	                <!-- 컨트롤러에서 보낸 에러메시지가 여기 출력됩니다 -->
	                <p class="mb-0 font-weight-bold text-dark">${errorMessage}</p>
	            </div>
	            <input type="hidden" id="serverErrorMessage" value="${errorMessage}">
	            
	            <div class="modal-footer border-0 bg-light">
	                <button type="button" class="btn btn-secondary font-weight-bold px-4" data-dismiss="modal">확인</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	<script src="/js/dealboard/create.js"></script>
</body>
</html>