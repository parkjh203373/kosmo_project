<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>중고 장터 상세 - ${dealboardDTO.oldbookDTO.oldbookTitle}</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .market-meta-label { color: #718096; font-weight: 500; width: 120px; display: inline-block; }
        .market-meta-value { color: #1a202c; font-weight: 400; }
        .market-divider { border-bottom: 1px solid #edf2f7; padding: 14px 0; }
        .payment-box { background: #fffdf2; border: 1px solid #fef3c7; border-radius: 16px; padding: 24px; }
        /* JS 바인딩 전용 hidden 레이아웃 설정 */
        .js-binding-hidden { display: none !important; }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-4">
                    <div class="row">
                        <div class="col-lg-5 text-center mb-4">
                            <div class="card bg-white border-0 p-4 sticky-top shadow-sm" style="top: 100px;">
                                <c:choose>
                                    <c:when test="${not empty dealboardDTO.oldbookDTO.oldbookFileDTO.fileName}">
                                        <img src="/files/dealboard/${dealboardDTO.oldbookDTO.oldbookFileDTO.fileName}" class="img-fluid rounded-lg shadow-md mx-auto" style="max-height: 450px; object-fit: cover;" alt="도서 이미지">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="bg-light d-flex align-items-center justify-content-center rounded-lg text-muted" style="height: 380px; border: 2px dashed #edf2f7;">
                                            <div class="text-center"><i class="fas fa-image fa-3x opacity-25 mb-2"></i><div class="small">등록된 사진이 없습니다.</div></div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="col-lg-7">
                            <div class="card bg-white border-0 p-4 mb-4">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge px-3 py-2 text-primary font-weight-bold small shadow-sm" style="background:#e6fffa; border-radius:30px;">● 판매 진행중</span>
                                        <span class="text-muted small">판매자 ID: <strong class="text-dark">${dealboardDTO.username}</strong></span>
                                    </div>
                                    
                                    <h2 class="font-weight-bold text-gray-950 mb-3" style="font-size: 1.6rem;">${dealboardDTO.dealboardTitle}</h2>
                                    
                                    <div class="bg-light p-3 rounded-lg text-secondary mb-4" style="white-space: pre-wrap; line-height: 1.7; font-size: 0.95rem; min-height: 120px;">${dealboardDTO.dealboardContents}</div>
                                    
                                    <h5 class="font-weight-bold text-dark mt-4 mb-2"><i class="fas fa-info-circle text-gray-400 mr-2"></i>도서 상세 정보</h5>
                                    <div class="market-divider d-flex">
                                        <span class="market-meta-label">도서 제목</span>
                                        <span class="market-meta-value font-weight-bold">${dealboardDTO.oldbookDTO.oldbookTitle}</span>
                                    </div>
                                    <div class="market-divider d-flex">
                                        <span class="market-meta-label">저자</span>
                                        <span class="market-meta-value">${dealboardDTO.oldbookDTO.oldbookAuthor}</span>
                                    </div>
                                    <div class="market-divider d-flex">
                                        <span class="market-meta-label">출판사 / 발행일</span>
                                        <span class="market-meta-value">${dealboardDTO.oldbookDTO.oldbookPublisher} <span class="text-gray-300 mx-2">|</span> ${dealboardDTO.oldbookDTO.oldbookDate}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="payment-box mb-4 shadow-sm">
                                <form action="/pay/ready" method="post" id="payForm">
                                    
                                    <input type="hidden" id="dealboardNum" value="${dealboardDTO.dealboardNum}">
                                    <div class="js-binding-hidden">
                                        <span id="pName">${dealboardDTO.oldbookDTO.oldbookTitle}</span>
                                        <span id="pPrice">${dealboardDTO.oldbookDTO.oldbookPrice}</span>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <div>
                                            <span class="small text-muted d-block">거래 희망 가격</span>
                                            <span class="h3 font-weight-bold text-gray-900 mb-0">
                                                <fmt:formatNumber value="${dealboardDTO.oldbookDTO.oldbookPrice}" pattern="#,###"/>
                                            </span><span class="font-weight-bold text-dark ml-1">원</span>
                                        </div>
                                        <c:if test="${member.username ne dealboardDTO.username}">
	                                        <div>
		                                        <button type="button" id="btn-pay-ready" class="btn font-weight-bold text-dark px-4 py-2 shadow-sm d-flex align-items-center" style="background:#fee500; border-radius:12px; height:46px;">
		                                            <i class="fas fa-comment mr-2" style="color:#3c1e1e;"></i> 카카오페이 결제
		                                        </button>
	                                        </div>
                                        </c:if>
                                    </div>
                                </form>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <a href="./list" class="btn btn-outline-secondary px-4 py-2 font-weight-bold" style="border-radius:10px;"><i class="fas fa-arrow-left mr-2"></i> 목록으로</a>
                                
                                <c:if test="${member.username eq dealboardDTO.username}">
                                    <div>
                                        <a href="./update?dealboardNum=${dealboardDTO.dealboardNum}" class="btn btn-sm btn-warning font-weight-bold px-3 py-2 mr-1" style="border-radius:8px;">수정</a>
                                        <a href="./delete?dealboardNum=${dealboardDTO.dealboardNum}" class="btn btn-sm btn-danger font-weight-bold px-3 py-2" style="border-radius:8px;" onclick="return confirm('이 거래글을 장터에서 완전히 내릴까요?')">삭제</a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="/js/pay/pay.js"></script>
    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>