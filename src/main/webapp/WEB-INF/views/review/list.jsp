<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:choose>
    <c:when test="${not empty list}">
        <ul class="list-group list-group-flush">
            <c:forEach items="${list}" var="dto">
                <li class="list-group-item d-flex justify-content-between align-items-start">
                    <div class="ms-2 me-auto">
                        <div class="fw-bold">
                        	<strong>${dto.username}</strong>
                        	<span class="text-warning ml-2">
                        	    <c:forEach begin="1" end="${dto.reviewRating}">★</c:forEach>
                        	    <c:forEach begin="1" end="${5 - dto.reviewRating}">☆</c:forEach>
                        	</span>
                        	<small class="text-muted ml-1">(${dto.reviewRating})</small>
                        </div>
                        <div class="mt-1">${dto.reviewContents}</div>
                    </div>
                    <div class="d-flex flex-column align-items-end">
                        <div class="badge bg-light text-muted mb-2">
                            ${dto.reviewDate.toString().replace('T', ' ').substring(0, 19)}
                        </div>
                        <div class="btn-group btn-group-sm">
                            <button type="button" class="btn btn-outline-secondary review_update" data-contents="${dto.reviewContents}" data-num="${dto.reviewNum}" data-rating="${dto.reviewRating}" data-toggle="modal" data-target="#review_modal">수정</button>
                            <button type="button" class="btn btn-outline-danger review_del" data-num="${dto.reviewNum}">삭제</button>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <p class="text-center text-muted">등록된 댓글이 없습니다.</p>
    </c:otherwise>
</c:choose>