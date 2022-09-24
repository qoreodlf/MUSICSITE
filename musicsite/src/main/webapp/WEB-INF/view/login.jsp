<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
	crossorigin="anonymous">
</head>
<body>
login
<div class="container">
		<form class="row g-3"
			action="${pageContext.request.contextPath}/user/loginpro"
			method="post">
			<div class="col-auto">
				<label for="inputPassword2" class="visually-hidden"></label> <input
					type="text" class="form-control" placeholder="email" name="userEmail">
			</div>
			<div class="col-auto">
				<label for="inputPassword2" class="visually-hidden"></label> <input
					type="password" class="form-control" placeholder="Password" name=userPass>
			</div>
			<div class="col-auto">
				<button type="submit" class="btn btn-primary mb-3">login</button>
			</div>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>