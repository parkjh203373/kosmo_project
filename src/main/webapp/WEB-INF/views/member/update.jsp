<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>정보 수정 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .form-control:focus {
            background-color: #fff !important;
            border-color: #2a5c43 !important;
            box-shadow: 0 0 0 0.2rem rgba(42, 92, 67, 0.15) !important;
        }
        .fixed-height-input {
            height: calc(2.25rem + 10px);
            font-size: 0.95rem;
        }
    </style>
</head>
<body id="page-top" class="bg-light">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-4">
                    <h1 class="h4 mb-4 text-gray-900 font-weight-bold">회원 정보 수정</h1>
                    
                    <div class="row justify-content-center">
                        <div class="col-xl-9 col-lg-12">
                            <div class="card border-0 bg-white p-4 shadow-sm" style="border-radius: 16px;">
                                <div class="card-body">
                                    <form action="/member/update" method="post" enctype="multipart/form-data">
                                        
                                        <div class="row">
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="font-weight-bold small text-dark" for="username">회원 계정 ID</label> 
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input text-muted" name="username" id="username" value="${member.username}" readonly style="cursor: not-allowed;"> 
                                            </div>
                                            
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="font-weight-bold small text-dark" for="password">비밀번호 변경</label> 
                                                <input type="password" class="form-control border-0 bg-light px-3 fixed-height-input" name="password" id="password" value="${member.password}" placeholder="새 비밀번호 혹은 기존 비밀번호 확인" required>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="font-weight-bold small text-dark" for="memberName">회원 이름</label> 
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="memberName" id="memberName" value="${member.memberName}" required> 
                                            </div>

                                            <div class="form-group col-md-6 mb-3">
                                                <label class="font-weight-bold small text-dark" for="memberBirth">생년월일</label> 
                                                <input type="date" class="form-control border-0 bg-light px-3 fixed-height-input" name="memberBirth" id="memberBirth" value="${member.memberBirth}" required>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group mb-4">
                                            <label class="font-weight-bold small text-dark" for="memberEmail">이메일 주소</label> 
                                            <input type="email" class="form-control border-0 bg-light px-3 fixed-height-input" name="memberEmail" id="memberEmail" value="${member.memberEmail}" required> 
                                        </div>
                                        
                                        <div class="form-group mb-5 p-3 rounded-lg bg-light" style="border: 2px dashed #cbd5e0;">
                                            <label class="font-weight-bold small text-secondary mb-1" for="porfileName"><i class="fas fa-image mr-1 text-primary"></i> 프로필 아바타 이미지 변경</label> 
                                            <div class="text-xs text-muted mb-2">현재 파일: <span class="font-weight-bold text-dark">${member.profileDTO.fileName}</span></div>
                                            <input type="file" class="form-control-file small text-muted" name="attach" id="porfileName">
                                        </div>
                                        
                                        <div class="text-right pt-2">
                                            <a href="/member/mypage" class="btn btn-link text-muted font-weight-bold text-decoration-none mr-2">취소</a>
                                            <button type="submit" class="btn btn-primary px-5 font-weight-bold shadow-sm fixed-height-input" style="border-radius:10px; line-height:22px;">수정 완료</button>
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
</body>
</html>