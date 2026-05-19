<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>도서 상세 - ${d.bookTitle}</title>
<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
<style>
	.detail-meta-label {
		color: #718096;
		font-weight: 500;
		width: 120px;
		display: inline-block;
	}
	.detail-meta-value {
		color: #1a202c;
		font-weight: 400;
	}
	.meta-divider {
		border-bottom: 1px solid #edf2f7;
		padding: 14px 0;
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
					<div class="row">
						<!-- 왼쪽: 감성적인 도서 표지 하이라이트 -->
						<div class="col-lg-4 text-center mb-4">
							<div class="card bg-white border-0 p-4 sticky-top shadow-sm" style="top: 100px;">
								<c:choose>
									<c:when test="${not empty d.bookImage}">
										<img src="${d.bookImage}" class="img-fluid rounded-lg shadow-lg mx-auto" style="max-height: 420px; object-fit: cover;">
									</c:when>
									<c:otherwise>
										<div class="bg-light d-flex align-items-center justify-content-center rounded-lg text-muted" style="height: 380px;">
											<i class="fas fa-book fa-4x opacity-25"></i>
										</div>
									</c:otherwise>
								</c:choose>
								
								<div class="mt-4">
									<c:choose>
										<c:when test="${d.bookStatus eq '대출가능'}">
											<span class="badge px-4 py-2 font-weight-bold text-success" style="background:#e6fffa; font-size: 0.9rem; border-radius: 50px;">● 대출 가능</span>
										</c:when>
										<c:when test="${d.bookStatus eq '대출중'}">
											<span class="badge px-4 py-2 font-weight-bold text-danger" style="background:#fff5f5; font-size: 0.9rem; border-radius: 50px;">● 대출 중</span>
										</c:when>
										<c:otherwise>
											<span class="badge px-4 py-2 font-weight-bold text-secondary" style="background:#f7fafc; font-size: 0.9rem; border-radius: 50px;">${d.bookStatus}</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>

						<!-- 오른쪽: 감성 텍스트 기반 명세 리스트 -->
						<div class="col-lg-8">
							<div class="card bg-white border-0 p-4 mb-4">
								<div class="card-body">
									<h2 class="font-weight-bold text-gray-950 mb-1" style="font-size: 1.8rem;">${d.bookTitle}</h2>
									<p class="text-muted mb-4" style="font-size: 1.05rem;">저자 ${d.bookAuthor}</p>
									
									<div class="meta-divider d-flex">
										<span class="detail-meta-label">출판사</span>
										<span class="detail-meta-value">${d.bookPublisher}</span>
									</div>
									<div class="meta-divider d-flex">
										<span class="detail-meta-label">발행일</span>
										<span class="detail-meta-value">${d.bookDate}</span>
									</div>

									<!-- 대출 현황 확장 알림 정보 블록 -->
									<c:if test="${d.bookStatus eq '대출중' and not empty d.rentDTO}">
										<div class="my-4 p-3 bg-light rounded-lg border-left-danger">
											<div class="small font-weight-medium text-secondary">대출중인 회원 : ${d.rentDTO.username}</div>
											<div class="font-weight-bold text-danger mt-1">
												<i class="far fa-calendar-check mr-1"></i> 반납 예정일: ${d.rentDTO.dueDate}
												<span class="badge badge-danger ml-2 px-2 py-1">${d.rentDTO.lateStatus}</span>
											</div>
										</div>
									</c:if>

									<div class="mt-4 pt-2">
										<h5 class="font-weight-bold text-dark mb-3">도서 소개서</h5>
										<div class="text-secondary" style="white-space: pre-wrap; line-height: 1.8; font-size: 0.95rem;">${d.bookContents}</div>
									</div>
								</div>
							</div>

							<!-- 액션 프로세스 제어 버트니어 패널 -->
							<div class="d-flex flex-wrap justify-content-between align-items-center mb-5 gap-2">
								<div>
									<c:choose>
										<c:when test="${d.bookStatus eq '대출가능'}">
											<button type="button" class="btn btn-primary px-4 py-2 font-weight-bold shadow" id="rentBtn" data-bn="${d.bookNum}">
												<i class="fas fa-bookmark mr-2"></i> 대출하기
											</button>
										</c:when>
										<c:when test="${d.bookStatus eq '대출중' and not empty member and d.rentDTO.username eq member.username}">
											<button type="button" class="btn btn-warning px-4 py-2 text-white font-weight-bold shadow-sm return-btn" data-bn="${d.bookNum}">
												<i class="fas fa-undo mr-2"></i> 반납하기
											</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn btn-light text-muted px-4 py-2 border font-weight-bold" disabled>대출 예약 불가</button>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${param.from eq 'wishlist'}">
											<a href="/wishlist/list" class="btn btn-outline-secondary px-3 py-2 ml-2">이전 목록</a>
										</c:when>
										<c:otherwise>
											<a href="./list?page=${pager.page}&kind=${pager.kind}&search=${pager.search}" class="btn btn-outline-secondary px-3 py-2 ml-2">이전 목록</a>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="mt-2 mt-sm-0" id="wishBtnArea">
									<c:choose>
										<c:when test="${isWish}">
								            <button type="button" class="btn btn-link text-danger text-decoration-none small" id="deleteWishBtn" data-bn="${d.bookNum}">
								                <i class="fas fa-heart-broken mr-1"></i> 관심도서 해제
								            </button>
								        </c:when>
										<c:otherwise>
											<button class="btn btn-light border btn-sm text-secondary px-3 py-2" id="create" data-pn="${d.bookNum}" onclick="return confirm('관심 목록에 추가하시겠습니까?');">
												<i class="far fa-heart text-danger mr-1"></i> 찜하기
											</button>
										</c:otherwise>
									</c:choose>

									<!-- 관리 제어 툴 -->
									<sec:authorize access="hasAnyRole('ADMIN', 'MANAGER')">
									<c:if test="${param.from ne 'wishlist'}">
										<a href="./update?bookNum=${d.bookNum}" class="btn btn-link text-secondary text-decoration-none small ml-2">수정</a>
										<form action="./delete" method="post" class="d-inline ml-1" onsubmit="return confirm('서적 정보를 시스템에서 삭제하시겠습니까?');">
											<input type="hidden" name="bookNum" value="${d.bookNum}">
											<button type="submit" class="btn btn-link text-muted text-decoration-none small">삭제</button>
										</form>
									</c:if>
									</sec:authorize>
								</div>
							</div>
						</div>
					</div>

					<!-- 후기 & 소통 감성 피드 구역 -->
					<div class="row justify-content-center mt-4">
						<div class="col-lg-12">
							<div class="card border-0 bg-white p-4">
								<div class="card-body">
									<h4 class="font-weight-bold text-gray-900 mb-4"><i class="far fa-comments mr-2 text-primary"></i>도서 리뷰</h4>
									
									<div id="review_list" class="mb-5">
										<div class="text-center py-5">
											<p class="text-muted mb-0 small">첫 소감 평을 작성해 다른 독자들에게 감동을 남겨보세요.</p>
										</div>
									</div>

									<input type="hidden" id="book_num_data" value="${d.bookNum}">
									<div class="pt-4 border-top">
										<c:choose>
											<c:when test="${canReview}">
												<div class="row mb-3 align-items-center">
													<div class="col-md-3">
														<select class="form-control font-weight-medium text-dark border-0 h-50 bg-light" id="review_rating">
															<option value="5">⭐⭐⭐⭐⭐ 최고</option>
															<option value="4">⭐⭐⭐⭐ 만족</option>
															<option value="3">⭐⭐⭐ 보통</option>
															<option value="2">⭐⭐ 아쉽게 느껴짐</option>
															<option value="1">⭐ 비추천</option>
														</select>
													</div>
												</div>
												<div class="form-group mb-0">
													<textarea id="review_contents" class="form-control border-0 bg-light p-3" rows="3" placeholder="남겨주신 정성스러운 후기는 도서관 활성화에 큰 원동력이 됩니다." style="resize: none; border-radius: 12px !important;"></textarea>
													<div class="text-right mt-3">
														<button class="btn btn-primary px-4 font-weight-bold" type="button" id="review_add">리뷰 등록</button>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="bg-light p-4 text-center rounded-lg" style="border: 1px dashed #cbd5e0;">
													<i class="fas fa-lock text-gray-400 mb-2"></i>
													<p class="mb-0 text-muted small">이 서적에 대한 대출 이력이 있는 회원에 한해 리뷰 작성이 가능합니다.</p>
												</div>
											</c:otherwise>
										</c:choose>
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

	<!-- 모던 리뷰 수정 레이어 모달창 -->
	<div class="modal fade" id="review_modal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content border-0 shadow-lg" style="border-radius:20px;">
				<div class="modal-header border-0 pt-4 px-4">
					<h5 class="modal-title font-weight-bold text-dark"><i class="fas fa-pen-fancy mr-2 text-primary"></i>작성했던 소감 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
				</div>
				<div class="modal-body px-4">
					<div class="form-group mb-3">
						<label class="font-weight-medium small text-secondary">별점 스케일 재조정</label> 
						<select class="form-control border-0 bg-light" id="rating_update">
							<option value="5">⭐⭐⭐⭐⭐</option>
							<option value="4">⭐⭐⭐⭐</option>
							<option value="3">⭐⭐⭐</option>
							<option value="2">⭐⭐</option>
							<option value="1">⭐</option>
						</select>
					</div>
					<div class="form-group">
						<label class="font-weight-medium small text-secondary">텍스트 소감 문구 변경</label>
						<textarea class="form-control border-0 bg-light p-3" rows="4" id="contents_update" style="resize: none; border-radius:12px !important;"></textarea>
					</div>
				</div>
				<div class="modal-footer border-0 pb-4 px-4 justify-content-end">
					<button type="button" class="btn btn-link text-muted font-weight-bold text-decoration-none" data-dismiss="modal">작업 중단</button>
					<button type="button" class="btn btn-primary px-4 font-weight-bold shadow-sm" id="update_save">동기화 저장</button>
				</div>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	<script src="/js/book/review.js"></script>
	<script src="/js/book/rent.js"></script>
</body>
</html>