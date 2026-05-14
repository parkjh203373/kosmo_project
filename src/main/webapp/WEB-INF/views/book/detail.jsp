<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>도서 상세 - ${d.bookTitle}</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
.book-detail-table th {
	width: 25%;
	background-color: #f8f9fc;
	color: #4e73df;
	vertical-align: middle;
}

.book-info-card {
	border-left: 0.25rem solid #4e73df;
}

.review-card {
	border-radius: 15px;
}

.bg-light-custom {
	background-color: #fdfdfd;
}
</style>
</head>

<body id="page-top">
	<div id="wrapper">
		<!-- 사이드바 -->
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<!-- 상단바 -->
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="container-fluid">
					<!-- 페이지 헤더 -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">도서 상세 정보</h1>
						<div>
							<c:choose>
								<c:when test="${d.bookStatus eq '대출가능'}">
									<span class="badge badge-success px-3 py-2 shadow-sm"><i
										class="fas fa-check-circle"></i> 대출 가능</span>
								</c:when>
								<c:when test="${d.bookStatus eq '대출중'}">
									<span class="badge badge-danger px-3 py-2 shadow-sm"><i
										class="fas fa-clock"></i> 대출 중</span>
								</c:when>
								<c:otherwise>
									<span class="badge badge-secondary px-3 py-2 shadow-sm">대출
										불가</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="row">
						<!-- 왼쪽: 도서 표지 이미지 -->
						<div class="col-xl-4 col-lg-5 mb-4">
							<div class="card shadow mb-4">
								<div class="card-body text-center p-4">
									<c:choose>
										<c:when test="${not empty d.bookImage}">
											<img src="${d.bookImage}" class="img-fluid rounded shadow-sm"
												style="max-height: 450px; border: 1px solid #eee;">
										</c:when>
										<c:otherwise>
											<div
												class="bg-light d-flex align-items-center justify-content-center rounded border"
												style="height: 400px;">
												<i class="fas fa-book fa-6x text-gray-200"></i>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>

						<!-- 오른쪽: 상세 명세 -->
						<div class="col-xl-8 col-lg-7">
							<div class="card shadow mb-4 book-info-card">
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">도서 메타데이터</h6>
								</div>
								<div class="card-body p-0">
									<table class="table table-bordered mb-0 book-detail-table">
										<tbody>
											<tr>
												<th>도서 제목</th>
												<td class="font-weight-bold text-dark h5">${d.bookTitle}</td>
											</tr>
											<tr>
												<th>저자</th>
												<td>${d.bookAuthor}</td>
											</tr>
											<tr>
												<th>출판사 / 출판일</th>
												<td>${d.bookPublisher}<span class="text-gray-400 mx-2">|</span>
													${d.bookDate}
												</td>
											</tr>

											<!-- 대출 중일 경우에만 표시되는 추가 정보 -->
											<c:if test="${d.bookStatus eq '대출중' and not empty d.rentDTO}">
												<tr class="bg-gray-100">
													<th>대출 정보</th>
													<td>
														<div class="small">
															대출일: <strong>${d.rentDTO.rentDate}</strong>
														</div>
														<div class="text-primary font-weight-bold">반납 예정:
															${d.rentDTO.dueDate}</div> <c:choose>
															<c:when test="${fn:contains(d.rentDTO.lateStatus, '연체')}">
																<span class="badge badge-danger mt-1">${d.rentDTO.lateStatus}</span>
															</c:when>
															<c:otherwise>
																<span class="badge badge-info mt-1">${d.rentDTO.lateStatus}</span>
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</c:if>

											<tr>
												<th>도서 소개</th>
												<td class="p-3">
													<div
														style="min-height: 150px; white-space: pre-wrap; line-height: 1.7; color: #5a5c69;">${d.bookContents}</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<!-- 버튼 액션 그룹 -->
							<div
								class="d-flex justify-content-between align-items-center mb-5">
								<div class="btn-group-container">
									<c:choose>
										<c:when test="${d.bookStatus eq '대출가능'}">
											<button type="button"
												class="btn btn-primary btn-icon-split shadow" id="rentBtn"
												data-bn="${d.bookNum}">
												<span class="icon text-white-50"><i
													class="fas fa-bookmark"></i></span> <span class="text">대출
													신청</span>
											</button>
										</c:when>
										<c:when
											test="${d.bookStatus eq '대출중' and not empty member and d.rentDTO.username eq member.username}">
											<button type="button"
												class="btn btn-warning btn-icon-split shadow return-btn"
												data-bn="${d.bookNum}">
												<span class="icon text-white-50"><i
													class="fas fa-undo"></i></span> <span class="text">도서 반납</span>
											</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-secondary shadow"
												disabled>대출 불가</button>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${param.from eq 'wishlist'}">
											<a href="/wishlist/list" class="btn btn-light border ml-2">목록으로</a>
										</c:when>
										<c:otherwise>
											<a href="./list?page=${pager.page}&kind=${pager.kind}&search=${pager.search}"
												class="btn btn-light border ml-2">목록으로</a>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="admin-actions">
									<c:choose>
										<c:when test="${param.from eq 'wishlist'}">
											<form action="/wishlist/delete" method="post"
												class="d-inline">
												<input type="hidden" name="bookNum" value="${d.bookNum}">
												<button type="submit" class="btn btn-outline-danger btn-sm"
													onclick="return confirm('찜 목록에서 삭제할까요?')">찜 해제</button>
											</form>
										</c:when>
										<c:otherwise>
											<button class="btn btn-outline-info btn-sm mr-1" id="create"
												data-pn="${d.bookNum}">
												<i class="far fa-heart"></i> 찜 하기
											</button>
										</c:otherwise>
									</c:choose>

									<!-- 관리 권한이 있을 경우 노출 (조건 추가 필요) -->
									<c:if test="${param.from ne 'wishlist'}">
										<a href="./update?bookNum=${d.bookNum}"
											class="btn btn-outline-secondary btn-sm">수정</a>
										<form action="./delete" method="post" class="d-inline ml-1"
											onsubmit="return confirm('데이터를 영구 삭제하시겠습니까?');">
											<input type="hidden" name="bookNum" value="${d.bookNum}">
											<button type="submit" class="btn btn-outline-danger btn-sm">삭제</button>
										</form>
									</c:if>
								</div>
							</div>
						</div>
					</div>

					<!-- 리뷰 섹션 -->
					<hr class="my-5">
					<div class="row justify-content-center">
						<div class="col-xl-8 col-lg-10">
							<div class="card shadow mb-4 review-card">
								<div class="card-header py-3 bg-light-custom">
									<h6 class="m-0 font-weight-bold text-primary">
										<i class="fas fa-comments"></i> 도서 리뷰 및 한줄평
									</h6>
								</div>
								<div class="card-body">
									<!-- 리뷰 리스트 -->
									<div id="review_list" class="mb-4">
										<div class="text-center py-5">
											<i class="fas fa-quote-left fa-2x text-gray-200 mb-3"></i>
											<p class="text-muted">아직 작성된 리뷰가 없습니다. 첫 번째 리뷰어가 되어보세요!</p>
										</div>
									</div>

									<!-- 리뷰 작성 폼 -->
									<input type="hidden" id="book_num_data" value="${d.bookNum}">
									<div class="border-top pt-4">
										<c:choose>
											<c:when test="${canReview}">
												<div class="bg-gray-100 p-3 rounded mb-3">
													<div class="form-row align-items-center">
														<div class="col-auto">
															<span class="font-weight-bold text-gray-800">평점 선택</span>
														</div>
														<div class="col-md-3 col-6">
															<select
																class="form-control form-control-sm border-primary"
																id="review_rating">
																<option value="5">★★★★★ (최고)</option>
																<option value="4">★★★★☆ (좋아요)</option>
																<option value="3">★★★☆☆ (보통)</option>
																<option value="2">★★☆☆☆ (그저그래요)</option>
																<option value="1">★☆☆☆☆ (별로예요)</option>
															</select>
														</div>
													</div>
												</div>
												<div class="form-group position-relative">
													<textarea id="review_contents" class="form-control"
														rows="4"
														placeholder="회원님의 소중한 후기를 남겨주세요 (타인에 대한 비방은 제재될 수 있습니다)."
														style="resize: none;"></textarea>
													<div class="text-right mt-3">
														<button class="btn btn-primary px-5 shadow-sm"
															type="button" id="review_add">리뷰 등록하기</button>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="bg-light p-4 text-center rounded border-dashed"
													style="border: 2px dashed #ddd;">
													<i class="fas fa-lock text-gray-400 mb-2"></i>
													<p class="mb-0 text-gray-600">
														이 도서를 <strong>대출하신 기록이 있는 회원</strong>만 리뷰 작성이 가능합니다.
													</p>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
		<!-- /#content-wrapper -->
	</div>
	<!-- /#wrapper -->

	<!-- 댓글 수정 모달 -->
	<div class="modal fade" id="review_modal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content shadow">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title">
						<i class="fas fa-edit mr-2"></i>리뷰 수정하기
					</h5>
					<button type="button" class="close text-white" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="font-weight-bold">평점 수정</label> <select
							class="form-control" id="rating_update">
							<option value="5">★★★★★</option>
							<option value="4">★★★★☆</option>
							<option value="3">★★★☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="1">★☆☆☆☆</option>
						</select>
					</div>
					<div class="form-group">
						<label class="font-weight-bold">내용 수정</label>
						<textarea class="form-control" rows="5" id="contents_update"
							style="resize: none;"></textarea>
					</div>
				</div>
				<div class="modal-footer bg-light">
					<button type="button" class="btn btn-secondary btn-sm"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm px-4"
						id="update_save">수정 완료</button>
				</div>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	<script src="/js/book/review.js"></script>
	<script src="/js/book/rent.js"></script>
</body>
</html>