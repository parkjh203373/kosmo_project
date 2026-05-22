<%-- 상단에 세션 정보를 쉽게 사용하기 위해 추가 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
    <c:when test="${not empty list}">
        <div class="d-flex flex-column gap-3">
            <c:forEach items="${list}" var="dto">
                <div class="p-3 mb-3 bg-white shadow-sm transition-hover" style="border-radius: 12px; border: 1px solid #edf2f7;">
                    <div class="d-flex justify-content-between align-items-start">
                        
                        <div class="flex-grow-1 pr-3">
                            <div class="d-flex align-items-center flex-wrap mb-2">
                                <span class="font-weight-bold text-gray-900 mr-2" style="font-size: 0.95rem;">
                                    <i class="fas fa-user-circle text-gray-400 mr-1"></i>${dto.username}
                                </span>
                                
                                <span class="text-warning small d-flex align-items-center" style="letter-spacing: -1px;">
                                    <c:forEach begin="1" end="${dto.reviewRating}"><i class="fas fa-star mr-0.5"></i></c:forEach>
                                    <c:forEach begin="1" end="${5 - dto.reviewRating}"><i class="far fa-star mr-0.5" style="color: #cbd5e0;"></i></c:forEach>
                                    <span class="text-muted small ml-1 font-weight-medium">(${dto.reviewRating})</span>
                                </span>
                            </div>
                            
                            <div class="text-secondary mt-1" style="font-size: 0.92rem; line-height: 1.6; white-space: pre-wrap;">${dto.reviewContents}</div>
                        </div>
                        
                        <div class="d-flex flex-column align-items-end justify-content-between text-right" style="min-width: 140px; min-height: 65px;">
                            <span class="text-muted font-weight-medium px-2 py-1 rounded-pill bg-light" style="font-size: 0.75rem; letter-spacing: -0.3px;">
                                <i class="far fa-clock text-xs mr-1"></i>${dto.reviewDate.toString().replace('T', ' ').substring(0, 16)}
                            </span>
                            
                            <c:if test="${not empty member and member.username eq dto.username}">
                                <div class="btn-group btn-group-sm mt-2" style="border-radius: 6px; overflow: hidden;">
                                    <button type="button" class="btn btn-light text-secondary border-right review_update font-weight-bold px-2" 
                                        data-contents="${dto.reviewContents}" 
                                        data-num="${dto.reviewNum}" 
                                        data-rating="${dto.reviewRating}" 
                                        data-toggle="modal" 
                                        data-target="#review_modal"
                                        style="font-size: 0.75rem; background-color: #f8fafc;">
                                        <i class="fas fa-edit text-xs mr-1"></i>수정
                                    </button>
                                    <button type="button" class="btn btn-light text-danger review_del font-weight-bold px-2" 
                                        data-num="${dto.reviewNum}"
                                        style="font-size: 0.75rem; background-color: #f8fafc;">
                                        <i class="far fa-trash-alt text-xs mr-1"></i>삭제
                                    </button>
                                </div>
                            </</c:if>
                        </div>
                        
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="text-center py-5 rounded-lg bg-white shadow-sm border border-dashed" style="border-radius: 12px; border-style: dashed !important; border-color: #e2e8f0 !important;">
            <i class="far fa-comment-dots fa-2x text-gray-300 mb-2"></i>
            <p class="text-muted small mb-0 font-weight-medium">아직 등록된 도서 리뷰가 존재하지 않습니다.</p>
            <span class="text-xs text-light-muted">첫 번째 감상평을 남겨보세요.</span>
        </div>
    </c:otherwise>
</c:choose>