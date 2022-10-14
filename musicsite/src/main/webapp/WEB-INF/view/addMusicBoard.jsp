<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/view/layer/header.jsp"%>
	<div class="container-main">
		<c:if test="${param.bdType eq 'a' || param.bdType eq 's'}">
			<div class="row">
				<c:if test="${param.bdType eq 'a'}">
					<label for="exampleDataList" class="form-label"><h3>앨범
							게시판 등록</h3></label>
					<div class="addmbInput">
						<div class="hasMarg">
							<input class="form-control" list="albumlist" id="sch_artist"
								placeholder="artist name">
						</div>
						<div class="hasMarg">
							<input class="form-control" list="albumlist" id="sch_album"
								placeholder="album name">
						</div>

						<button class="btn btn-secondary rightButton"
							onclick="searchAlbum()">검색</button>

					</div>
				</c:if>
				<c:if test="${param.bdType eq 's'}">
					<label for="exampleDataList" class="form-label"><h3>싱글
							게시판 등록</h3></label>
					<div class="addmbInput">
						<div class="hasMarg">
							<input class="form-control" list="albumlist" id="sch_artist"
								placeholder="artist name">
						</div>
						<div class="hasMarg">
							<input class="form-control" list="albumlist" id="sch_track"
								placeholder="single name">
						</div>

						<button class="btn btn-secondary rightButton"
							onclick="searchTrack()">검색</button>

					</div>
				</c:if>
			</div>
			<hr>
			<div class="row">
				<div class="row">
					<div class="col">
						<div class="hasMarg">
							<h4 id="artist"></h4>
							<h2 id="title"></h2>
							<h4>
								<span class="badge bg-secondary" id="albumtime"></span>
							</h4>
						</div>
					</div>
					<div class="col center">
						<div>
							<img class="rounded" alt="" src="" id="albumImg">
						</div>
					</div>
					<div class="hasMarg">
						<ol class="list-group list-group-numbered" id="tracklist">

						</ol>
					</div>
					<div class="hasMarg">
						<form id="addMusicPro"
							action="${pageContext.request.contextPath}/board/addmusicboardpro"
							method="post">
							<input type="hidden" id="addTitle" name="title"> <input
								type="hidden" id="addArtist" name="artist"> <input
								type="hidden" name="bdType" value="${param.bdType}"> <label
								for="exampleFormControlInput1" class="form-label"><h4>음악
									소개</h4></label>
							<textarea class="form-control" id="replyText" rows="3"
								name="bdText" onkeyup="limitLength(this,100,'count1')"></textarea>
								<div id="count1"></div>
							<button class="btn btn-secondary rightButton" type="button"
								onclick="addSingleTitle()">등록</button>
						</form>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${param.bdType eq 'l' || param.bdType eq 'm'}">
			<div class="row">
				<form id="addMusicPro"
					action="${pageContext.request.contextPath}/board/addmusicboardpro">
					<label for="exampleDataList" class="form-label"> <c:if
							test="${param.bdType eq 'l'}">
							<h3>라이브 게시판 등록</h3>
						</c:if> <c:if test="${param.bdType eq 'm'}">
							<h3>뮤직비디오 게시판 등록</h3>
						</c:if>

					</label>
					<div class="">
						<div class="hasMarg row">
							<h4>제목</h4>
							<input class="form-control" placeholder="제목" name="title">
						</div>
						<br>
						<hr>
						<br>
						<div>
							<input class="form-control" list="albumlist" id="videoURL"
								name="url" placeholder="영상 Youtube URL">
						</div>

						<button class="btn btn-secondary rightButton" type="button"
							onclick="loadLiveVideo()">확인</button>
						<br>
						<div id="livevideo"></div>
						<br>
						<div>
							<label for="exampleFormControlInput1" class="form-label"><h4>영상
									소개</h4></label>
							<textarea class="form-control" id="replyText" rows="3"
								name="bdText"></textarea>
							<input type="hidden" name="bdType" value="${param.bdType}">
							<button class="btn btn-secondary rightButton" type="button" onclick="addLiveMVBoard()">등록</button>
						</div>

					</div>
				</form>
			</div>
		</c:if>
	</div>
</body>
<script src="https://www.youtube.com/iframe_api"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script type="text/javascript">
	if ("${param.bdType}" == 'a') {
		var numTrack = 0
		var bdType = 'a'
	} else if ("${param.bdType}" == 's') {
		var numTrack = 1
		var bdType = 's'
	}
</script>
</html>