<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>나의 찜 목록</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
	.book-title-link {
		color: #1a202c;
		font-weight: 700;
		font-size: 1.15rem;
		transition: color 0.2s ease;
	}
	.book-title-link:hover {
		color: #4e73df;
		text-decoration: none;
	}
	.wish-table th {
		border-top: none !important;
		border-bottom: 2px solid #edf2f7 !important;
		color: #718096;
		font-weight: 600;
		text-transform: uppercase;
		font-size: 0.85rem;
		letter-spacing: 0.05em;
	}
	.wish-table td {
		vertical-align: middle !important;
		border-bottom: 1px solid #edf2f7;
		padding: 20px 12px !important;
	}
	.pagination .page-link {
		color: #718096;
		border: 1px solid #e2e8f0;
		padding: 0.6rem 0.9rem;
	}
	.pagination .page-item.active .page-link {
		background-color: #4e73df;
		border-color: #4e73df;
	}
</style>
</head>

<body id="page-top">
	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="container py-4">
					<!-- 상단 헤더 & 검색 바 영역 -->
					<div class="row justify-content-center mb-4">
						<div class="col-lg-10 d-sm-flex align-items-center justify-content-between">
							<h3 class="font-weight-bold text-gray-900 mb-3 mb-sm-0">
								<i class="fas fa-heart text-danger mr-2"></i>나의 관심 도서 목록
							</h3>
							
							<!-- 검색 필터 -->
							<div class="card bg-white border-0 shadow-sm rounded-lg">
								<div class="card-body p-2">
									<form action="./list" method="get" class="form-inline">
										<select name="kind" class="custom-select border-0 bg-light font-weight-medium text-dark mr-2" style="border-radius: 8px;">
											<option ${pager.kind eq 'v1'?'selected':''} value="v1">제목</option>
											<option ${pager.kind eq 'v2'?'selected':''} value="v2">저자</option>
										</select>
										<div class="input-group">
											<input type="text" name="search" value="${pager.search}" class="form-control border-0 bg-light" placeholder="목록 내 검색..." style="border-radius: 8px 0 0 8px; width: 200px;">
											<div class="input-group-append">
												<button class="btn btn-primary px-3" type="submit" style="border-radius: 0 8px 8px 0;">
													<i class="fas fa-search"></i>
												</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
                    
                    <!-- 리스트 메인 보드 -->
                    <div class="row justify-content-center">
	           	    	<div class="col-lg-10">
							<div class="card bg-white border-0 shadow-sm rounded-lg overflow-hidden">
								<div class="card-body p-0">
									<table class="table wish-table mb-0">
									    <thead>
									        <tr>
									            <th class="text-center" style="width: 140px;">도서 표지</th>
									            <th>도서 제목/저자</th>
									            <th class="text-center" style="width: 150px;">출판일</th>
									            <th class="text-center" style="width: 150px;">대출 상태</th>
									            <th class="text-center" style="width: 120px;">정보</th>
									        </tr>
									    </thead>
									    <tbody>
									        <c:forEach items="${list}" var="d">
									            <tr>
									                <!-- 도서 표지 -->
									                <td class="text-center">
									                    <c:choose>
													        <c:when test="${not empty d.bookDTO.bookImage}">
													            <img src="${d.bookDTO.bookImage}" class="rounded shadow-sm" style="height: 110px; width: 80px; object-fit: cover;" alt="도서 표지">
													        </c:when>
													        <c:otherwise>
													            <div class="bg-light d-flex align-items-center justify-content-center rounded mx-auto" style="height: 110px; width: 80px; color: #a0aec0; font-size: 0.8rem;">
													            	<i class="fas fa-book fa-2x opacity-25"></i>
													            </div>
													        </c:otherwise>
													    </c:choose>
									                </td>
									                
									                <!-- 도서 정보 -->
									                <td>
									                    <div class="mb-1">
									                        <a href="/book/detail?bookNum=${d.bookDTO.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}&from=wishlist" class="book-title-link">
									                        	${d.bookDTO.bookTitle}
									                        </a>
									                    </div>
									                    <div class="small text-secondary">
									                        <span class="text-dark font-weight-medium">${d.bookDTO.bookAuthor}</span>
									                    </div>
									                </td>
									                
									                <!-- 출판일 -->
									                <td class="text-center text-secondary small">
									                    ${d.bookDTO.bookDate}
									                </td>
									                
									                <!-- 대출 여부 배지 -->
									                <td class="text-center">
									                	<c:choose>
														    <c:when test="${d.bookDTO.bookStatus eq '대출가능'}">
														    	<span class="badge px-3 py-2 font-weight-bold text-success" style="background:#e6fffa; font-size: 0.8rem; border-radius: 50px;">
														            ● 대출 가능
														        </span>
														    </c:when>
													        <c:when test="${d.bookDTO.bookStatus eq '대출중'}">
													            <span class="badge px-3 py-2 font-weight-bold text-danger" style="background:#fff5f5; font-size: 0.8rem; border-radius: 50px;">
													                ● 대출 중
													            </span>
													        </c:when>
													        <c:otherwise>
													            <span class="badge px-3 py-2 font-weight-bold text-secondary" style="background:#f7fafc; font-size: 0.8rem; border-radius: 50px;">
													                ${d.bookDTO.bookStatus}
													            </span>
													        </c:otherwise>
													    </c:choose>
									                </td>
									                
									                <!-- 이동 액션 -->
									                <td class="text-center">
									                    <a href="/book/detail?bookNum=${d.bookDTO.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}&from=wishlist" class="btn btn-sm btn-light border font-weight-bold px-3 text-secondary" style="border-radius: 8px;">
									                    	보기
									                    </a>
									                </td>
									            </tr>
									        </c:forEach>
									        
									        <%-- 찜 목록이 텅 빌 경우의 안전 장치 예외 처리 --%>
									        <c:if test="${empty list}">
									        	<tr>
									        		<td colspan="5" class="text-center py-5 text-muted small">
									        			<i class="far fa-heart fa-3x mb-3 text-gray-300 d-block"></i>
									        			아직 찜한 도서가 없습니다. 마음에 드는 책을 담아보세요.
									        		</td>
									        	</tr>
									        </c:if>
									    </tbody>
									</table>
								</div>
							</div>
	                    	
	                    	<!-- 페이징 세그먼트 -->
	                    	<div class="d-flex justify-content-center mt-4">
							    <nav aria-label="Page navigation">
							        <ul class="pagination shadow-sm" style="border-radius: 8px; overflow: hidden;">
							            <li class="page-item ${pager.pre ? '' : 'disabled'}">
							                <a class="page-link border-0" href="./list?page=${pager.start-1}&search=${pager.search}&kind=${pager.kind}">
							                	<i class="fas fa-chevron-left small"></i>
							                </a>
							            </li>
							            
							            <c:forEach begin="${pager.start}" end="${pager.end}" var="i">
							                <li class="page-item ${pager.page == i ? 'active' : ''}">
							                    <a class="page-link border-0 font-weight-bold" href="./list?page=${i}&search=${pager.search}&kind=${pager.kind}">${i}</a>
							                </li>
							            </c:forEach>
							            
							            <li class="page-item ${pager.next ? '' : 'disabled'}">
							                <a class="page-link border-0" href="./list?page=${pager.end+1}&search=${pager.search}&kind=${pager.kind}">
							                	<i class="fas fa-chevron-right small"></i>
							                </a>
							            </li>
							        </ul>
							    </nav>
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