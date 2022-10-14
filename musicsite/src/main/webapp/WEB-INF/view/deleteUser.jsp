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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js_css_img/css/style.css">
</head>
<body>
	회원탈퇴
	<div class="container-loginout m-auto">
		<form class="row g-3" id="f"
			action="${pageContext.request.contextPath}/user/deleteuserpro"
			method="post">
			<div class="form-floating">
				<input type="password" class="form-control" id="userPass"
					placeholder="Password" name="userPass" maxlength="15"> <label
					for="floatingPassword">비밀번호</label>
			</div>
		</form>
		<div class="col-auto">
			<button type="button" class="btn btn-primary mb-3" onclick="deleteUser()">탈퇴</button>
		</div>

	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		function deleteUser() {
			var userPass = document.getElementById("userPass").value
			var url = "${pageContext.request.contextPath}/user/checkpass?userPass="+userPass
			fetch(url)
			.then(res=>res.text())
			.then(text=>{
				if(text==0){
					document.getElementById("f").submit()
				}else if(text==1){
					alert("비밀번호를 틀렸습니다.")
					return
				}
			})
		}
	</script>
</body>
</html>