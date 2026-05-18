<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>결제 완료 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .status-circle {
            width: 72px;
            height: 72px;
            background-color: #e6fffa;
            color: #2a5c43;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto 24px;
        }
        .redirect-box {
            background-color: #f8fafc;
            border-radius: 12px;
            padding: 16px;
            color: #64748b;
            font-size: 0.9rem;
        }
    </style>
</head>
<body id="page-top" class="bg-light">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-5 mt-5">
                    <div class="row justify-content-center">
                        <div class="col-xl-5 col-lg-6 col-md-8 text-center">
                            
                            <div class="card border-0 bg-white p-5 shadow-sm" style="border-radius: 20px;">
                                <div class="card-body p-2">
                                    
                                    <div class="status-circle shadow-sm">
                                        <i class="fas fa-check"></i>
                                    </div>
                                    
                                    <h3 class="font-weight-bold text-gray-900 mb-3" style="font-size: 1.4rem;">결제가 완료되었습니다!</h3>
                                    <p class="text-secondary small mb-4">Forest Library 중고 장터를 이용해 주셔서 감사합니다.<br>안전하게 도서 분양 계약이 매핑되었습니다.</p>
                                    
                                    <div class="redirect-box font-weight-medium">
                                        <span id="timer" class="text-primary font-weight-bold mx-1" style="font-size: 1.15rem;">3</span>초 후에 메인 아카이브로 자동으로 복귀합니다.
                                    </div>
                                    
                                    <div class="mt-4 pt-2">
                                        <a href="/" class="btn btn-primary btn-block font-weight-bold" style="border-radius: 10px; height: 42px; line-height: 26px;">지금 즉시 이동하기</a>
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

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="/js/pay/completed.js"></script>
    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>