<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>나의 대출 현황 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        /* 도서관 테마 전용 테이블 스타일링 */
        .library-table {
            border-collapse: separate;
            border-spacing: 0;
        }
        .library-table thead th {
            background-color: #2a5c43 !important;
            color: #ffffff !important;
            font-weight: 600;
            font-size: 0.9rem;
            border: none;
            padding: 14px 10px;
        }
        /* 테이블 첫 번째 행 라운드 처리 */
        .library-table thead th:first-child { border-top-left-radius: 12px; }
        .library-table thead th:last-child { border-top-right-radius: 12px; }
        
        .library-table tbody td {
            padding: 16px 12px;
            border-bottom: 1px solid #edf2f7;
            font-size: 0.95rem;
        }
        
        /* 배지 커스텀 */
        .badge-forest-info {
            background-color: #e6fffa;
            color: #2a5c43;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
        }
        .badge-forest-danger {
            background-color: #fff5f5;
            color: #e53e3e;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
        }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container-fluid py-4">
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h4 mb-0 text-gray-900 font-weight-bold">나의 대출 현황</h1>
                    </div>
                    
                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="card shadow-sm border-0 mb-4" style="border-radius: 16px;">
                                <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center" style="border-radius: 16px 16px 0 0;">
                                    <h6 class="m-0 font-weight-bold text-dark">
                                        <i class="fas fa-book-reader mr-2 text-primary"></i>현재 대출 중인 도서<span class="text-muted small ml-1">(최대 3권 가능)</span>
                                    </h6>
                                </div>
                                <div class="card-body px-4 pb-4 pt-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover library-table mb-0">
                                            <thead class="text-center">
                                                <tr>
                                                    <th style="width: 10%;">표지</th>
                                                    <th style="width: 40%;" class="text-left">도서 제목/저자</th>
                                                    <th style="width: 12%;">대출 일자</th>
                                                    <th style="width: 12%;">반납 예정일</th>
                                                    <th style="width: 12%;">대출 상태</th>
                                                    <th style="width: 14%;">관리</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${list}" var="r">
                                                    <tr>
                                                        <td class="align-middle text-center">
                                                            <img src="${r.bookDTO.bookImage}" class="img-fluid shadow-sm" style="max-height: 90px; border-radius: 6px; object-fit: cover;" alt="도서 표지">
                                                        </td>
                                                        <td class="align-middle text-left">
                                                            <div class="font-weight-bold text-gray-900 mb-1" style="font-size: 1rem;">
	                                                            <a href="/book/detail?bookNum=${r.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}" class="book-title-link text-dark">
										                        	${r.bookDTO.bookTitle}
										                        </a>
									                        </div>
                                                            <div class="small text-secondary"><i class="fas fa-pen text-xs mr-1"></i>${r.bookDTO.bookAuthor}</div>
                                                        </td>
                                                        <td class="align-middle text-center text-secondary font-weight-medium">
                                                            ${r.rentDate}
                                                        </td>
                                                        <td class="align-middle text-center text-primary font-weight-bold">
                                                            ${r.dueDate}
                                                        </td>
                                                        <td class="align-middle text-center">
                                                            <c:choose>
                                                                <c:when test="${fn:contains(r.lateStatus, '연체')}">
                                                                    <span class="badge-forest-danger small"><i class="fas fa-exclamation-circle mr-1"></i>${r.lateStatus}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge-forest-info small"><i class="fas fa-clock mr-1"></i>${r.lateStatus}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="align-middle text-center">
                                                            <button class="btn btn-sm btn-outline-danger font-weight-bold px-3 py-2 return-btn" data-bn="${r.bookNum}" style="border-radius: 8px;">
                                                                <i class="fas fa-undo-alt mr-1"></i> 도서 반납하기
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                
                                                <c:if test="${empty list}">
                                                    <tr>
                                                        <td colspan="6" class="text-center py-5 text-muted bg-light-soft" style="border-radius: 0 0 12px 12px;">
                                                            <div class="py-4">
                                                                <i class="fas fa-bookmark fa-3x opacity-25 mb-3 text-secondary"></i>
                                                                <div class="font-weight-medium text-secondary">대출하여 읽고 계신 도서가 없습니다.</div>
                                                                <p class="small text-muted mb-0 mt-1">도서관 검색 탭에서 마음에 드는 책을 서재에 담아보세요.</p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
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
    
    <script src="/js/book/rent.js"></script>
</body>
</html>