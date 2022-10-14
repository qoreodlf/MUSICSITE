<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/view/layer/header.jsp"%>
	<div class="conainer-index">
		<div class="row" style="margin: 10px">
			<div class="container-main">
				<div class="row">
					<h3>${loginUser.userNickname}<span class="badge bg-secondary">Lv.</span>
					</h3>
				</div>
				<div class="row">
					<table>
						<thead>
							<tr>
								<th scope="col"><a
									href="${pageContext.request.contextPath}/user/updatenickname">닉네임
										변경</a></th>
								<th scope="col"><a
									href="${pageContext.request.contextPath}/user/updatepass">비밀번호
										변경</a></th>
								<th scope="col"><a
									href="${pageContext.request.contextPath}/user/deleteuser">회원탈퇴</a></th>
							</tr>
						</thead>
					</table>

				</div>
			</div>


		</div>
		<br>
		<div class="row" style="margin: 10px">
			<div class="col hasMarg2">
				<div class="row">
					<div class="col-9">
						<h3>내가 작성한 글</h3>
					</div>

				</div>
				<div class="row hasMarg">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="home-tab"
								data-bs-toggle="tab" data-bs-target="#" type="button" role="tab"
								aria-controls="home-tab-pane" aria-selected="true"
								onclick="myBoard('a','1')">앨범</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
								data-bs-target="#" type="button" role="tab"
								aria-controls="profile-tab-pane" aria-selected="false"
								onclick="myBoard('s','1')">싱글</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
								data-bs-target="#" type="button" role="tab"
								aria-controls="contact-tab-pane" aria-selected="false"
								onclick="myBoard('l','1')">라이브</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
								data-bs-target="#" type="button" role="tab"
								aria-controls="contact-tab-pane" aria-selected="false"
								onclick="myBoard('m','1')">뮤직비디오</button>
						</li>

					</ul>
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" role="tabpanel"
							aria-labelledby="home-tab" tabindex="0">
							<table class="table table-hover">
								<thead>
									<tr>
										<th scope="col" style="width: 60%">제목</th>
										<th scope="col">조회수</th>
										<th scope="col">추천</th>
										<th scope="col">작성날짜</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="myBoard">

								</tbody>
							</table>
							<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center"
									id="myboardPageing">
								</ul>
							</nav>
						</div>
					</div>

				</div>
			</div>

			<div class="col hasMarg2">
				<div class="row">
					<div class="col-9">
						<h3>추천 누른 게시글</h3>
					</div>
				</div>
				<div class="row hasMarg">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="home-tab"
								data-bs-toggle="tab" data-bs-target="#" type="button" role="tab"
								aria-controls="home-tab-pane" aria-selected="true"
								onclick="myLikeBoard('a','1')">앨범</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
								data-bs-target="#" type="button" role="tab"
								aria-controls="profile-tab-pane" aria-selected="false"
								onclick="myLikeBoard('s','1')">싱글</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
								data-bs-target="#" type="button" role="tab"
								aria-controls="contact-tab-pane" aria-selected="false"
								onclick="myLikeBoard('l','1')">라이브</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
								data-bs-target="#" type="button" role="tab"
								aria-controls="contact-tab-pane" aria-selected="false"
								onclick="myLikeBoard('m','1')">뮤직비디오</button>
						</li>

					</ul>
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="likealbum"
							role="tabpanel" aria-labelledby="home-tab" tabindex="0">
							<table class="table table-hover">
								<thead>
									<tr>
										<th scope="col" style="width: 60%">제목</th>
										<th scope="col">조회수</th>
										<th scope="col">추천</th>
										<th scope="col">작성자</th>
									</tr>
								</thead>
								<tbody class="table-group-divider" id="myLikeBoard">

								</tbody>
							</table>
							<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center"
									id="mylikeboardPageing">
								</ul>
							</nav>
						</div>

					</div>

				</div>
			</div>
		</div>

	</div>

</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script type="text/javascript">
	window.onload = myBoard('a', '1')
	window.onload = myLikeBoard('a', '1')
</script>
</html>