<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록 - Forest Library</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
.book-hover-row {
	transition: background-color 0.2s ease;
}

.book-hover-row:hover {
	background-color: #fcfdfd !important;
}

.badge-ranking {
	background: rgba(42, 92, 67, 0.9);
	backdrop-filter: blur(4px);
	color: white;
	border-radius: 6px;
	font-weight: 600;
	padding: 4px 8px;
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
					<!-- 상단 인기 도서 섹션 -->
					<div class="row mb-5">
						<div class="col-lg-6 pr-lg-4 border-right d-flex flex-column">
							<div
								class="d-flex align-items-center justify-content-between mb-4"
								style="height: 38px;">
								<h2
									class="h5 mb-0 text-gray-900 font-weight-bold d-flex align-items-center">
									<i class="fas fa-crown text-warning mr-2"></i>전체 인기 서적 TOP 3
								</h2>
							</div>

							<div class="row flex-grow-1 align-items-stretch">
								<c:forEach items="${bestSeller}" var="best" varStatus="vs">
									<div
										class="col-4 mb-3 text-center d-flex flex-column align-items-center">
										<div
											class="position-relative mb-2 shadow rounded-lg overflow-hidden"
											style="height: 200px; width: 140px; min-width: 140px;">
											<a href="./detail?bookNum=${best.bookNum}"
												class="d-block h-100 w-100"> <img
												src="${best.bookImage}" class="h-100 w-100"
												style="object-fit: cover;"
												onerror="this.src='/img/no-image.png'" alt="도서 이미지">
											</a>
											<div class="position-absolute"
												style="top: 8px; left: 8px; z-index: 2;">
												<c:choose>
													<c:when test="${vs.count eq 1}">
														<span
															class="badge shadow-sm font-weight-bold text-white px-2 py-1"
															style="background: #e5a93b; border-radius: 6px; font-size: 0.75rem;">1st</span>
													</c:when>
													<c:when test="${vs.count eq 2}">
														<span
															class="badge shadow-sm font-weight-bold text-white px-2 py-1"
															style="background: #a0aec0; border-radius: 6px; font-size: 0.75rem;">2nd</span>
													</c:when>
													<c:otherwise>
														<span
															class="badge shadow-sm font-weight-bold text-white px-2 py-1"
															style="background: #b7791f; border-radius: 6px; font-size: 0.75rem;">3rd</span>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
										<div class="w-100 px-1 text-center" style="height: 42px;">
											<div
												class="small font-weight-bold text-gray-800 text-truncate mb-0"
												title="${best.bookTitle}">${best.bookTitle}</div>
											<div class="text-xs text-muted text-truncate mt-0.5">${best.bookAuthor}</div>
											<div class="text-xs text-muted mt-0.5">
												<i class="fas fa-heart text-danger mr-1"></i>${best.rentCount}회
												대출
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>

						<div class="col-lg-6 pl-lg-4 d-flex flex-column">
							<div
								class="d-flex align-items-center justify-content-between mb-4"
								style="height: 38px;">
								<h2
									class="h5 mb-0 text-gray-900 font-weight-bold d-flex align-items-center">
									<i class="fas fa-users"
										style="color: #2a5c43 !important; margin-right: 8px;"></i>독자
									연령대별 선호 도서
								</h2>
								<select id="ageSelector"
									class="form-control form-control-sm border shadow-sm bg-white"
									style="width: 120px; font-size: 0.85rem; height: 35px; padding-top: 0; padding-bottom: 0; border-color: #cbd5e0 !important; border-radius: 8px;">
									<option value="10">10대 추천</option>
									<option value="20" selected>20대 추천</option>
									<option value="30">30대 추천</option>
									<option value="40">40대 이상</option>
								</select>
							</div>

							<div id="ageBestResult"
								class="row flex-grow-1 align-items-stretch">
								<div class="col-12 text-center py-5">
									<div class="spinner-border text-primary" role="status"></div>
								</div>
							</div>
						</div>
					</div>

					<hr class="my-5" style="border-top: 1px dashed #e2e8f0;">

					<!-- 메인 검색 및 검색 결과 목록 리스트 -->
					<div class="row justify-content-center">
						<div class="col-xl-12 col-lg-12">

							<div
								class="d-sm-flex align-items-center justify-content-between mb-4">
								<h1 class="h4 mb-0 text-gray-900 font-weight-bold">도서 대출 현황</h1>

								<!-- 관리자 권한용 제어 버튼(등록/삭제) 배치 -->
								<div>
									<sec:authorize access="hasAnyRole('ADMIN', 'MANAGER')">
										<button type="button"
											class="btn btn-danger btn-sm font-weight-bold px-3 shadow-sm mr-1"
											id="deleteAllBtn">
											<i class="fas fa-dumpster mr-1"></i> 전체 삭제
										</button>
										<button type="button"
											class="btn btn-outline-danger btn-sm font-weight-bold px-3 shadow-sm mr-1"
											id="deleteSelectedBtn">
											<i class="fas fa-trash-alt mr-1"></i> 선택 삭제
										</button>
										<a href="./create"
											class="btn btn-primary btn-sm px-3 shadow-sm"
											onclick="return confirm('새 도서를 등록하시겠습니까?');"> <i
											class="fas fa-plus mr-1"></i> 새 도서 추가
										</a>
									</sec:authorize>
								</div>
							</div>

							<!-- 필터&검색 윈도우 -->
							<div class="card p-3 mb-4 bg-white border-0">
								<div class="card-body p-1">
									<form action="./list" method="get" class="form-inline row">
										<div class="col-md-3 mb-2 mb-md-0">
											<select name="kind"
												class="form-control w-100 h-50 border-0 bg-light">
												<option ${pager.kind eq 'v1'?'selected':''} value="v1">📖
													도서 제목</option>
												<option ${pager.kind eq 'v2'?'selected':''} value="v2">✍️
													저자 식별</option>
											</select>
										</div>
										<div class="col-md-7 mb-2 mb-md-0">
											<input type="text" name="search" value="${pager.search}"
												class="form-control w-100 h-50 border-0 bg-light"
												placeholder="원하는 도서 제목이나 저자 키워드를 입력해보세요.">
										</div>
										<div class="col-md-2">
											<button class="btn btn-primary btn-block font-weight-bold"
												type="submit">검색하기</button>
										</div>
									</form>
								</div>
							</div>

							<!-- 도서 아카이브 테이블 -->
							<div class="card border-0 bg-white overflow-hidden p-0 mb-4">
								<table class="table mb-0 align-middle">
									<thead
										class="bg-light text-secondary text-uppercase font-weight-bold"
										style="font-size: 0.85rem; border-bottom: 2px solid #edf2f7;">
										<tr>
											<!-- [변경점] 관리자 권한일 때만 전체 선택 체크박스 노출 -->
											<sec:authorize access="hasAnyRole('ADMIN', 'MANAGER')">
												<th class="text-center border-0 py-3" style="width: 50px;">
													<input type="checkbox" id="checkAll">
												</th>
											</sec:authorize>
											<th class="text-center border-0 py-3" style="width: 140px;">표지</th>
											<th class="border-0 py-3">도서 정보</th>
											<th class="text-center border-0 py-3" style="width: 150px;">발행일</th>
											<th class="text-center border-0 py-3" style="width: 150px;">대출
												상태</th>
											<th class="text-center border-0 py-3" style="width: 120px;">정보</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="d">
											<tr class="book-hover-row"
												style="border-bottom: 1px solid #edf2f7;">
												<!-- [변경점] 관리자 권한일 때만 개별 선택 체크박스 노출 (class="wish-checkbox" 연동) -->
												<sec:authorize access="hasAnyRole('ADMIN', 'MANAGER')">
													<td class="text-center align-middle py-3"><input
														type="checkbox" class="wish-checkbox" value="${d.bookNum}">
													</td>
												</sec:authorize>

												<td class="text-center py-3"><c:choose>
														<c:when test="${not empty d.bookImage}">
															<img src="${d.bookImage}" class="rounded shadow-sm"
																style="height: 100px; width: 70px; object-fit: cover;"
																alt="도서 표지">
														</c:when>
														<c:otherwise>
															<div
																class="bg-light text-muted d-flex align-items-center justify-content-center rounded mx-auto small"
																style="height: 100px; width: 70px;">No Cover</div>
														</c:otherwise>
													</c:choose></td>
												<td class="align-middle py-3">
													<div class="font-weight-bold mb-1"
														style="font-size: 1.05rem;">
														<a
															href="./detail?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}"
															class="text-decoration-none text-dark hover-primary">${d.bookTitle}</a>
													</div>
													<div class="text-muted small">저자 : ${d.bookAuthor} /
														출판사 : ${d.bookPublisher}</div>
												</td>
												<td
													class="align-middle text-center py-3 text-secondary small font-weight-medium">${d.bookDate}</td>
												<td class="align-middle text-center py-3"><c:choose>
														<c:when test="${d.bookStatus eq '대출가능'}">
															<span
																class="badge px-3 py-2 text-success font-weight-bold"
																style="background-color: #e6fffa; border-radius: 30px;">
																● 대출 가능 </span>
														</c:when>
														<c:when test="${d.bookStatus eq '대출중'}">
															<span
																class="badge px-3 py-2 text-danger font-weight-bold"
																style="background-color: #fff5f5; border-radius: 30px;">
																● 대출 중 </span>
														</c:when>
														<c:otherwise>
															<span
																class="badge px-3 py-2 text-secondary font-weight-bold"
																style="background-color: #f7fafc; border-radius: 30px;">
																${d.bookStatus} </span>
														</c:otherwise>
													</c:choose></td>
												<td class="align-middle text-center py-3"><a
													href="./detail?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}"
													class="btn btn-sm btn-light font-weight-medium text-dark border">조회</a>
												</td>
											</tr>
										</c:forEach>

										<!-- [보안장치] 검색 결과가 비어있을 때 표출 로직 추가 -->
										<c:if test="${empty list}">
											<tr>
												<td colspan="6" class="text-center py-5 text-muted small">
													<i
													class="fas fa-book-open fa-3x mb-3 text-gray-300 d-block"></i>
													해당하는 도서 데이터가 존재하지 않습니다.
												</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>

							<!-- 미니멀 페이지네이션 -->
							<div class="d-flex justify-content-center mt-5">
								<nav>
									<ul class="pagination pagination-sm border-0">
										<li class="page-item ${pager.pre ? '' : 'disabled'}"><a
											class="page-link border-0 text-dark bg-light mx-1 rounded-circle"
											href="./list?page=${pager.start-1}&search=${pager.search}&kind=${pager.kind}"><i
												class="fas fa-chevron-left small"></i></a></li>

										<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
											<li class="page-item mx-1 ${pager.page == i ? 'active' : ''}">
												<a
												class="page-link border-0 rounded-circle text-center font-weight-bold ${pager.page == i ? 'bg-primary text-white' : 'text-dark bg-white shadow-sm'}"
												style="width: 34px; height: 34px; line-height: 18px;"
												href="./list?page=${i}&search=${pager.search}&kind=${pager.kind}">${i}</a>
											</li>
										</c:forEach>

										<li class="page-item ${pager.next ? '' : 'disabled'}"><a
											class="page-link border-0 text-dark bg-light mx-1 rounded-circle"
											href="./list?page=${pager.end+1}&search=${pager.search}&kind=${pager.kind}"><i
												class="fas fa-chevron-right small"></i></a></li>
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
	<script src="/js/book/bestseller.js"></script>

	<script src="/js/book/listcheckbox.js"></script>
</body>
</html>