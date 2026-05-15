<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
</head>
<body id="page-top">
<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				<div class="container-fluid">
				<div class="row mb-5">
                    <div class="col-lg-6 border-right">
					    <div class="d-flex align-items-center justify-content-between mb-3">
					        <h1 class="h4 mb-0 text-gray-800 font-weight-bold">
					            <i class="fas fa-crown text-warning mr-2"></i>전체 인기 TOP 3
					        </h1>
					    </div>
					
					    <div class="row">
					        <c:forEach items="${bestSeller}" var="best" varStatus="vs">
					            <div class="col-md-4 mb-3 text-center">
					                <div class="position-relative d-inline-block">
					                    <a href="./detail?bookNum=${best.bookNum}">
					                        <img src="${best.bookImage}" class="shadow-sm rounded mb-2" 
					                             style="height: 220px; width: 150px; object-fit: cover;" 
					                             onerror="this.src='/img/no-image.png'">
					                    </a>
					                    <div class="position-absolute" style="top: 0; left: 0;">
					                        <c:choose>
					                            <c:when test="${vs.count eq 1}"><span class="badge badge-warning p-1 shadow-sm">1위</span></c:when>
					                            <c:when test="${vs.count eq 2}"><span class="badge badge-secondary p-1 shadow-sm">2위</span></c:when>
					                            <c:otherwise><span class="badge p-1 shadow-sm text-white" style="background-color: #cd7f32;">3위</span></c:otherwise>
					                        </c:choose>
					                    </div>
					                </div>
					                <div class="small font-weight-bold text-truncate px-2">${best.bookTitle}</div>
					                <div class="text-xs text-danger"><i class="fas fa-fire"></i> ${best.rentCount}회</div>
					            </div>
					        </c:forEach>
					    </div>
					</div>
				
				    <div class="col-lg-6">
			            <div class="d-flex align-items-center justify-content-between mb-3">
			                <h1 class="h4 mb-0 text-gray-800 font-weight-bold">
			                    <i class="fas fa-user-friends text-primary mr-2"></i>연령대별 TOP 3
			                </h1>
			                <select id="ageSelector" class="custom-select custom-select-sm w-25">
			                    <option value="10">10대</option>
			                    <option value="20" selected>20대</option>
			                    <option value="30">30대</option>
			                    <option value="40">40대 이상</option>
			                </select>
			            </div>
			            <div id="ageBestResult" class="row">
			                <div class="col-12 text-center py-5">
			                    <div class="spinner-border text-primary" role="status"></div>
			                </div>
			            </div>
			        </div>
			    </div>
				
				    <hr class="mb-5">
                    
                    <div class="row justify-content-center">
	           	    	<div class="col-8">
	           	        	<!-- 검색 폼 -->
	                 	  	<div class="d-sm-flex align-items-center justify-content-between mb-4">
							    <h1 class="h3 mb-0 text-gray-800">도서 대출 현황</h1>
							    <a href="./create" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" onclick="return confirm('새 도서를 등록하시겠습니까?');">
							        <i class="fas fa-plus fa-sm text-white-50"></i> 도서 등록
							    </a>
							</div>
							
							<div class="card shadow mb-4">
							    <div class="card-body">
							        <form action="./list" method="get" class="form-inline justify-content-center">
							            <select name="kind" class="custom-select mr-2">
							                <option ${pager.kind eq 'v1'?'selected':''} value="v1">제목</option>
							                <option ${pager.kind eq 'v2'?'selected':''} value="v2">저자</option>
							            </select>
							            <input type="text" name="search" value="${pager.search}" class="form-control mr-2 w-50" placeholder="검색어를 입력하세요">
							            <button class="btn btn-primary" type="submit">검색</button>
							        </form>
							    </div>
							</div>
	                    
	                    	<table class="table table-hover shadow-sm bg-white rounded">
							    <thead class="thead-dark">
							        <tr>
							            <th class="text-center">표지</th>
							            <th>도서 정보</th>
							            <th class="text-center">출판일</th>
							            <th class="text-center">대출 여부</th>
							            <th class="text-center" style="width: 15%;">더 보기</th>
							        </tr>
							    </thead>
							    <tbody>
							        <c:forEach items="${list}" var="d">
							            <tr>
							                <td class="text-center" style="width: 120px;">
							                    <c:choose>
											        <c:when test="${not empty d.bookImage}">
											            <img src="${d.bookImage}" class="img-fluid rounded shadow-sm" style="max-height: 120px;" alt="도서 표지">
											        </c:when>
											        <c:otherwise>
											            <%-- 이미지가 없을 때 보여줄 기본 UI --%>
											            <div class="bg-light d-flex align-items-center justify-content-center rounded" style="height: 120px; color: #ccc;">No Image</div>
											        </c:otherwise>
											    </c:choose>
							                </td>
							                <td class="align-middle">
							                    <div class="font-weight-bold mb-1" style="font-size: 1.1rem;">
							                        <a href="./detail?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}" class="text-decoration-none text-dark">${d.bookTitle}</a>
							                    </div>
							                    <div class="small text-muted">
							                        저자: ${d.bookAuthor}</div>
							                </td>
							                <td class="align-middle text-center">
							                    <span class="badge badge-dark">${d.bookDate}</span> </td>
							                <td class="align-middle text-center">
							                	<c:choose>
												    <c:when test="${d.bookStatus eq '대출가능'}">
												    	<span class="badge badge-pill badge-success px-3 py-2">
												            <i class="fas fa-check-circle mr-1"></i> 대출 가능
												        </span>
												    </c:when>
											        <c:when test="${d.bookStatus eq '대출중'}">
											            <span class="badge badge-pill badge-danger px-3 py-2">
											                <i class="fas fa-minus-circle mr-1"></i> 대출 중
											            </span>
											        </c:when>
											        <c:otherwise>
											            <span class="badge badge-pill badge-secondary px-3 py-2">
											                <i class="fas fa-exclamation-triangle mr-1"></i> ${d.bookStatus}
											            </span>
											        </c:otherwise>
											    </c:choose>
							                </td>
							                <td class="align-middle text-center">
							                    <a href="./detail?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}" class="btn btn-sm btn-outline-primary">상세보기</a>
							                </td>
							            </tr>
							        </c:forEach>
							    </tbody>
							</table>
	                    	
	                    	<div class="d-flex justify-content-center mt-4">
							    <nav aria-label="Page navigation">
							        <ul class="pagination shadow-sm">
							            <li class="page-item ${pager.pre ? '' : 'disabled'}">
							                <a class="page-link" href="./list?page=${pager.start-1}&search=${pager.search}&kind=${pager.kind}">이전</a>
							            </li>
							            
							            <c:forEach begin="${pager.start}" end="${pager.end}" var="i">
							                <li class="page-item ${pager.page == i ? 'active' : ''}">
							                    <a class="page-link" href="./list?page=${i}&search=${pager.search}&kind=${pager.kind}">${i}</a>
							                </li>
							            </c:forEach>
							            
							            <li class="page-item ${pager.next ? '' : 'disabled'}">
							                <a class="page-link" href="./list?page=${pager.end+1}&search=${pager.search}&kind=${pager.kind}">다음</a>
							            </li>
							        </ul>
							    </nav>
							</div>
	                    	
	                    </div>
                    </div>
                    </div>
                <!-- end container-fluid -->
			</div>
			<!-- end content -->
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
		<!-- end content-wrapper -->
	</div>
	<!-- end wrapper -->
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
                    
                    
    <script src="/js/book/bestseller.js"></script>
</body>
</html>