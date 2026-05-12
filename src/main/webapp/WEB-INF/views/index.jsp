<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
</head>
<body id="page-top">
	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				<div class="container-fluid">
				    <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 60vh;">
				        
				        <c:choose>
				            <c:when test="${not empty member}">
				                <div class="text-center">
				                    <h1 class="display-4 font-weight-bold text-primary mb-4">환영합니다, ${member.username}님!</h1>
				                    <hr class="my-4">
				                    <a href="/book/list" class="btn btn-success btn-lg shadow">도서 목록 보기</a>
				                    <a href="/dealboard/list" class="btn btn-success btn-lg shadow">중고 도서 거래</a>
				                </div>
				            </c:when>
				
				            <%-- 2. 비로그인 상태 (로그인/회원가입 버튼) --%>
				            <c:otherwise>
				                <div class="text-center shadow-lg p-5 bg-white rounded" style="max-width: 500px; width: 100%;">
				                    <h1 class="h3 mb-4 text-gray-800 font-weight-bold">도서 관리 시스템</h1>
				                    
				                    <div class="d-grid gap-3">
				                        <a href="/member/login" class="btn btn-primary btn-block btn-lg shadow-sm mb-3">
				                            <i class="fas fa-sign-in-alt"></i> 로그인
				                        </a>
				                        <a href="/member/create" class="btn btn-outline-info btn-block btn-lg shadow-sm">
				                            <i class="fas fa-user-plus"></i> 회원가입
				                        </a>
				                    </div>
				                </div>
				            </c:otherwise>
				        </c:choose>
				        
				    </div>
				</div>
                <!-- end container-fluid -->
			</div>
			<!-- end content -->
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
		<!-- end content-wrapper -->
	</div>
	<!-- end wrapper -->
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>