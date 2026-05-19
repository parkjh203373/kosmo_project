<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>중고책 거래 게시판 - Forest Library</title>
    <c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
    <style>
        .market-card { transition: transform 0.25s ease, box-shadow 0.25s ease; border-radius: 16px !important; overflow: hidden; }
        .market-card:hover { transform: translateY(-6px); box-shadow: 0 12px 20px rgba(0,0,0,0.08) !important; }
        .market-img-top { height: 230px; object-fit: cover; background-color: #f8fafc; }
        .fixed-action-input { height: calc(2.25rem + 10px); font-size: 0.95rem; }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
                
                <div class="container py-4">
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h4 mb-0 text-gray-900 font-weight-bold">중고 도서 거래 게시판</h1>
                        <div>
                            <c:if test="${empty member}">
                                <a href="/member/login" class="btn btn-light text-dark font-weight-medium border mr-2 btn-sm px-3 shadow-sm">로그인</a>
                            </c:if>
                            <a href="./create" class="btn btn-primary font-weight-bold btn-sm px-3 shadow-sm"><i class="fas fa-plus mr-1"></i> 판매 글쓰기</a>
                        </div>
                    </div>

                    <div class="row mb-5 justify-content-center">
                        <div class="col-md-7">
                            <form action="./list" method="get" class="input-group shadow-sm bg-white p-1" style="border-radius:12px;">
                                <input type="text" name="search" class="form-control border-0 bg-transparent pl-3 fixed-action-input" placeholder="원하는 도서 제목이나 저자 키워드를 입력해 보세요." value="${param.search}">
                                <div class="input-group-append">
                                    <button class="btn btn-primary px-4 font-weight-bold" style="border-radius:10px; height: calc(2.25rem + 2px);" type="submit">검색</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="row">
                        <c:forEach items="${list}" var="dto">
                            <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 border-0 bg-white shadow-sm market-card position-relative">
                                    
                                    <c:if test="${dto.dealboardState eq '판매중'}">
	                                    <span class="badge position-absolute font-weight-bold px-2 py-1 text-success" 
	                                    	  style="top:12px; right:12px; background:rgba(230,255,250,0.9); z-index:10; border-radius:6px; font-size:0.75rem;">
	                                    	  ● 판매중</span>                                
                                    </c:if>
                                    
									<c:if test="${dto.dealboardState ne '판매중'}">
									    <span class="badge position-absolute font-weight-bold px-2 py-1 text-secondary" 
									          style="top:12px; right:12px; background:rgba(241, 245, 249, 0.95); z-index:10; border-radius:6px; font-size:0.75rem; border: 1px solid #e2e8f0;">
									          ● 판매완료</span>                                
									</c:if>
                                    
                                    <a href="./detail?dealboardNum=${dto.dealboardNum}">
                                        <c:choose>
                                            <c:when test="${not empty dto.oldbookDTO.oldbookFileDTO.fileName}">
                                                <img src="/files/dealboard/${dto.oldbookDTO.oldbookFileDTO.fileName}" class="card-img-top market-img-top" alt="도서 스냅">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="market-img-top d-flex align-items-center justify-content-center text-muted small" style="border-bottom:1px solid #f1f5f9;">No Image</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>

                                    <div class="card-body d-flex flex-column justify-content-between p-3">
                                        <div>
                                            <h5 class="font-weight-bold text-gray-900 text-truncate mb-1" style="font-size:1rem;" title="${dto.oldbookDTO.oldbookTitle}">
                                                <a href="./detail?dealboardNum=${dto.dealboardNum}" class="text-decoration-none text-dark hover-primary">${dto.oldbookDTO.oldbookTitle}</a>
                                            </h5>
                                            <div class="text-muted small text-truncate mb-2">지은이: ${dto.oldbookDTO.oldbookAuthor}</div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center pt-2 border-top" style="border-top-style: dashed !important;">
                                            <span class="text-xs text-secondary font-weight-medium">ID: ${dto.username}</span>
                                            <strong class="text-primary" style="font-size:1.1rem;">
                                                <fmt:formatNumber value="${dto.oldbookDTO.oldbookPrice}" pattern="#,###"/>원
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                            </div>		
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-center mt-5">
                        <nav>
                            <ul class="pagination pagination-sm border-0">
                                <li class="page-item ${pager.pre ? '' : 'disabled'}">
                                    <a class="page-link border-0 text-dark bg-light mx-1 rounded-circle text-center" style="width:34px; height:34px; line-height:20px;" href="./list?page=${pager.start - 1}&search=${pager.search}"><i class="fas fa-chevron-left small"></i></a>
                                </li>

								<c:choose>
						        	<c:when test="${not empty list}">
		                                <c:forEach begin="${pager.start}" end="${pager.end}" var="i">
		                                    <li class="page-item mx-1 ${pager.page == i ? 'active' : ''}">
		                                        <a class="page-link border-0 rounded-circle text-center font-weight-bold ${pager.page == i ? 'bg-primary text-white' : 'text-dark bg-white shadow-sm'}" style="width:34px; height:34px; line-height:18px;" href="./list?page=${i}&search=${pager.search}">${i}</a>
		                                    </li>
		                                </c:forEach>
		                            </c:when>
						      	  <c:otherwise>
						            <div class="col-12 text-center py-5">
						                <i class="fas fa-book-open fa-3x text-gray-300 mb-3"></i>
						                <p class="text-gray-500">등록된 판매 도서가 없습니다.<br>첫 번째 판매글을 등록해 보세요!</p>
						            </div>
						      	  </c:otherwise>
						 	   </c:choose>

                                <li class="page-item ${pager.next ? '' : 'disabled'}">
                                    <a class="page-link border-0 text-dark bg-light mx-1 rounded-circle text-center" style="width:34px; height:34px; line-height:20px;" href="./list?page=${pager.end + 1}&search=${pager.search}"><i class="fas fa-chevron-right small"></i></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
        </div>
    </div>
    <c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
</body>
</html>