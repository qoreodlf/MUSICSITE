<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	join
	<div>
		<form class="row g-3"
			action="${pageContext.request.contextPath}/user/joinpro"
			method="post">
			<div class="col-auto">
				<label for="inputPassword2" class="visually-hidden"></label> <input
					type="email" class="form-control" placeholder="email" name="userEmail">
			</div>
			<div class="col-auto">
				<label for="inputPassword2" class="visually-hidden"></label> <input
					type="text" class="form-control" placeholder="nickname" name=userNickname>
			</div>
			<div class="col-auto">
				<label for="inputPassword2" class="visually-hidden"></label> <input
					type="password" class="form-control" placeholder="Password" name=userPass>
			</div>
			<div class="col-auto">
				<button type="submit" class="btn btn-primary mb-3">가입</button>
			</div>
		</form>
	</div>
</body>
</html>