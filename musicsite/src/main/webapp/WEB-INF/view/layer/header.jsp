<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<header class="p-3 text-bg-dark">
		<div class="container">
			<div
				class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
				<a href="/"
					class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
					<svg class="bi me-2" width="40" height="32" role="img"
						aria-label="Bootstrap">
						<use xlink:href="#bootstrap"></use></svg>
				</a>
				<ul
					class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li><a href="${pageContext.request.contextPath}/"
						class="nav-link px-2 text-secondary">Home</a></li>
					<li><a
						href="${pageContext.request.contextPath}/board/musicboard?bdType=a&nowPage=1"
						class="nav-link px-2 text-white">앨범 게시판</a></li>
					<li><a
						href="${pageContext.request.contextPath}/board/musicboard?bdType=s&nowPage=1"
						class="nav-link px-2 text-white">싱글 게시판</a></li>
					<li><a
						href="${pageContext.request.contextPath}/board/musicboard?bdType=l&nowPage=1"
						class="nav-link px-2 text-white">라이브 게시판</a></li>
					<li><a
						href="${pageContext.request.contextPath}/board/musicboard?bdType=m&nowPage=1"
						class="nav-link px-2 text-white">뮤직비디오 게시판</a></li>

				</ul>

				<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
					<input type="search"
						class="form-control form-control-dark text-bg-dark"
						placeholder="Search..." aria-label="Search">
				</form>

				<div class="text-end">
					<c:if test="${sessionScope.loginUser eq null }">
						<button type="button" class="btn btn-outline-light me-2"
							onclick="location.href='${pageContext.request.contextPath}/user/login'">Login</button>
						<button type="button" class="btn btn-warning"
							onclick="location.href='${pageContext.request.contextPath}/user/join'">Sign-up</button>
					</c:if>
					<c:if test="${sessionScope.loginUser ne null }">
						<a href="${pageContext.request.contextPath}/user/mypage">My
							page(${sessionScope.loginUser.userNickname})</a> &nbsp;&nbsp;
						<button type="button" class="btn btn-warning"
							onclick="location.href='${pageContext.request.contextPath}/user/logout'">Logout</button>
					</c:if>
				</div>
			</div>
		</div>
	</header>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>