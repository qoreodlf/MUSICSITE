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
	join
	<div class="container-loginout m-auto">
		<form class="row g-3" id="f"
			action="${pageContext.request.contextPath}/user/joinpro"
			method="post">
			<div class="form-floating">
				<input type="text" class="form-control" id="userEmail"
					placeholder="name@example.com" name="userEmail" maxlength="40"> <label
					for="floatingInput">Email address</label>
					<button type="button" onclick="chkHasEmail()">이메일 중복확인</button>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="userNickname"
					placeholder="name@example.com" name="userNickname" maxlength="10"> <label
					for="floatingInput">Nickname</label>
					<button type="button" onclick="chkHasNickname()">닉네임 중복확인</button>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="userPass"
					placeholder="Password" name="userPass" maxlength="15"> <label
					for="floatingPassword">Password</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="userPass2"
					placeholder="Password" name="userPass2" maxlength="15"> <label
					for="floatingPassword">Password 확인</label>
			</div>
			
			<div class="col-auto">
				<button type="button" class="btn btn-primary mb-3" onclick="join()">가입</button>
			</div>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		var chkEmil = 1
		var chkNickname = 1
		
		document.getElementById("userEmail").addEventListener("change", function() {
			chkEmil=1;
		})
		
		
		document.getElementById("userNickname").addEventListener('change', function() {
			chkNickname=1
		})

		
		function chkHasEmail() {
			var userEmail = document.getElementById("userEmail").value
			if(userEmail == null || userEmail == ""){
				alert("이메일을 입력해 주세요.")
				return
			}
			var url = "${pageContext.request.contextPath}/user/checkhasemail?userEmail="+userEmail
			fetch(url)
			.then(res=>res.text())
			.then(text=>{
				console.log(text)
				chkEmil = text
				if(text==0){
					alert("사용 가능한 이메일 입니다.")
				}else if(text==1)
					alert("이미 가입된 이메일 입니다.")
			})
		}
		function chkHasNickname() {
			var userNickname = document.getElementById("userNickname").value
			if(userNickname == null || userNickname == ""){
				alert("닉네임 입력해 주세요.")
				return
			}
			var url = "${pageContext.request.contextPath}/user/checkhasnickname?userNickname="+userNickname
			fetch(url)
			.then(res=>res.text())
			.then(text=>{
				console.log(text)
				chkNickname = text
				if(text==0){
					alert("사용 가능한 닉네임 입니다.")
				}else if(text==1)
					alert("중복되는 닉네임 입니다.")
			})
		}
		
		function join() {
			if(chkEmil == 1){
				alert("이메일 중복을 확인해주세요")
				return
			}
			if(chkNickname == 1){
				alert("닉네임 중복을 확인해주세요")
				return
			}
			
			var pass1 = document.getElementById("userPass").value
			var pass2 = document.getElementById("userPass2").value
			if(pass1 != pass2){
				alert("비밀번호가 일치하지 않습니다.")
				return
			}
			document.getElementById("f").submit()

		}
	</script>
</body>
</html>