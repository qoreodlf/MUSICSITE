//트랙시간 변환하는 함수
function hms(seconds) {
	var h = parseInt(seconds / 3600);
	var m = parseInt((seconds % 3600) / 60);
	var s = seconds % 60;

	var result = ""
	if (h > 0) {
		result = h + 'h ' + m + 'm ' + s + 's'
	} else {
		result = m + 'm ' + s + 's'
	}
	return result
}

//last.fm api로 앨범정보 가져오기
function loadAlbum() {
	fetch(" http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&album=" + title + "&format=json")
		.then(res => res.json())
		.then(json => {
			document.getElementById("artist").innerHTML = json.album.artist
			document.getElementById("title").innerHTML = json.album.name

			var albumtime = 0
			for (var i = 0; i < json.album.tracks.track.length; i++) {
				albumtime += json.album.tracks.track[i].duration
			}
			
			document.getElementById("albumtime").innerHTML = hms(albumtime)
			document.getElementById("albumImg").src = json.album.image[3]["#text"]

			var a = ""
			for (var i = 0; i < json.album.tracks.track.length; i++) {

				var artist = json.album.tracks.track[i].artist.name
				var title = json.album.tracks.track[i].name
				var time = hms(json.album.tracks.track[i].duration)
				a += '<li class="list-group-item d-flex justify-content-between align-items-start">'
				a += '<div class="ms-2 me-auto" id="track' + i + '">'
				a += '<div class="fw-bold">' + artist + '</div>' + title + '</div>'
				a += '<div class="playButton" id="playButton' + i + '"></div>'
				a += ' <div class="playtime"><span class="badge bg-primary rounded-pill">' + time + '</span></div>'
				a += '<input type="hidden" id="videoId' + i + '">'
				a += '</li>';


				getSingleTitle(artist, title, i) //트랙 별 정보 DB에서 가져오기
			}
			document.getElementById("tracklist").innerHTML = a


			playList.sort((a, b) => {
				if (a.i < b.i) return -1;
				if (a.i > b.i) return 1;

				return 0;
			});
		})
}


//last.fm api로 싱글정보 가져오기
function loadSingle() {
	fetch(" http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&track=" + title + "&format=json")
		.then(res => res.json())
		.then(json => {
			var artist = json.track.artist.name
			var title = json.track.name
			document.getElementById("artist").innerHTML = artist
			document.getElementById("title").innerHTML = title

			document.getElementById("albumImg").src = json.track.album.image[3]["#text"]

			var a = ""

			var time = hms(json.track.duration)
			a += '<li class="list-group-item d-flex justify-content-between align-items-start">'
			a += '<div class="ms-2 me-auto" id="track">'
			a += '<div class="fw-bold">' + artist + '</div>' + title + '</div>'
			a += '<div class="playButton" id="playButton"></div>'
			a += '<div class="playtime"><span class="badge bg-primary rounded-pill">' + time + '</span></div>'
			a += '<input type="hidden" id="videoId">'
			a += '</li>'
			
			getSingleTitle(artist, title, "") //DB에서 트랙정보 가져오기

			document.getElementById("tracklist").innerHTML = a
		})
}

//게시글 작성 시 해당 트랙의 유튜브URL 있는지 확인
//없다면 url 삽입창 추가
function hasURL(artist, title, i = "") {
	var url = getContextPath() + '/board/hasurl?artist=' + artist + '&title=' + title
	fetch(url)
		.then(res => res.text())
		.then(result => {
			if (result == 0) {
				var a = '<form id="' + i + '" action="${pageContext.request.contextPath}/board/addsingletitle">'
				a += '<input type="text" maxlength="200" class="form-control" id="URL' + i + '" placeholder="youtube URL">'
				a += '<input type = "hidden" id="artist' + i + '" value="' + artist + '">'
				a += '<input type = "hidden" id="title' + i + '" value="' + title + '"></form>'
				document.getElementById("urldiv" + i).innerHTML = a
			}
		})

}

//싱글게시판 작성 시 last.fm api에서 트랙정보 검색
function searchTrack() {
	var artist = document.getElementById("sch_artist").value
	var track = document.getElementById("sch_track").value
	fetch(" http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&track=" + track + "&format=json")
		.then(res => res.json())
		.then(json => {
			if (json.message == "Track not found" || json.message == "Invalid parameters - Your request is missing a required parameter") {
				alert("검색어를 확인해주세요")
			}
			var artist = json.track.artist.name
			var track = json.track.name

			document.getElementById("artist").innerHTML = artist
			document.getElementById("title").innerHTML = track
			document.getElementById("albumImg").src = json.track.album.image[3]["#text"]

			document.getElementById("addArtist").value = artist
			document.getElementById("addTitle").value = track

			var a = ""

			var time = hms(json.track.duration)
			a += '<li class="list-group-item d-flex justify-content-between align-items-start"><div class="ms-2 me-auto">'
			a += '<div class="fw-bold">' + artist + '</div>' + track
			a += '</div> <span class="badge bg-primary rounded-pill">' + time + '</span>'
			a += '<div id="urldiv0"></div>'
			hasURL(artist, track, 0)
			a += '</li>'

			document.getElementById("tracklist").innerHTML = a
		})
}

//앨범게시판 작성 시 last.fm api에서 앨범정보 검색
function searchAlbum() {
	var artist = document.getElementById("sch_artist").value
	var album = document.getElementById("sch_album").value
	fetch(" http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&album=" + album + "&format=json")
		.then(res => res.json())
		.then(json => {
			if (json.message == "Album not found" || json.message == "Invalid parameters - Your request is missing a required parameter" || json.album.tracks == null) {
				alert("검색어를 확인해주세요")
				return
			}
			document.getElementById("artist").innerHTML = json.album.artist
			document.getElementById("title").innerHTML = json.album.name

			document.getElementById("addArtist").value = json.album.artist
			document.getElementById("addTitle").value = json.album.name

			var albumtime = 0
			for (var i = 0; i < json.album.tracks.track.length; i++) {
				albumtime += json.album.tracks.track[i].duration
			}
			document.getElementById("albumtime").innerHTML = hms(albumtime)
			document.getElementById("albumImg").src = json.album.image[3]["#text"]

			var a = ""
			for (var i = 0; i < json.album.tracks.track.length; i++) {
				var artist = json.album.tracks.track[i].artist.name
				var title = json.album.tracks.track[i].name
				var time = hms(json.album.tracks.track[i].duration)
				a += '<li class="list-group-item d-flex justify-content-between align-items-start"><div class="ms-2 me-auto">'
				a += '<div class="fw-bold">' + artist + '</div>' + title
				a += '</div> <div class="urldiv" id="urldiv' + i + '"></div>'
				a += '<span class="badge bg-primary rounded-pill">' + time + '</span>'
				hasURL(artist, title, i)
				a += '</li>'
				numTrack += 1
			}
			document.getElementById("tracklist").innerHTML = a

		})
}

//게시물 작성하고 서브밋
function addSingleTitle() {
	if(document.getElementById("addArtist").value == "" || document.getElementById("addArtist").value == null){
		alert("음악을 추가해주세요")
		return
	}
	
	//트랙별 하나씩 addsingletitle 해줌( url 추가한 트랙은 singletitle 테이블에 저장)
	//이 후 게시글 musicboard 테이블에 저장
		
	//트랙 별 addsingletitle 해주기
	for (var i = 0; i < numTrack; i++) {
		if (document.getElementById("artist" + i) !== null) {
			var artist = document.getElementById("artist" + i).value
			var title = document.getElementById("title" + i).value
			var URL = document.getElementById("URL" + i).value
			var suburl = getContextPath() + "/board/addsingletitle?artist=" + artist + "&title=" + title + "&URL=" + URL
			fetch(suburl)
		}
	}
	
	//게시글 작성 서브밋
	document.getElementById("addMusicPro").submit();
}

//라이브보드, 뮤직비디오보드 작성시 영상등록안하거나 제목 입력안하면 리턴
function addLiveMVBoard(){
	if(document.getElementById("liveplayer" ) === null){
		alert("영상을 등록해주세요")
		return
	}
	if(document.getElementById("boardTitle").value == null || document.getElementById("boardTitle").value == ""){
		alert("제목을 입력해주세요")
		return
	}
	document.getElementById("addMusicPro").submit();
}

//ContextPath 구하는 함수
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
};

//singletitle 테이블에서 트랙정보 가져오기
function getSingleTitle(artist, title, i = "") {
	var url = getContextPath() + '/board/getsingletitle?artist=' + artist + '&title=' + title
	fetch(url).then(res => res.json())
		.then(json => {
			document.getElementById("videoId" + i).value = json.videoId
			
			//트랙에 url저장되어있으면 플레이버튼 추가하고 플레이리스트 배열에 추가
			if (json.url != null) {
				var a = '<button class="btn btn-secondary" type="button" onclick="playmusic(' + i + ')"><img src="" >play</button>'
				document.getElementById("playButton" + i).innerHTML = a

				var trackinfo = {
					i: i,
					videoId: json.videoId,
					artist: json.artist,
					title: json.title
				}
				//플레이리스트 배열에 추가
				playList.push(trackinfo)
			}
		})
}

//선택한고 플레이
function playmusic(i = "") {
	//플레이리스트 인덱스를 현재 선택한곡으로 하여 플레이
	nowindex = playList.findIndex(obj => obj.videoId == document.getElementById("videoId" + i).value)
	makeplayer(nowindex)
}

//앨범첫곡부터플레이
function playalbum() {
	//플레이리스트 인덱스를 0으로 하여 플레이
	nowindex = 0
	makeplayer(nowindex)
}

//플레이리스트 다음 인덱스 플레이
function nextmusic() {
	if (nowindex < playList.length - 1) {
		nowindex += 1
		makeplayer(nowindex)
	} else {

	}
}

//플레이리스트 이전 인덱스 플레이
function previousmusic() {
	if (nowindex > 0) {
		nowindex -= 1
		makeplayer(nowindex)
	} else {
		alert("첫 곡입니다")
	}
}

//youtube iframe api 이용하여 앨범게시판, 싱글게시판 음악플레이
function makeplayer(nowindex) {
	document.getElementById("video").innerHTML = '<div><button id = "closebutton" type="button" class="btn-close" aria-label="Close" onclick="closemusic()"></button></div><div id="player"></div>';
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

//youtube iframe api 이용하여 라이브게시판, 뮤직비디오게시판 음악플레이
function loadLiveVideo() {
	document.getElementById("livevideo").innerHTML = '<div id="liveplayer"></div>';
	var videoId = document.getElementById("videoURL").value.split("v=")[1].split("&")[0]
	window.YT.ready(function() {
		player = new YT.Player('liveplayer', {
			height: '390',
			width: '640',
			videoId: videoId,
			events: {

				'onStateChange': onPlayerStateChange
			}
		})
	})
}

//인덱스화면에서 오늘라이브,뮤직비디오 띄우는 iframe
function loadIndexVideo(divname, videoId, i) {
	document.getElementById(divname).innerHTML = '<div id="liveplayer' + i + '"></div>';
	window.YT.ready(function() {
		player = new YT.Player('liveplayer' + i, {
			height: '360',
			width: '600',
			videoId: videoId,
			events: {

				'onStateChange': onPlayerStateChange
			}
		})
	})
}

//youtube iframe api: 영상 끝났을 시 자동으로 플레이리스트 다음 인덱스 재생
function onPlayerStateChange(event) {
	if (event.data == YT.PlayerState.ENDED) {
		nextmusic()
	}
}

//youtube iframe 종료
function closemusic() {
	player.destroy()
	document.getElementById("closebutton").remove()
}

//추천
function like() {
	var likeurl = getContextPath() + "/board/updatelike?boardNo=" + boardNo + "&userEmail=" + userEmail
	if (userEmail == "") {
		alert("로그인 후 이용해주세요")
		return
	}
	fetch(likeurl)
		.then(response => {
			response.text().then(function(likeCheck) {
				if (likeCheck == 0) {
					alert("게시글을 추천하였습니다.");
					countLike()
				}
				else if (likeCheck == 1) {
					alert("추천을 취소하였습니다.");
					countLike()
				}
			})
		})
}

//추천수
function countLike() {
	fetch(getContextPath() + "/board/countlike?no=" + boardNo)
		.then(response => response.text())
		.then(count => {
			document.getElementById("countLike").innerHTML = "추천 : " + count
		})
}


//textarea 글자수 제한
function limitLength(area, maxLength,countdiv){
	var text= area.value
	var count = document.getElementById(countdiv)
	count.innerHTML = text.length+"/"+maxLength
	if(text.length>maxLength){
		alert(maxLength+"자 까지만 작성 가능합니다")
		text = text.substr(0, maxLength)
		area.value = text
		area.focus()
	}
}


//댓글달기
function addReply() {
	var reText = document.getElementById("replyText").value.replace(/(?:\r\n|\r|\n)/g, "<br />")
	if (reText == null || reText == "") {
		alert("댓글을 작성해주세요")
		return
	}
	if (userEmail == null || userEmail == "") {
		alert("로그인 후 이용해 주세요")
		return
	}
	var url = getContextPath() + "/board/addreply?boardNo=" + boardNo + "&userEmail=" + userEmail + "&reText=" + reText + "&type=" + boardType
	fetch(url).then(res => {
		replyList('1')
		countReply()
		document.getElementById("replyText").value = ""
	})
}

//댓글리스트	
function replyList(nowPage) {
	var url = getContextPath() + "/board/replylist?boardNo=" + boardNo + "&type=" + boardType + "&nowPage=" + nowPage
	var pgurl = getContextPath() + "/board/replypageing?boardNo=" + boardNo + "&nowPage=" + nowPage
	fetch(url)
		.then(res => res.json())
		.then(json => {
			var a = ''
			for (var i = 0; i < json.length; i++) {
				a += '<li class="list-group-item" >'
				a += '<div class="d-flex w-100 justify-content-between">'
				a += '<h5 class="mb-1">' + json[i].userNickname + '</h5>'
				if (userEmail == json[i].userEmail) {
					a += '<div><a href="javascript:void(0);" onclick="updateReply(' + json[i].reNo + ')">수정</a>&nbsp;'
					a += '<a href="javascript:void(0);" onclick="deleteReply(' + json[i].reNo + ')">삭제</a>&nbsp;&nbsp;'
					a += '<small>' + json[i].reDate + '</small></div></div>'
				} else {
					a += '<div><small>' + json[i].reDate + '</small></div></div>'
				}

				a += '<small>&nbsp;</small><pre>' + json[i].reText + '</pre></li>'
			}
			document.getElementById("replyList").innerHTML = a
		})
	//게시글 내에서 페이징작업 비동기화 위해 AJAX로 처리
	fetch(pgurl)
		.then(res => res.json())
		.then(json => {
			console.log(json)
			var a = ''
			if (json.startPg > json.bottomLine) {
				a += '<li class="page-item">'
				a += '<a class="page-link" href="javascript:void(0);"'
				a += 'onclick="replyList(' + (json.startPg - json.bottomLine) + ');"aria-label="Previous">'
				a += '<span aria-hidden="true">&laquo;</span></a></li>'
			}
			for (var i = json.startPg; i <= json.endPg; i++) {
				a += '<li class="page-item"><a class="page-link"'
				if (nowPage == i) {
					a += 'style="background: #d2d2d2"'
				}
				a += 'href="javascript:void(0);" onclick="replyList(' + i + ')">' + i + '</a></li>'
			}
			if (json.endPg < json.maxPg) {
				a += '<li class="page-item">'
				a += '<a class="page-link" href="javascript:void(0);"'
				a += 'onclick="replyList(' + (json.startPg + json.bottomLine) + ');"aria-label="Next">'
				a += '<span aria-hidden="true">&raquo;</span></a></li>'
			}
			document.getElementById("replyPageing").innerHTML = a
		})
}

//댓글수정창(모달띄우기)
function updateReply(reNo) {
	if (modaldiv !== null) {
		modaldiv.remove()
	}

	var a = ""
	a += '<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">'
	a += '<div class="modal-dialog"><div class="modal-content">'
	a += '<div class="modal-header"><h5 class="modal-title" id="exampleModalLabel">댓글 수정</h5>'
	a += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>'
	a += '<div class="modal-body"><textarea class="form-control" id="newreText" rows="3" onkeyup="limitLength(this,100,\'count2\')"></textarea>'
	a += '<div id="count2"></div></div>'
	a += '  <div class="modal-footer">'
	a += '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>'
	a += '<button type="button" class="btn btn-primary" onclick="newreText(' + reNo + ')" data-bs-dismiss="modal" >수정</button>'
	a += '</div></div></div></div>'
	modaldiv = document.createElement('div')
	modaldiv.innerHTML = a

	document.body.append(modaldiv)

	var modal = new bootstrap.Modal(modaldiv.querySelector(".modal"))
	modal.show()
}

//댓글수정
function newreText(reNo) {
	var reText = document.getElementById('newreText').value.replace(/(?:\r\n|\r|\n)/g, "<br />")
	var url = getContextPath() + "/board/updatereply?reNo=" + reNo + "&reText=" + reText
	fetch(url)
		.then(res => res.text())
		.then(text => {
			if (text == 1) {
				alert("댓글이 수정되었습니다.")
			}
			replyList('1')
			countReply()
		})
}

//댓글삭제
function deleteReply(reNo) {
	var url = getContextPath() + "/board/deletereply?reNo=" + reNo
	fetch(url)
		.then(res => res.text())
		.then(text => {
			if (text == 1) {
				alert("댓글이 삭제되었습니다.")
			}
			replyList('1')
			countReply()
		})
}

//댓글수
function countReply() {
	var url = getContextPath() + "/board/countreply?boardNo=" + boardNo
	fetch(url)
		.then(res => res.text())
		.then(text => {
			document.getElementById("countReply").innerHTML = "댓글 : " + text + " 개"
		})
}

//내가쓴글 리스트
function myBoard(bdType, nowPage) {
	var url = getContextPath() + "/user/myboard?bdType=" + bdType + "&nowPage=" + nowPage
	var urlpg = getContextPath() + "/user/myboardpageing?bdType=" + bdType + "&nowPage=" + nowPage
	fetch(url)
		.then(res => res.json())
		.then(json => {
			var a = ''
			for (var i = 0; i < json.length; i++) {
				a += '<tr><td><a href="' + getContextPath() + '/board/musicboardpost?no=' + json[i].no + '">'
				if (bdType == 'a' || bdType == 's') {
					a += json[i].artist + ' - ' + json[i].title
				}
				if (bdType == 'l' || bdType == 'm') {
					a += json[i].title
				}
				a += '</a></td>'
				a += '<td>' + json[i].readcnt + '</td>'
				a += '<td>' + json[i].recocnt + '</td>'
				a += '<td>' + json[i].datechange + '</td></tr>'

			}
			document.getElementById("myBoard").innerHTML = a
		})
	//비동기처리 위해 페이징 AJAX
	fetch(urlpg)
		.then(res => res.json())
		.then(json => {
			var a = ''
			if (json.startPg > json.bottomLine) {
				a += '<li class="page-item">'
				a += '<a class="page-link" href="javascript:void(0);"'
				a += 'onclick="myBoard(\'' + bdType + '\',' + (json.startPg - json.bottomLine) + ');"aria-label="Previous">'
				a += '<span aria-hidden="true">&laquo;</span></a></li>'
			}
			for (var i = json.startPg; i <= json.endPg; i++) {
				a += '<li class="page-item"><a class="page-link"'
				if (nowPage == i) {
					a += 'style="background: #d2d2d2"'
				}
				a += 'href="javascript:void(0);" onclick="myBoard(\'' + bdType + '\',' + i + ')">' + i + '</a></li>'
			}
			if (json.endPg < json.maxPg) {
				a += '<li class="page-item">'
				a += '<a class="page-link" href="javascript:void(0);"'
				a += 'onclick="myBoard(\'' + bdType + '\'",' + (json.startPg + json.bottomLine) + ');"aria-label="Next">'
				a += '<span aria-hidden="true">&raquo;</span></a></li>'
			}
			document.getElementById("myboardPageing").innerHTML = a
		})
}

//내가추천누른 글 리스트
function myLikeBoard(bdType, nowPage) {
	var url = getContextPath() + "/user/mylikeboard?bdType=" + bdType + "&nowPage=" + nowPage
	var urlpg = getContextPath() + "/user/mylikeboardpageing?bdType=" + bdType + "&nowPage=" + nowPage
	fetch(url)
		.then(res => res.json())
		.then(json => {
			var a = ''
			for (var i = 0; i < json.length; i++) {
				a += '<tr><td><a href="' + getContextPath() + '/board/musicboardpost?no=' + json[i].no + '">'
				if (bdType == 'a' || bdType == 's') {
					a += json[i].artist + ' - ' + json[i].title
				}
				if (bdType == 'l' || bdType == 'm') {
					a += json[i].title
				}
				a += '</a></td>'
				a += '<td>' + json[i].readcnt + '</td>'
				a += '<td>' + json[i].recocnt + '</td>'
				a += '<td>' + json[i].userNickname + '</td></tr>'

			}
			document.getElementById("myLikeBoard").innerHTML = a
		})
		//비동기처리 위해 페이징 AJAX
	fetch(urlpg)
		.then(res => res.json())
		.then(json => {
			var a = ''
			if (json.startPg > json.bottomLine) {
				a += '<li class="page-item">'
				a += '<a class="page-link" href="javascript:void(0);"'
				a += 'onclick="myLikeBoard(\'' + bdType + '\',' + (json.startPg - json.bottomLine) + ');"aria-label="Previous">'
				a += '<span aria-hidden="true">&laquo;</span></a></li>'
			}
			for (var i = json.startPg; i <= json.endPg; i++) {
				a += '<li class="page-item"><a class="page-link"'
				if (nowPage == i) {
					a += 'style="background: #d2d2d2"'
				}
				a += 'href="javascript:void(0);" onclick="myLikeBoard(\'' + bdType + '\',' + i + ')">' + i + '</a></li>'
			}
			if (json.endPg < json.maxPg) {
				a += '<li class="page-item">'
				a += '<a class="page-link" href="javascript:void(0);"'
				a += 'onclick="myLikeBoard(\'' + bdType + '\'",' + (json.startPg + json.bottomLine) + ');"aria-label="Next">'
				a += '<span aria-hidden="true">&raquo;</span></a></li>'
			}
			document.getElementById("mylikeboardPageing").innerHTML = a
		})
}