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
		<input type="hidden" id="hiddenartist" value="${abOne.artist}">
		<input type="hidden" id="hiddenalbum" value="${abOne.album}">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col">${abOne.artist}-${abOne.album}</th>
					<th scope="col">${abOne.userNickname}</th>
					<th scope="col">(추천수)</th>
					<th scope="col"><fmt:formatDate value="${abOne.boardDate}"
							pattern="yyyy.MM.dd" /></th>
				</tr>
			</thead>
		</table>
		<div>
		<button onclick="previousmusic()">pre</button>
		<button onclick="nextmusic()">next</button>
			<h4 id="artist"></h4>
			<h2 id="album"></h2><button onclick="playalbum()">play album</button>
			<h4>
				<span class="badge bg-secondary" id="albumtime"></span>
			</h4>
			<div>
				<img alt="" src="" id="albumImg">
			</div>
			<ol class="list-group list-group-numbered" id="tracklist">

			</ol>
		</div>
	</div>
	<input type="hidden" id="playingVideoId">
	<div id="video"></div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script src="https://www.youtube.com/iframe_api"></script>
<script type="text/javascript">
	var artist = "${abOne.artist}"
	var album = "${abOne.album}"

	function loadAlbum() {
		
		fetch(" http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist="+artist+"&album="+album+"&format=json")
		.then(res=>res.json())
		.then(json=>{
			document.getElementById("artist").innerHTML = json.album.artist
			document.getElementById("album").innerHTML = json.album.name
			
			var albumtime = 0
			for(var i = 0; i<json.album.tracks.track.length; i++){
				albumtime += json.album.tracks.track[i].duration
			}
			console.log(hms(albumtime))
			document.getElementById("albumtime").innerHTML = hms(albumtime)
			document.getElementById("albumImg").src = json.album.image[3]["#text"]
			
			var a = ""
				for(var i = 0; i<json.album.tracks.track.length; i++){
					var artist = json.album.tracks.track[i].artist.name
					var title = json.album.tracks.track[i].name
					var time = hms(json.album.tracks.track[i].duration)
					a += '<li class="list-group-item d-flex justify-content-between align-items-start">'
					a += '<div class="ms-2 me-auto" id="track'+i+'">'
					a += '<div class="fw-bold">'+artist+'</div>'+title
					a += '</div> <span class="badge bg-primary rounded-pill">'+time+'</span>'
					a += '<div id="playButton'+i+'"></div>'
					a += '<input type="hidden" id="videoId'+i+'">'
					a += '</li>'
					getSingleTitle(artist, title, i)
				}
			document.getElementById("tracklist").innerHTML = a
		})
	}
	
	var playList=[]
	
	function getSingleTitle(artist, title, i) {
		var url = '${pageContext.request.contextPath}/board/getsingletitle?artist='+artist+'&title='+title
		fetch(url).then(res=>res.json())
		.then(json=>{
			document.getElementById("videoId"+i).value = json.videoId
			if(json.url != null){
				var a = '<button type="button" onclick="playmusic('+i+')"><img src="" >play</button>'
				document.getElementById("playButton"+i).innerHTML = a
				
				var trackinfo = {
						videoId : json.videoId, 
						artist : json.artist, 
						title : json.title
						}
				playList.push(trackinfo)
			}
		}) 
	}
	
	var player
	var nowindex
	function playmusic(i) {
		nowindex = playList.findIndex(obj => obj.videoId == document.getElementById("videoId"+i).value)	
		makeplayer(nowindex)
	}
	
	function playalbum() {
		nowindex = 0
		makeplayer(nowindex)
	}
	
	function nextmusic() {
		if(nowindex < playList.length-1){
			nowindex +=1
			makeplayer(nowindex)
		} else{
			alert("마지막 곡입니다")
		}
	}
	
	function previousmusic() {
		if(nowindex > 0){
			nowindex -=1
			makeplayer(nowindex)
		}else{
			alert("첫 곡입니다")
		}
	}
	
	function makeplayer(nowindex) {
		document.getElementById("video").innerHTML = '<div><button onclick="closemusic()">X</button></div><div id="player"></div>';
		player = new YT.Player('player', {
            height: '390',
            width: '640',
            videoId: playList[nowindex].videoId,
            events: {
                'onReady': e => e.target.playVideo(),
                'onStateChange': onPlayerStateChange
            }
		})
	}
	
	function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.ENDED) {
        	nextmusic()
        }
      }
	
	

	function closemusic() {
		player.destroy()
	}
	
	window.onload=loadAlbum()
</script>

</html>