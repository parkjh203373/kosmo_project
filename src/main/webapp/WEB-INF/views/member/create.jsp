<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>회원가입 - Forest Library</title>
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
                
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-xl-7 col-lg-9">
                            <div class="text-center mb-4">
                                <h1 class="h3 font-weight-bold text-gray-900">숲의 일원 되기</h1>
                                <p class="text-muted small">Forest Library 아카이브 공간에 당신을 기록해 보세요.</p>
                            </div>
                            
                            <div class="card border-0 bg-white p-4 shadow-sm" style="border-radius: 16px;">
                                <div class="card-body">
                                    <form id="frm" action="/member/create" method="post" enctype="multipart/form-data">
                                        
                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold small text-dark" for="username">아이디</label> 
                                            <div class="input-group">
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="username" id="username" placeholder="사용할 아이디를 입력하세요." required> 
                                                <div class="input-group-append">
                                                    <button type="button" id="btn-check" class="btn btn-primary px-3 font-weight-bold" style="border-radius: 0 10px 10px 0; height: calc(2.25rem + 10px);">중복확인</button>
                                                </div>
                                            </div>
                                            <div id="id-msg" class="small mt-1 px-1"></div>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold small text-dark" for="password">비밀번호</label> 
                                            <input type="password" class="form-control border-0 bg-light px-3 fixed-height-input" name="password" id="password" placeholder="안전한 비밀번호를 입력하세요." required>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="font-weight-bold small text-dark" for="memberName">이름</label> 
                                                <input type="text" class="form-control border-0 bg-light px-3 fixed-height-input" name="memberName" id="memberName" placeholder="성함 입력" required> 
                                            </div>
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="font-weight-bold small text-dark" for="memberBirth">생년월일</label> 
                                                <input type="date" class="form-control border-0 bg-light px-3 fixed-height-input" name="memberBirth" id="memberBirth" required>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group mb-4">
                                            <label class="font-weight-bold small text-dark" for="memberEmail">이메일 주소</label> 
                                            <input type="email" class="form-control border-0 bg-light px-3 fixed-height-input" name="memberEmail" id="memberEmail" placeholder="example@library.com" required> 
                                        </div>

                                        <div class="form-group mb-5 p-3 rounded-lg bg-light" style="border: 2px dashed #e2e8f0;">
                                            <label class="font-weight-bold small text-secondary mb-1" for="porfileName"><i class="fas fa-user-circle mr-1 text-primary"></i> 나만의 프로필 사진 등록</label> 
                                            <input type="file" class="form-control-file text-muted small mt-1" name="attach" id="porfileName">
                                        </div>

                                        <button type="submit" class="btn btn-primary btn-block font-weight-bold fixed-height-input" style="border-radius: 10px; line-height: 22px;">가입 하기</button>
                                        
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
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="/js/member/create.js"></script>
    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>