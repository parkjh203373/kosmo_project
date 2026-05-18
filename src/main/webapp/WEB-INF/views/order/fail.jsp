<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>결제 실패 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .status-circle-fail {
            width: 72px;
            height: 72px;
            background-color: #fff5f5;
            color: #e53e3e;
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
                                    
                                    <div class="status-circle-fail shadow-sm">
                                        <i class="fas fa-exclamation"></i>
                                    </div>
                                    
                                    <h3 class="font-weight-bold text-gray-900 mb-3" style="font-size: 1.4rem;">결제에 실패했습니다</h3>
                                    <p class="text-secondary small mb-4">인증 시간 초과 또는 잔액 부족 등 문제가 발생했습니다.<br>잠시 후 다시 시도해 주세요.</p>
                                    
                                    <div class="redirect-box font-weight-medium">
                                        <span id="timer" class="text-danger font-weight-bold mx-1" style="font-size: 1.15rem;">3</span>초 후에 메인 아카이브로 자동으로 복귀합니다.
                                    </div>
                                    
                                    <div class="mt-4 pt-2">
                                        <a href="/dealboard/list" class="btn btn-light border font-weight-bold text-dark btn-block" style="border-radius: 10px; height: 42px; line-height: 26px;">장터 목록으로 돌아가기</a>
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
    <script src="/js/pay/fail.js"></script>
    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>