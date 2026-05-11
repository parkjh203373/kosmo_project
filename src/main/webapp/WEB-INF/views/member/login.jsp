<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h2>로그인 홈페이지</h2>
	</div>
	
	<form method="post">
		<div class="form-group">
			<label for="username">아이디</label> 
			<input type="text" name="username" class="form-control" id="username"> 
		</div>
		
		<div class="form-group">
			<label for="password">비밀번호</label> 
			<input type="password" name="password" class="form-control" id="password">
		</div>
		
		<button type="submit" class="btn btn-primary">Submit</button>
	</form>

</body>
</html>