<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Forest Library</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
    /* 전체적인 카드 및 배너 디자인 디테일 상향 */
    .dashboard-card {
        border: none !important;
        border-radius: 16px !important;
    }
    .service-main-card {
        border: 1px solid #edf2f7 !important;
        border-radius: 20px !important;
        background-color: #ffffff;
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        overflow: hidden;
    }
    .service-main-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(42, 92, 67, 0.08) !important;
        border-color: #2a5c43 !important;
    }
    .icon-circle {
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        transition: transform 0.3s ease;
    }
    .service-main-card:hover .icon-circle {
        transform: scale(1.1);
    }
    .text-gradient {
        background: linear-gradient(135deg, #2a5c43 0%, #438a5e 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
</style>
</head>
<body id="page-top">

	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		
		<div id="content-wrapper" class="d-flex flex-column" style="background: #f8f9fa;">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				
				<div class="container py-5">
				    
				    <!-- [섹션 1] 상단 웰컴 배너 영역 (로그인 상태별 차등) -->
				    <c:choose>
				        <c:when test="${not empty member}">
				            <!-- 로그인 완료 배너 -->
				            <div class="p-5 text-white mb-5 shadow-sm" style="background: linear-gradient(135deg, #2a5c43 0%, #347152 100%); border-radius: 20px;">
				                <h1 class="display-5 font-weight-bold mb-2" style="letter-spacing: -1px;">안녕하세요, ${member.username}님!</h1>
				                <p class="lead opacity-75 mb-0" style="font-size: 1.05rem;">오늘도 책과 함께 마음이 편안해지는 시간을 가져보세요 🍃</p>
				            </div>
				        </c:when>
				        <c:otherwise>
				            <!-- 비로그인 기본 배너 (서비스 중심 유도) -->
				            <div class="p-5 bg-white mb-5 shadow-sm border d-flex flex-column flex-md-row align-items-md-center justify-content-between" style="border-radius: 20px; border-left: 6px solid #2a5c43 !important;">
				                <div class="mb-4 mb-md-0">
				                    <h1 class="h2 font-weight-bold text-gray-900 mb-2" style="letter-spacing: -1px;">숲속 도서관에 오신 것을 환영합니다</h1>
				                    <p class="text-muted mb-0" style="font-size: 1rem;">로그인하시면 도서 대출 현황 조회 및 중고 서적 거래를 편리하게 이용하실 수 있습니다.</p>
				                </div>
				                <div class="d-flex gap-2 shrink-0">
				                    <a href="/member/login" class="btn btn-primary px-4 py-2 font-weight-bold mr-2" style="background-color: #2a5c43; border: none; border-radius: 10px;">로그인</a>
				                    <a href="/member/create" class="btn btn-outline-secondary px-4 py-2 font-weight-bold" style="border-radius: 10px;">회원가입</a>
				                </div>
				            </div>
				        </c:otherwise>
				    </c:choose>

				    <!-- [섹션 2] 핵심 서비스 메인 패널 (언제나 노출되는 핵심 구역) -->
				    <h4 class="font-weight-bold mb-4 text-gray-800" style="letter-spacing: -0.5px;">원하는 서비스를 이용해 보세요</h4>
				    <div class="row mb-5">
				        <!-- 서비스 1: 도서 검색 -->
				        <div class="col-lg-4 col-md-6 mb-4">
				            <div class="card service-main-card h-100 p-4 shadow-sm">
				                <div class="d-flex align-items-center mb-3">
				                    <div class="icon-circle mr-3" style="background-color: #e6fffa; color: #2a5c43;">
				                        <i class="fas fa-search fa-lg"></i>
				                    </div>
				                    <h5 class="font-weight-bold mb-0 text-gray-900">도서 검색 및 대출</h5>
				                </div>
				                <p class="text-muted small flex-grow-1">도서관이 보유한 수많은 장서를 실시간으로 검색하고, 온라인 대출 가능 여부를 확인하세요.</p>
				                <div class="mt-3">
				                    <a href="/book/list" class="btn btn-block text-white font-weight-bold py-2 stretch-link" style="background-color: #2a5c43; border-radius: 10px;">
				                        도서관 둘러보기 <i class="fas fa-arrow-right ml-1 small"></i>
				                    </a>
				                </div>
				            </div>
				        </div>

				        <!-- 서비스 2: 중고 거래 장터 -->
				        <div class="col-lg-4 col-md-6 mb-4">
				            <div class="card service-main-card h-100 p-4 shadow-sm">
				                <div class="d-flex align-items-center mb-3">
				                    <div class="icon-circle mr-3" style="background-color: #f0fff4; color: #38a169;">
				                        <i class="fas fa-comments fa-lg"></i>
				                    </div>
				                    <h5 class="font-weight-bold mb-0 text-gray-900">중고 서적 장터</h5>
				                </div>
				                <p class="text-muted small flex-grow-1">다 읽은 책을 서재에만 두지 말고, 다른 회원들과 자유롭게 공유하거나 합리적인 가격에 거래해 보세요.</p>
				                <div class="mt-3">
				                    <a href="/dealboard/list" class="btn btn-block text-white font-weight-bold py-2 stretch-link" style="background-color: #38a169; border-radius: 10px;">
				                        장터 바로가기 <i class="fas fa-arrow-right ml-1 small"></i>
				                    </a>
				                </div>
				            </div>
				        </div>

				        <!-- 서비스 3: 마이페이지 또는 찜목록 이동 -->
				        <div class="col-lg-4 col-md-6 mb-4">
				            <div class="card service-main-card h-100 p-4 shadow-sm">
				                <div class="d-flex align-items-center mb-3">
				                    <div class="icon-circle mr-3" style="background-color: #fffaf0; color: #dd6b20;">
				                        <i class="fas fa-heart fa-lg"></i>
				                    </div>
				                    <h5 class="font-weight-bold mb-0 text-gray-900">나의 숲 (관심 목록)</h5>
				                </div>
				                <p class="text-muted small flex-grow-1">눈여겨보았던 도서나 나중에 읽고 싶은 책들을 나만의 찜 목록에 담아 체계적으로 관리합니다.</p>
				                <div class="mt-3">
				                    <c:choose>
				                        <c:when test="${not empty member}">
				                            <a href="/wishlist/list" class="btn btn-block text-white font-weight-bold py-2 stretch-link" style="background-color: #dd6b20; border-radius: 10px;">
				                                내 찜 목록 보기 <i class="fas fa-arrow-right ml-1 small"></i>
				                            </a>
				                        </c:when>
				                        <c:otherwise>
				                            <a href="/member/login" class="btn btn-block btn-light text-secondary border font-weight-bold py-2 stretch-link" style="border-radius: 10px;">
				                                로그인 후 이용 가능
				                            </a>
				                        </c:otherwise>
				                    </c:choose>
				                </div>
				            </div>
				        </div>
				    </div>

				    <!-- [섹션 3] 로그인 상태일 때만 열리는 실시간 대출 대시보드 스탯 -->
				    <c:if test="${not empty member}">
				        <h4 class="font-weight-bold mb-4 text-gray-800" style="letter-spacing: -0.5px;">나의 대출 요약 현황</h4>
				        <div class="row">
				            <div class="col-md-4 mb-4">
				                <div class="card dashboard-card p-4 text-center shadow-sm bg-white" style="border-top: 4px solid #2a5c43 !important;">
				                    <div class="text-muted small font-weight-bold text-uppercase mb-2" style="letter-spacing: 0.5px;">현재 대출 중</div>
				                    <div class="display-4 font-weight-bold" style="color: #2a5c43;">${not empty rentCount ? rentCount : 0}</div>
				                    <p class="text-gray-500 small mt-2 mb-0">반납 예정일을 항상 확인하세요.</p>
				                </div>
				            </div>
				            <div class="col-md-4 mb-4">
				                <div class="card dashboard-card p-4 text-center shadow-sm bg-white" style="border-top: 4px solid #e53e3e !important;">
				                    <div class="text-muted small font-weight-bold text-uppercase mb-2" style="letter-spacing: 0.5px;">연체된 도서</div>
				                    <div class="display-4 font-weight-bold text-danger">${not empty lateCount ? lateCount : 0}</div>
				                    <p class="text-gray-500 small mt-2 mb-0">연체 시 대출이 제한될 수 있습니다.</p>
				                </div>
				            </div>
				            <div class="col-md-4 mb-4">
				                <div class="card dashboard-card p-4 text-center shadow-sm bg-white" style="border-top: 4px solid #dd6b20 !important;">
				                    <div class="text-muted small font-weight-bold text-uppercase mb-2" style="letter-spacing: 0.5px;">찜해둔 도서</div>
				                    <div class="display-4 font-weight-bold text-warning">${not empty wishCount ? wishCount : 0}</div>
				                    <p class="text-gray-500 small mt-2 mb-0">관심 목록에 저장된 총 도서 수입니다.</p>
				                </div>
				            </div>
				        </div>
				    </c:if>

				</div>
            </div>
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
	</div>
	
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>