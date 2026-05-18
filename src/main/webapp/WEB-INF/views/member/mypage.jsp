<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>마이 페이지 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .profile-avatar {
            width: 110px;
            height: 110px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }
        .info-label { color: #718096; font-weight: 600; font-size: 0.85rem; text-uppercase: true; display: block; margin-bottom: 4px;}
        .info-value-box { background-color: #f8fafc; padding: 12px 16px; border-radius: 12px; font-weight: 500; color: #1a202c; font-size: 0.95rem; }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-4">
                    <h1 class="h4 mb-4 text-gray-900 font-weight-bold">마이 페이지</h1>
                    
                    <div class="row">
                        <div class="col-lg-4 mb-4">
                            <div class="card border-0 bg-white text-center p-4 shadow-sm" style="border-radius: 16px;">
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${not empty member.profileDTO.fileName}">
                                            <img src="/files/member/${member.profileDTO.fileName}" class="profile-avatar mb-3" alt="프로필">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="profile-avatar bg-light mx-auto mb-3 d-flex align-items-center justify-content-center text-muted"><i class="fas fa-user fa-2x"></i></div>
                                        </c:otherwise>
                                    </c:choose>
                                    <h5 class="font-weight-bold text-gray-900 mb-1">${member.memberName}</h5>
                                    <span class="badge px-3 py-1 text-primary small font-weight-bold" style="background:#e6fffa; border-radius:20px;">일반 회원</span>
                                    
                                    <hr class="my-4" style="border-top-style: dashed;">

									<div class="d-flex flex-column gap-2 text-center">
										<a href="./update" class="btn font-weight-bold mb-2 shadow-sm"
											style="border-radius: 10px; padding: 12px 0; background-color: #2a5c43; color: white; border: none;">회원 정보 수정</a> 
										<a href="./logout"
											class="btn btn-outline-light font-weight-bold text-secondary mb-2"
											style="border-radius: 10px; padding: 10px 0; border: 1px solid #dee2e6; background-color: #f8f9fa;">로그아웃</a> 
										<a href="./delete?username=${member.username}"
											class="text-danger mt-3 small"
											style="text-decoration: underline; font-size: 0.85rem; opacity: 0.8;"
											onclick="return confirm('정말 라이브러리를 탈퇴하시겠습니까? 데이터가 소멸됩니다.')">회원 탈퇴하기</a>
									</div>
								</div>
                            </div>
                        </div>

                        <div class="col-lg-8">
                            <div class="card border-0 bg-white p-4 shadow-sm" style="border-radius: 16px;">
                                <div class="card-body">
                                    <h5 class="font-weight-bold text-dark mb-4"><i class="fas fa-id-card text-gray-400 mr-2"></i>회원 상세 정보</h5>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <span class="info-label">ID</span>
                                            <div class="info-value-box">${member.username}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <span class="info-label">이름</span>
                                            <div class="info-value-box">${member.memberName}</div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <span class="info-label">생년월일</span>
                                            <div class="info-value-box">${member.memberBirth}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <span class="info-label">이메일 주소</span>
                                            <div class="info-value-box">${member.memberEmail}</div>
                                        </div>
                                    </div>
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
</body>
</html>