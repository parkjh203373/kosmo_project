<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top py-3 px-4 shadow-sm">
    <div class="container">
        <!-- 로고 디자인 (북카페 감성) -->
        <a class="navbar-brand d-flex align-items-center" href="/" style="font-weight: 700; color: #2a5c43; font-size: 1.3rem;">
            <i class="fas fa-book-open mr-2"></i> FOREST <span style="font-weight: 300; color: #718096; margin-left: 5px;">LIBRARY</span>
        </a>

        <!-- 토글 버튼 (모바일용) -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- 메인 메뉴 목록 -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
		        <li class="nav-item">
		            <a class="nav-link nav-link-custom" href="/book/list">
		                <i class="fas fa-search mr-1"></i> 도서 검색·대출
		            </a>
		        </li>
		        <li class="nav-item">
		            <a class="nav-link nav-link-custom" href="/dealboard/list">
		                <i class="fas fa-handshake mr-1"></i> 중고 도서 거래
		            </a>
		        </li>
		        
		        <c:if test="${not empty member}">
		            <li class="nav-item">
		                <a class="nav-link nav-link-custom position-relative" href="/rent/list" style="padding-right: 25px !important;">
		                    <i class="fas fa-bookmark mr-1"></i> 나의 대출 현황
		                    <c:if test="${not empty rentCount and rentCount > 0}">
		                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill" 
		                              style="background-color: #2a5c43; color: #ffffff; font-size: 0.65rem; padding: 3px 6px; mt: 4px;">
		                            ${rentCount}
		                        </span>
		                    </c:if>
		                </a>
		            </li>
		            
		            <li class="nav-item">
		                <a class="nav-link nav-link-custom position-relative text-danger" href="/wishlist/list" style="padding-right: 25px !important; color: #e53e3e !important; font-weight: 500;">
		                    <i class="fas fa-heart mr-1 text-danger" style="color: red;"></i> 관심 목록
		                    <c:if test="${not empty wishCount and wishCount > 0}">
		                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
		                              style="font-size: 0.65rem; padding: 3px 6px; mt: 4px; color: #ffffff !important; font-weight: 700;">
		                            ${wishCount}
		                        </span>
		                    </c:if>
		                </a>
		            </li>
		        </c:if>
		    </ul>

            <!-- 우측 회원 정보 / 로그인·회원가입 메뉴 -->
            <ul class="navbar-nav align-items-center">
                <c:if test="${not empty member}">
                    <!-- 연체 알림 아이콘 -->
                    <li class="nav-item dropdown no-arrow mx-2">
                        <%-- <a class="nav-link dropdown-toggle position-relative p-2" href="#" id="alertsDropdown" role="button" data-toggle="dropdown">
                            <i class="fas fa-bell text-gray-600 font-size-lg"></i>
                            <c:if test="${not empty lateCount and lateCount > 0}">
                                <span class="position-absolute badge badge-danger rounded-circle" style="top:0; right:0; font-size:0.6rem;">${lateCount}</span>
                            </c:if>
                        </a> --%>
                        
                        <c:set var="totalAlertCount" value="${fn:length(lateList) + fn:length(soldList)}" />

						<a class="dropdown-toggle position-relative p-2" href="#" id="alertsDropdown" role="button" data-toggle="dropdown">
						    <i class="fas fa-bell text-gray-600 font-size-lg"></i>
						    
						    <%-- 전체 알림 개수가 0보다 클 때만 배지 표시 --%>
						    <c:if test="${totalAlertCount > 0}">
						        <span class="position-absolute badge badge-danger rounded-circle" 
						              style="top:0; right:0; font-size:0.6rem; padding: 0.35em 0.5em;">
						            ${totalAlertCount}
						        </span>
						    </c:if>
						</a>
                        
                        <!-- 알림 드롭다운 레이아웃 -->
                        <div class="dropdown-menu dropdown-menu-right shadow-lg border-0 rounded-lg mt-3" 
     								style="min-width: 320px; max-width: 450px; width: auto;">
                            <h6 class="dropdown-header bg-light text-dark font-weight-bold py-3">새로운 알림</h6>
						<%-- 알림이 하나도 없는 경우를 체크하기 위한 변수 --%>
						    <c:set var="hasAlert" value="false" />
						
						    <%-- 1. 연체 알림 표시 --%>
						    <c:if test="${not empty lateList}">
						        <c:set var="hasAlert" value="true" />
						        <c:forEach items="${lateList}" var="l">
						            <a class="dropdown-item d-flex align-items-center py-2" href="/rent/list">
						                <div class="mr-3"><i class="fas fa-exclamation-circle text-danger"></i></div>
						                <div class="small text-truncate">[연체] '${l.bookDTO.bookTitle}' 도서가 연체되었습니다.<br>빠른 시일내에 반납해주세요.</div>
						            </a>
						        </c:forEach>
						    </c:if>
						
						    <%-- 2. 판매 완료 알림 표시 (List를 순회하여 여러 건 표시) --%>
							<c:if test="${not empty soldList}">
							    <c:set var="hasAlert" value="true" />
							    <c:forEach items="${soldList}" var="dto">
							        <a class="dropdown-item d-flex align-items-center py-3 ${not status.last ? 'border-bottom' : ''}" href="/dealboard/detail?dealboardNum=${dto.dealboardNum}">
							            <div class="mr-3"><i class="fas fa-check-circle text-success"></i></div>
							            <div class="small text-wrap">
							                <span class="font-weight-bold text-success">[판매 완료]</span><br>
							                등록하신 '${dto.dealboardTitle}'게시물의 책이 판매 완료되었습니다.
							            </div>
							        </a>
							    </c:forEach>
							</c:if>
						
						    <%-- 3. 알림이 아예 없는 경우 --%>
						    <c:if test="${not hasAlert}">
						        <div class="dropdown-item text-center text-muted small py-3">새로운 알림이 없습니다.</div>
						    </c:if>
						</div>                            
                    </li>

                    <!-- 유저 프로필 -->
                    <li class="nav-item dropdown no-arrow ml-3">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-toggle="dropdown">
                            <span class="mr-2 text-gray-700 font-weight-medium small">${member.username}님</span>
                            <c:choose>
                                <c:when test="${not empty member.profileDTO.fileName}">
                                    <img class="rounded-circle border" src="/files/member/${member.profileDTO.fileName}" width="32" height="32" style="object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <img class="rounded-circle border" src="/img/undraw_profile.svg" width="32" height="32">
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow-lg border-0 rounded-lg mt-2">
                            <a class="dropdown-item py-2" href="/member/mypage"><i class="fas fa-user fa-sm mr-2 text-gray-400"></i> 마이페이지</a>
                            <a class="dropdown-item py-2" href="/dealboard/myboard"><i class="fas fa-book-open fa-sm mr-2 text-gray-400"></i> 내가 작성한 글 목록</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item py-2 text-danger" href="#" data-toggle="modal" data-target="#logoutModal">
                                <i class="fas fa-sign-out-alt fa-sm mr-2"></i> 로그아웃
                            </a>
                        </div>
                    </li>
                </c:if>

                <c:if test="${empty member}">
                    <li class="nav-item"><a href="/member/login" class="btn btn-link text-decoration-none text-gray-700 mr-2">로그인</a></li>
                    <li class="nav-item"><a href="/member/create" class="btn btn-primary px-3 shadow-sm">회원가입</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>