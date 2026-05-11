<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <title>마이 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<div>
		<h2>마이 페이지</h2>
	</div>
	
	<div>
		<img src="/files/member/${member.profileDTO.fileName}" class="rounded mx-auto d-block" alt="프로필 이미지">
		
		<div class="form-group">
			<label for="username">아이디</label> 
			<input type="text" class="form-control" name="username" id="username" value="${member.username}"> 
		</div>
		
		<div class="form-group">
			<label for="password">비밀번호</label> 
			<input type="password" class="form-control" name="password" id="password">
		</div>
		
		<div class="form-group">
			<label for="memberName">이름</label> 
			<input type="text" class="form-control" name="memberName" id="memberName" value="${member.memberName}"> 
		</div>

		<div class="form-group">
			<label for="memberBirth">생년월일</label> 
			<input type="date" class="form-control" name="memberBirth" id="memberBirth" value="${member.memberBirth}">
		</div>
		<div class="form-group">
			<label for="memberEmail">이메일 주소</label> 
			<input type="email" class="form-control" name="memberEmail" id="memberEmail" value="${member.memberEmail}"> 
		</div>
		
		<a href="./update" class="btn btn-success">정보 수정</a>
		<a href="./delete" class="btn btn-danger">회원 탈퇴</a>
		<a href="./logout" class="btn btn-info">로그아웃</a>
	</div>
	
</body>
</html>