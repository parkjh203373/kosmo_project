<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- FontAwesome 아이콘 -->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<!-- 구글 Noto Sans KR 폰트 (트렌디하고 깔끔한 서체) -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<!-- 기존 SB Admin 2 베이스 위에 커스텀 모던 스타일 덮어쓰기 -->
<link href="/css/sb-admin-2.min.css" rel="stylesheet">

<style>
    /* 전체 테마 초기화 및 감성적인 무드 정립 */
    body {
        font-family: 'Noto Sans KR', sans-serif !important;
        background-color: #f8f9fa !important;
        color: #2d3748;
    }
    
    /* 세련된 메인 포인트 컬러 (딥그린 / 북카페 감성) */
    .text-primary { color: #2a5c43 !important; }
    .bg-primary { background-color: #2a5c43 !important; }
    .btn-primary {
        background-color: #2a5c43 !important;
        border-color: #2a5c43 !important;
        border-radius: 8px;
    }
    .btn-primary:hover {
        background-color: #1e4230 !important;
    }
    
    /* 부드러운 라운딩과 그림자 효과 */
    .card {
        border: none !important;
        border-radius: 16px !important;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03) !important;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 24px rgba(0,0,0,0.07) !important;
    }
    
    /* 인풋 창 스타일 세련되게 변경 */
    .form-control {
        border-radius: 10px !important;
        border: 1px solid #e2e8f0 !important;
        padding: 0.6rem 1rem;
    }
    .form-control:focus {
        border-color: #2a5c43 !important;
        box-shadow: 0 0 0 3px rgba(42, 92, 67, 0.1) !important;
    }

    /* 네비게이션 바 링크 스타일 */
    .nav-link-custom {
        font-weight: 500;
        color: #4a5568 !important;
        margin: 0 10px;
        transition: color 0.2s;
    }
    .nav-link-custom:hover, .nav-link-custom.active {
        color: #2a5c43 !important;
    }
</style>