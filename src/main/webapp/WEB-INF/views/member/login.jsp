<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <title>로그인 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	
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