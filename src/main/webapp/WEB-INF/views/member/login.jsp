<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>로그인 - Forest Library</title>
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
        .custom-check-label {
            user-select: none;
            cursor: pointer;
            font-size: 0.85rem;
            color: #4a5568;
        }
    </style>
</head>
<body id="page-top" class="bg-light">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-5 mt-4">
                    <div class="row justify-content-center">
                        <div class="col-xl-5 col-lg-7 col-md-9">
                            <div class="text-center mb-4">
                                <h1 class="h4 font-weight-bold text-gray-900">Forest 아카이브 로그인</h1>
                                <p class="text-muted small">기록된 취향과 도서 데이터를 확인해 보세요.</p>
                            </div>
                            
                            <div class="card border-0 bg-white p-4 shadow-sm" style="border-radius: 16px;">
                                <div class="card-body">
                                
	                                <c:if test="${not empty param.message}">
								        <div class="alert alert-danger border-0 small font-weight-bold text-center mb-4" 
								             style="border-radius: 10px; background-color: #fff5f5; color: #e53e3e;">
								            <i class="fas fa-exclamation-circle mr-1"></i> ${param.message}
								        </div>
								    </c:if>
                                
                                    <form method="post">
                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold small text-dark" for="username">아이디</label> 
                                            <input type="text" name="username" value="${cookie.rememberId.value}" class="form-control border-0 bg-light px-3 fixed-height-input" id="username" placeholder="아이디를 입력하세요." required/> 
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold small text-dark" for="password">비밀번호</label> 
                                            <input type="password" name="password" class="form-control border-0 bg-light px-3 fixed-height-input" id="password" placeholder="비밀번호를 입력하세요." required>
                                        </div>
                                        
                                        <div class="form-group mb-4 d-flex align-items-center" style="gap: 8px;">
										    <input type="checkbox" name="rememberId" value="1" id="exampleCheck1" 
										           style="accent-color: #2a5c43; width: 16px; height: 16px; cursor: pointer; margin: 0; vertical-align: middle;" 
										           ${not empty cookie.rememberId.value ? 'checked' : ''}> 
										    
										    <label class="custom-check-label font-weight-medium mb-0" for="exampleCheck1" 
										           style="cursor: pointer; line-height: 1; vertical-align: middle;">
										        아이디 기억하기
										    </label>
										</div>
                                        
                                        <button type="submit" class="btn btn-primary btn-block font-weight-bold fixed-height-input mb-3" style="border-radius: 10px; line-height: 22px;">로그인</button>
                                        
                                        <div class="text-center mt-3">
                                            <span class="small text-muted">아직 회원이 아니신가요?</span>
                                            <a href="/member/create" class="small font-weight-bold text-primary ml-2 text-decoration-none">회원가입</a>
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