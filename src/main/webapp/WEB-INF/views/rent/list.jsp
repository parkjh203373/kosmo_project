<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 대출 현황</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
</head>
<body id="page-top">
	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				<div class="container-fluid">
					<h1 class="h3 mb-4 text-gray-800">나의 대출 현황</h1>
					<div class="row justify-content-center">
						<div class="col-lg-10">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">현재 대출 중인 도서
										(최대 3권)</h6>
								</div>
								<div class="card-body">
									<table class="table table-hover shadow-sm bg-white rounded">
										<thead class="thead-dark text-center">
											<tr>
												<th>표지</th>
												<th style="width: 40%;">도서 정보</th>
												<th>대출일</th>
												<th>반납 예정일</th>
												<th>연체 상태</th>
												<th>관리</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${list}" var="r">
												<tr>
													<td class="text-center" style="width: 100px;"><img
														src="${r.bookDTO.bookImage}"
														class="img-fluid rounded shadow-sm"
														style="max-height: 80px;"></td>
													<td class="align-middle">
														<div class="font-weight-bold">${r.bookDTO.bookTitle}</div>
														<div class="small text-muted">${r.bookDTO.bookAuthor}</div>
													</td>
													<td class="align-middle text-center">${r.rentDate}</td>
													<td
														class="align-middle text-center text-primary font-weight-bold">${r.dueDate}</td>
													<td class="align-middle text-center"><c:choose>
															<c:when test="${fn:contains(r.lateStatus, '연체')}">
																<span class="badge badge-danger">${r.lateStatus}</span>
															</c:when>
															<c:otherwise>
																<span class="badge badge-info">${r.lateStatus}</span>
															</c:otherwise>
														</c:choose></td>
													<td class="align-middle text-center">
														<button class="btn btn-sm btn-danger return-btn"
															data-bn="${r.bookNum}">반납하기</button>
													</td>
												</tr>
											</c:forEach>
											<c:if test="${empty list}">
												<tr>
													<td colspan="6" class="text-center py-5 text-muted">대출	중인 도서가 없습니다.</td>
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
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
	</div>
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	
	<script src="/js/book/rent.js"></script>

</body>
</html>