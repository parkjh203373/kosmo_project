<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forest Library</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
</head>
<body>

	<div id="wrapper">
		<!-- 빈 사이드바 임포트 -->
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		
		<div id="content-wrapper" class="d-flex flex-column" style="background: #f8f9fa;">
			<div id="content">
				<!-- 신규 상단 탑바 임포트 -->
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				
				<!-- 메인 본문 컨테이너 -->
				<div class="container py-5">
				    <c:choose>
				        <%-- [1] 로그인 상태 - 대시보드 화면 --%>
				        <c:when test="${not empty member}">
				            <!-- 감성 웰컴 배너 -->
				            <div class="p-5 rounded-lg text-white mb-5 shadow-sm" style="background: linear-gradient(135deg, #2a5c43 0%, #438a5e 100%); border-radius: 20px;">
				                <h1 class="display-5 font-weight-bold mb-2">안녕하세요, ${member.username}님!</h1>
				                <p class="lead opacity-75 mb-0">오늘도 책과 함께 마음이 편안해지는 시간을 가져보세요 🍃</p>
				            </div>
				
				            <!-- 통합 요약 보드 -->
				            <div class="row mb-5">
				                <div class="col-md-4 mb-4 mb-md-0">
				                    <div class="card p-4 text-center">
				                        <div class="text-muted small font-weight-bold text-uppercase mb-2">현재 대출 중</div>
				                        <div class="display-4 font-weight-bold text-primary">${not empty rentCount ? rentCount : 0}</div>
				                        <p class="text-gray-500 small mt-2 mb-0">반납 예정일을 확인하세요.</p>
				                    </div>
				                </div>
				                <div class="col-md-4 mb-4 mb-md-0">
				                    <div class="card p-4 text-center border-bottom-danger">
				                        <div class="text-muted small font-weight-bold text-uppercase mb-2">연체된 도서</div>
				                        <div class="display-4 font-weight-bold text-danger">${not empty lateCount ? lateCount : 0}</div>
				                        <p class="text-gray-500 small mt-2 mb-0">빠른 반납을 부탁드립니다.</p>
				                    </div>
				                </div>
				                <div class="col-md-4">
				                    <div class="card p-4 text-center">
				                        <div class="text-muted small font-weight-bold text-uppercase mb-2">찜해둔 도서</div>
				                        <div class="display-4 font-weight-bold text-warning">${not empty wishCount ? wishCount : 0}</div>
				                        <p class="text-gray-500 small mt-2 mb-0">관심 목록에 저장된 도서입니다.</p>
				                    </div>
				                </div>
				            </div>
				
				            <!-- 서비스 퀵 바로가기 -->
				            <h4 class="font-weight-bold mb-4" style="color: #2d3748;">원하는 서비스를 선택하세요</h4>
				            <div class="row">
				                <div class="col-md-6 mb-4">
				                    <div class="card h-100 p-4 d-flex flex-row align-items-center">
				                        <div class="rounded-circle bg-light p-4 text-primary mr-4">
				                            <i class="fas fa-search fa-2x"></i>
				                        </div>
				                        <div>
				                            <h5 class="font-weight-bold mb-1"><a href="/book/list" class="text-dark text-decoration-none stretch-link">도서 검색 및 대출하기</a></h5>
				                            <p class="text-muted small mb-0">도서관의 수많은 장서를 검색하고 온라인 대출을 신청합니다.</p>
				                        </div>
				                    </div>
				                </div>
				                <div class="col-md-6 mb-4">
				                    <div class="card h-100 p-4 d-flex flex-row align-items-center">
				                        <div class="rounded-circle bg-light p-4 text-success mr-4">
				                            <i class="fas fa-comments fa-2x"></i>
				                        </div>
				                        <div>
				                            <h5 class="font-weight-bold mb-1"><a href="/dealboard/list" class="text-dark text-decoration-none stretch-link">중고 서적 장터 거래</a></h5>
				                            <p class="text-muted small mb-0">다 읽은 책을 회원들과 공유하거나 중고로 자유롭게 거래하세요.</p>
				                        </div>
				                    </div>
				                </div>
				            </div>
				        </c:when>
				
				        <%-- [2] 비로그인 상태 - 미니멀 로그인 유도 카드 --%>
				        <c:otherwise>
				            <div class="row justify-content-center align-items-center" style="min-height: 65vh;">
				                <div class="col-md-5 text-center">
				                    <div class="card p-5 shadow-lg border-0 bg-white" style="border-radius: 24px !important;">
				                        <div class="mb-4">
				                            <span class="d-inline-block bg-light p-4 rounded-circle mb-3">
				                                <i class="fas fa-book-reader text-primary fa-3x"></i>
				                            </span>
				                            <h2 class="font-weight-bold text-gray-900 mb-2">Forest Library</h2>
				                            <p class="text-muted small">지식과 감성이 숨쉬는 공간<br>도서 대출 및 중고 거래 시스템에 오신 것을 환영합니다.</p>
				                        </div>
				                        
				                        <div class="d-grid gap-3 mt-4">
				                            <a href="/member/login" class="btn btn-primary btn-block py-3 font-weight-bold shadow-sm mb-3">
				                                <i class="fas fa-sign-in-alt mr-2"></i> 로그인
				                            </a>
				                            <a href="/member/create" class="btn btn-light btn-block py-3 font-weight-bold border text-secondary">
				                                <i class="fas fa-user-plus mr-2"></i> 신규 회원가입
				                            </a>
				                        </div>
				                    </div>
				                </div>
				            </div>
				        </c:otherwise>
				    </c:choose>
				</div>
                <!-- end container -->
			</div>
			<!-- end content -->
			
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
	</div>
	
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>