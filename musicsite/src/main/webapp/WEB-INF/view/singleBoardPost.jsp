<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<div class="container w-50 p-3">
		<input type="hidden" id="hiddenartist" value="${sbOne.artist}">
		<input type="hidden" id="hiddensingle" value="${sbOne.title}">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col">${sbOne.artist}-${sbOne.title}</th>
					<th scope="col">${sbOne.userNickname}</th>
					<th scope="col">조회수 : ${sbOne.readcnt}</th>
					<th scope="col" id="countLike"></th>
					<th scope="col"><fmt:formatDate value="${sbOne.boardDate}"
							pattern="yyyy.MM.dd" /></th>
				</tr>
			</thead>
		</table>
		<div>
			<h4 id="artist"></h4>
			<h2 id="single"></h2>
			<div>
				<img alt="" src="" id="albumImg">
			</div>
			<ol class="list-group list-group-numbered" id="tracklist">

			</ol>
		</div>
		<div class="container" style="text-align: center">
			<button class="btn btn-light" id="likeButton" onclick="like()">추천</button>
		</div>
		<div>
			<div id="countReply" style="text-align: right;"></div>
			<div class="list-group" id="replyList"></div>
		</div>
		<form id=replyForm>
			<div class="mb-3">
				<label for="exampleFormControlTextarea1" class="form-label">댓글
					작성</label>
				<textarea class="form-control" id="replyText" rows="3"></textarea>
			</div>
			<button type="button" class="btn btn-light" id=""
				onclick="addReply()">댓글 등록</button>
		</form>
	</div>

	<input type="hidden" id="playingVideoId">
	<div id="video" style="position: fixed;"></div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script src="https://www.youtube.com/iframe_api"></script>

<script type="text/javascript">
	var artist = "${sbOne.artist}"
	var track = "${sbOne.title}" 
	
	function loadSingle() {
		
		fetch(" http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist="+artist+"&track="+track+"&format=json")
		.then(res=>res.json())
		.then(json=>{
			console.log(json)
			var artist = json.track.artist.name
			var title = json.track.name
			document.getElementById("artist").innerHTML = artist
			document.getElementById("single").innerHTML = title
			
			document.getElementById("albumImg").src = json.track.album.image[3]["#text"]
			
			var a = ""
				
					
					var time = hms(json.track.duration)
					a += '<li class="list-group-item d-flex justify-content-between align-items-start">'
					a += '<div class="ms-2 me-auto" id="track">'
					a += '<div class="fw-bold">'+artist+'</div>'+title +'</div>'
					a += '<div id="playButton"></div>'
					a += '<span class="badge bg-primary rounded-pill">'+time+'</span>'	
					a += '<input type="hidden" id="videoId">'
					a += '</li>'
					getSingleTitle(artist, title, "")
				
			document.getElementById("tracklist").innerHTML = a
		})
	}
	
	var playList=[] //트랙정보 담기는 배열
	var player //youtube iframe 만들어지는 변수
	var nowindex //var playList에서 현재 재생중인 인덱스

	var userEmail = "${sessionScope.userEmail}"
	var boardNo = "${sbOne.no}"
	
	var boardType = "mb"
	
	var modaldiv = null //댓글수정하는모달
	
	

	
	
	window.onload=loadSingle()
	window.onload=countLike()
	window.onload=countReply()
	window.onload=replyList()
</script>
</html>