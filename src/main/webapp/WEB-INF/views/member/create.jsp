<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <title>회원가입 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<form action="/member/create" method="post" enctype="multipart/form-data">
		
		<div class="form-group">
			<label for="username">아이디</label> 
			<input type="text" class="form-control" name="username" id="username"> 
		</div>
		
		<div class="form-group">
			<label for="password">비밀번호</label> 
			<input type="password" class="form-control" name="password" id="password">
		</div>
		
		<div class="form-group">
			<label for="memberName">이름</label> 
			<input type="text" class="form-control" name="memberName" id="memberName"> 
		</div>

		<div class="form-group">
			<label for="memberBirth">생년월일</label> 
			<input type="date" class="form-control" name="memberBirth" id="memberBirth">
		</div>
		<div class="form-group">
			<label for="memberEmail">이메일 주소</label> 
			<input type="email" class="form-control" name="memberEmail" id="memberEmail"> 
		</div>

		<div class="form-group">
			<label for="porfileName">프로필사진</label> 
			<input type="file" class="form-control-file" name="attach" id="porfileName">
		</div>

		<button type="submit" class="btn btn-primary">Submit</button>
		
	</form>


</body>
</html>