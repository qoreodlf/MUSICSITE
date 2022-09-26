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
	<div class="container w-50 p-3">

		<label for="exampleDataList" class="form-label">Add Album</label> <input
			class="form-control" list="albumlist" id="sch_artist"
			placeholder="artist name"> <input class="form-control"
			list="albumlist" id="sch_album" placeholder="album name">
		<button class="btn btn-secondary" onclick="searchAlbum()">검색</button>
		<h4 id="artist"></h4>
		<h2 id="album"></h2>
		<h4>
			<span class="badge bg-secondary" id="albumtime"></span>
		</h4>
		<div>
			<img alt="" src="" id="albumImg">
		</div>
		<ol class="list-group list-group-numbered" id="tracklist">

		</ol>

		<form id="addAlbumPro"
			action="${pageContext.request.contextPath}/board/addalbumboardpro"
			method="post">
			<input type="hidden" id="addAlbum" name="title"> <input
				type="hidden" id="addArtist" name="artist">
			<button class="btn btn-secondary" type="button" onclick="addSingleTitle()">등록</button>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script type="text/javascript">
	var numTrack = 0
	function searchAlbum() {
		var artist = document.getElementById("sch_artist").value
		var album = document.getElementById("sch_album").value
		fetch(" http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist="+artist+"&album="+album+"&format=json")
		.then(res=>res.json())
		.then(json=>{
			if(json.message=="Album not found" || json.message=="Invalid parameters - Your request is missing a required parameter"){
				alert("검색어를 확인해주세요")
			}
			console.log(json)
			document.getElementById("artist").innerHTML = json.album.artist
			document.getElementById("album").innerHTML = json.album.name
			
			document.getElementById("addArtist").value = json.album.artist
			document.getElementById("addAlbum").value = json.album.name
			
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
					a += '<li class="list-group-item d-flex justify-content-between align-items-start"><div class="ms-2 me-auto">'
					a += '<div class="fw-bold">'+artist+'</div>'+title
					a += '</div> <span class="badge bg-primary rounded-pill">'+time+'</span>'
					a += '<div id="urldiv'+i+'"></div>'
					hasURL(artist, title, i)
					a += '</li>'
					numTrack +=1
				}
			document.getElementById("tracklist").innerHTML = a
			
		})
	}
	

	
	function addSingleTitle() {
		for(var i = 0; i<numTrack; i++){
			if (document.getElementById("artist"+i) !== null){
				var artist = document.getElementById("artist"+i).value
				var title = document.getElementById("title"+i).value
				var URL = document.getElementById("URL"+i).value
				var suburl = "${pageContext.request.contextPath}/board/addsingletitle?artist="+artist+"&title="+title+"&URL="+URL
				fetch(suburl)
			}
		}
		document.getElementById("addAlbumPro").submit();
	}
	
	
</script>
</html>