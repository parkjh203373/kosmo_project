<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

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
					<h1 class="h3 mb-4 text-gray-800">도서 상세 정보</h1>
					<div class="row">
						<div class="col-lg-4 text-center">
							<c:choose>
								<c:when test="${not empty d.bookImage}">
									<img src="${d.bookImage}" class="img-fluid rounded shadow"
										style="max-width: 100%; height: auto;">
								</c:when>
								<c:otherwise>
									<div
										class="bg-light d-flex align-items-center justify-content-center rounded border"
										style="height: 400px; color: #ccc;">이미지 없음</div>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="col-lg-8">
							<table class="table border">
								<tbody>
									<tr>
										<th class="table-light" style="width: 20%;">제목</th>
										<td><strong>${d.bookTitle}</strong></td>
									</tr>
									<tr>
										<th class="table-light">저자</th>
										<td>${d.bookAuthor}</td>
									</tr>
									<tr>
										<th class="table-light">출판사</th>
										<td>${d.bookPublisher}</td>
									</tr>
									<tr>
										<th class="table-light">출판일</th>
										<td>${d.bookDate}</td>
									</tr>
									<tr>
										<th class="table-light">상태</th>
										<td><c:choose>
												<c:when test="${d.bookStatus eq '대출가능'}">
													<span class="text-success font-weight-bold">대출 가능</span>
												</c:when>
												<c:when test="${d.bookStatus eq '대출중'}">
													<span class="text-danger font-weight-bold">대출 중</span>
												</c:when>
												<c:otherwise>
													<span class="text-danger font-weight-bold">파손, 분실 등</span>
												</c:otherwise>
											</c:choose></td>
									</tr>
									<c:if test="${d.bookStatus eq '대출중' and not empty d.rentDTO}">
										<tr>
											<th class="table-light">대출일</th>
											<td>${d.rentDTO.rentDate}</td>
										</tr>
										<tr>
											<th class="table-light">반납 예정일</th>
											<td><span class="text-primary">${d.rentDTO.dueDate}</span></td>
										</tr>
										<tr>
											<th class="table-light">연체 상태</th>
											<td><c:choose>
													<c:when test="${fn:contains(d.rentDTO.lateStatus, '연체')}">
														<span class="badge badge-danger" style="font-size: 1rem;">
															${d.rentDTO.lateStatus} </span>
													</c:when>
													<c:otherwise>
														<span class="badge badge-info">${d.rentDTO.lateStatus}</span>
													</c:otherwise>
												</c:choose></td>
										</tr>
									</c:if>
									<tr>
										<th class="table-light">도서 소개</th>
										<td>
											<div class="p-2"
												style="min-height: 150px; white-space: pre-wrap;">${d.bookContents}</div>
										</td>
									</tr>
								</tbody>
							</table>

							<div class="d-flex justify-content-between mt-4">
								<div class="d-flex">
									<c:choose>
								        <c:when test="${d.bookStatus eq '대출가능'}">
								            <button type="button" class="btn btn-primary" id="rentBtn" data-bn="${d.bookNum}">대출하기</button>
								        </c:when>

								        <c:when test="${d.bookStatus eq '대출중'}">
								            <c:choose>
								                <c:when test="${not empty member and d.rentDTO.username eq member.username}">
								                    <button type="button" class="btn btn-warning font-weight-bold return-btn" data-bn="${d.bookNum}">반납하기</button>
								                </c:when>
								                <c:otherwise>
								                    <button type="button" class="btn btn-secondary" disabled>대출 중</button>
								                </c:otherwise>
								            </c:choose>
								        </c:when>
								        
								        <c:otherwise>
								            <button type="button" class="btn btn-secondary" disabled>대출 불가</button>
								        </c:otherwise>
								    </c:choose>

									<c:choose>
							            <c:when test="${param.from eq 'wishlist'}">
							                <a href="/wishlist/list?page=${pager.page}&kind=${pager.kind}&search=${pager.search}"
							                   class="btn btn-primary"> 목록으로 </a>
							            </c:when>
							            <c:otherwise>
							                <a href="./list?page=${pager.page}&kind=${pager.kind}&search=${pager.search}"
							                   class="btn btn-primary"> 목록으로 </a>
							            </c:otherwise>
							        </c:choose>

								</div>
								<div class="d-flex">
									<c:if test="${param.from ne 'wishlist'}">
								        <a class="btn btn-info mr-2" href="./update?bookNum=${d.bookNum}&page=${pager.page}&kind=${pager.kind}&search=${pager.search}">수정</a>
								    </c:if>

									<c:choose>
								        <c:when test="${param.from eq 'wishlist'}">
								            <form action="/wishlist/delete" method="post" class="mb-0" onsubmit="return confirm('찜 목록에서 삭제하시겠습니까?');">
								                <input type="hidden" name="bookNum" value="${d.bookNum}">
								                <button type="submit" class="btn btn-warning mr-3">찜 취소</button>
								            </form>
								        </c:when>
								        <c:otherwise>
								            <form action="./delete" method="post" class="mb-0" onsubmit="return confirm('정말 삭제하시겠습니까?');">
								                <input type="hidden" name="bookNum" value="${d.bookNum}">
								                <button type="submit" class="btn btn-danger mr-2">삭제</button>
								            </form>
								            <button class="btn btn-info mr-3" id="create" data-pn="${d.bookNum}">찜 하기</button>
								        </c:otherwise>
								    </c:choose>
								</div>
							</div>
						</div>
					</div>
					<hr class="my-5">
					<div class="row justify-content-center">
						<!-- 중앙 정렬 -->
						<div class="col-lg-6">
							<!-- 가로 너비를 적당히 제한 (전체 12 중 10 사용) -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">도서 후기(리뷰)</h6>
								</div>
								<div class="card-body">
									<!-- 댓글 리스트 영역 -->
									<div id="review_list" class="mb-4">
										<p class="text-center text-muted">등록된 댓글이 없습니다.</p>
									</div>

									<!-- 댓글 입력 영역 -->
									<div class="border-top pt-3">
										<c:choose>
											<c:when test="${canReview}">
												<div class="form-row align-items-center mb-2">
													<div class="col-auto">
														<label for="review_rating" class="mb-0 font-weight-bold text-small">별점</label>
													</div>
													<div class="col-md-2 col-4">
														<select class="form-control form-control-sm" id="review_rating">
															<option value="5">★★★★★</option>
															<option value="4">★★★★☆</option>
															<option value="3">★★★☆☆</option>
															<option value="2">★★☆☆☆</option>
															<option value="1">★☆☆☆☆</option>
															<option value="0">☆☆☆☆☆</option>
														</select>
													</div>
												</div>

												<div class="form-group mb-0">
													<textarea id="review_contents" class="form-control" rows="3"
														placeholder="리뷰를 남겨주세요."></textarea>
													<div class="text-right mt-2">
														<!-- 버튼을 오른쪽 아래로 배치하여 가로 부담 감소 -->
														<button class="btn btn-primary btn-sm px-4" type="button"
															id="review_add">리뷰 등록</button>
													</div>
												</div>
											</c:when>
											
											<c:otherwise>
												<div class="bg-light p-3 text-center rounded">
									                <p class="mb-0 text-muted">
									                    <i class="fas fa-info-circle"></i> 
									                    이 도서를 대출했던 회원만 리뷰를 작성할 수 있습니다.
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
				<!-- end content -->
				<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
			</div>
			<!-- end content-wrapper -->
		</div>
		<!-- end wrapper -->
		<div>
			<div class="modal fade" id="review_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">댓글 수정</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <label for="review_rating" class="mb-0 mr-2 font-weight-bold">평점 : </label>
						<select class="form-control col-4" id="rating_update">
							<option value="5">★★★★★</option>
							<option value="4">★★★★☆</option>
							<option value="3">★★★☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="1">★☆☆☆☆</option>
							<option value="0">☆☆☆☆☆</option>
						</select>
			        <textarea class="col-12 mt-2" rows="5" id="contents_update"></textarea>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			        <button type="button" class="btn btn-primary" id="update_save">수정</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
		<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
		
		<script src="/js/book/review.js"></script>
		<script src="/js/book/rent.js"></script>
</body>
</html>