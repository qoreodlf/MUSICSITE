<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://www.youtube.com/iframe_api"></script>
</head>
<%@include file="/WEB-INF/view/layer/header.jsp"%>
<body>
	<div class="ytVideo" id="video"></div>
	<div class="container-main">
		<input type="hidden" id="hiddenartist" value="${mbOne.artist}">
		<input type="hidden" id="hiddenalbum" value="${mbOne.title}">
		<c:if test="${mbOne.bdType eq 's'}">
			<h3>싱글 게시판</h3>
		</c:if>
		<c:if test="${mbOne.bdType eq 'a'}">
			<h3>앨범 게시판</h3>
		</c:if>
		<c:if test="${mbOne.bdType eq 'l'}">
			<h3>라이브 게시판</h3>
		</c:if>
		<c:if test="${mbOne.bdType eq 'm'}">
			<h3>뮤직비디오 게시판</h3>
		</c:if>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col"><c:if
							test="${mbOne.bdType eq 'a' || mbOne.bdType eq 's'}">
					${mbOne.artist}-${mbOne.title}
					</c:if> <c:if test="${mbOne.bdType eq 'l'  || mbOne.bdType eq 'm'}">
					${mbOne.title}
					</c:if></th>
					<th scope="col">${mbOne.userNickname}</th>
					<th scope="col">조회수 : ${mbOne.readcnt}</th>
					<th scope="col" id="countLike"></th>
					<th scope="col"><fmt:formatDate value="${mbOne.boardDate}"
							pattern="yyyy.MM.dd" /></th>
				</tr>
			</thead>
		</table>
		<div>
			<c:if test="${mbOne.bdType eq 'a' || mbOne.bdType eq 's'}">
				<div class="row">
					<div class="col">

						<div class="hasMarg">
							<h4 id="artist"></h4>
							<h2 id="title"></h2>
							<pre>${mbOne.bdText}</pre>
						</div>
					</div>
					<div class="col center">
						<c:if test="${mbOne.bdType eq 'a'}">
							<div class="row">
								<div class="hasMarg hstack gap-1">
									<button class="btn btn-secondary" onclick="previousmusic()">pre</button>
									<button class="btn btn-secondary" onclick="playalbum()">play
										album</button>
									<button class="btn btn-secondary" onclick="nextmusic()">next</button>

									<h4>
										<span class="badge bg-secondary ms-auto" id="albumtime"></span>
									</h4>
								</div>
							</div>
						</c:if>
						<img class="rounded" alt="" src="" id="albumImg">
					</div>
				</div>
				<div class="hasMarg">
					<ol class="list-group list-group-numbered" id="tracklist">

					</ol>
				</div>
			</c:if>
			<c:if test="${mbOne.bdType eq 'l' || mbOne.bdType eq 'm'}">
				<div class="row">
					<pre>${mbOne.bdText}</pre>
					<input type="hidden" id="videoURL" value="${mbOne.url}">
				</div>
				<br>
				<div class="row">
					<div id="livevideo"></div>

				</div>
				<br>
			</c:if>
		</div>
		<div class="container" style="text-align: center">
			<button class="btn btn-light" id="likeButton" onclick="like()">추천</button>
		</div>
		<div>
			<div id="countReply" style="text-align: right;"></div>
			<div class="list-group hasMarg" id="replyList"></div>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center" id="replyPageing">
				</ul>
			</nav>
		</div>
		<form id=replyForm>
			<div class="mb-3 hasMarg">
				<label for="exampleFormControlTextarea1" class="form-label">댓글
					작성</label>
				<textarea class="form-control" id="replyText" rows="3"></textarea>
			</div>
			<div class="mb-3 hasMarg">
				<button type="button" class="btn btn-light rightButton" id=""
					onclick="addReply()">댓글 등록</button>
			</div>

		</form>

	</div>

	<input type="hidden" id="playingVideoId">

</body>
<content tag="local_script"> <script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script type="text/javascript">
	var artist = "${mbOne.artist}"
	var title = "${mbOne.title}"

	var playList = [] //트랙정보 담기는 배열
	var player //youtube iframe 만들어지는 변수
	var nowindex //var playList에서 현재 재생중인 인덱스

	var userEmail = "${sessionScope.userEmail}"
	var boardNo = "${mbOne.no}"

	var boardType = "mb"

	var modaldiv = null //댓글수정하는모달

	if ("${mbOne.bdType}" == 'a') {
		window.onload = loadAlbum()
	} else if ("${mbOne.bdType}" == 's') {
		window.onload = loadSingle()
	} else if ("${mbOne.bdType}" == 'l' || "${mbOne.bdType}" == 'm') {
		window.onload = loadLiveVideo()
	}

	window.onload = countLike()
	window.onload = countReply()
	window.onload = replyList('1')
</script> </content>
</html>