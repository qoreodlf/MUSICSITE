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

		<label for="exampleDataList" class="form-label">Add Single</label> <input
			class="form-control" list="albumlist" id="sch_artist"
			placeholder="artist name"> <input class="form-control"
			list="albumlist" id="sch_track" placeholder="single name">
		<button class="btn btn-secondary" onclick="searchTrack()">검색</button>
		<h4 id="artist_"></h4>
		<h2 id="track"></h2>
		<h4>
			<span class="badge bg-secondary" id="albumtime"></span>
		</h4>
		<div>
			<img alt="" src="" id="albumImg">
		</div>
		<ol class="list-group list-group-numbered" id="tracklist">

		</ol>

		<form id="addSinglePro"
			action="${pageContext.request.contextPath}/board/addsingleboardpro"
			method="post">                                  
			<input type="hidden" id="addSingle" name="title"> <input
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
	function searchTrack() {
		var artist = document.getElementById("sch_artist").value
		var track = document.getElementById("sch_track").value
		fetch(" http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist="+artist+"&track="+track+"&format=json")
		.then(res=>res.json())
		.then(json=>{
			if(json.message=="Track not found" || json.message=="Invalid parameters - Your request is missing a required parameter"){
				alert("검색어를 확인해주세요")
			}
			console.log(json)
			var artist = json.track.artist.name
			var track = json.track.name
			
			document.getElementById("artist_").innerHTML = artist
			document.getElementById("track").innerHTML = track
			document.getElementById("albumImg").src = json.track.album.image[3]["#text"]
			
			document.getElementById("addArtist").value = artist
			document.getElementById("addSingle").value = track
			
			var a = ""
	
			var time = hms(json.track.duration)
			a += '<li class="list-group-item d-flex justify-content-between align-items-start"><div class="ms-2 me-auto">'
			a += '<div class="fw-bold">'+artist+'</div>'+track				
			a += '</div> <span class="badge bg-primary rounded-pill">'+time+'</span>'
			a += '<div id="urldiv"></div>'
			hasURL(artist, track)
			a += '</li>'
			
			document.getElementById("tracklist").innerHTML = a
		})
	}
	
	function addSingleTitle() {
		if (document.getElementById("artist") !== null){
			var artist = document.getElementById("artist").value
			var title = document.getElementById("title").value
			var URL = document.getElementById("URL").value
			var suburl = "${pageContext.request.contextPath}/board/addsingletitle?artist="+artist+"&title="+title+"&URL="+URL
			fetch(suburl)
		}
		
		document.getElementById("addSinglePro").submit();
	}
	
</script>
</html>