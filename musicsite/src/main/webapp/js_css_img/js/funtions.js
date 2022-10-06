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

function loadAlbum() {

	fetch(" http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&album=" + title + "&format=json")
		.then(res => res.json())
		.then(json => {
			console.log(json)
			document.getElementById("artist").innerHTML = json.album.artist
			document.getElementById("title").innerHTML = json.album.name

			var albumtime = 0
			for (var i = 0; i < json.album.tracks.track.length; i++) {
				albumtime += json.album.tracks.track[i].duration
			}
			console.log(hms(albumtime))
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

				getSingleTitle(artist, title, i)
			}
			document.getElementById("tracklist").innerHTML = a

			playList.sort((a, b) => {
				if (a.i < b.i) return -1;
				if (a.i > b.i) return 1;

				return 0;
			});
		})
}

function loadSingle() {

	fetch(" http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&track=" + title + "&format=json")
		.then(res => res.json())
		.then(json => {
			console.log(json)
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
			getSingleTitle(artist, title, "")

			document.getElementById("tracklist").innerHTML = a
		})
}

function hasURL(artist, title, i = "") {
	var url = getContextPath() + '/board/hasurl?artist=' + artist + '&title=' + title
	fetch(url)
		.then(res => res.text())
		.then(result => {
			if (result == 0) {
				var a = '<form id="' + i + '" action="${pageContext.request.contextPath}/board/addsingletitle">'
				a += '<input type="text" class="form-control" id="URL' + i + '" placeholder="youtube URL">'
				a += '<input type = "hidden" id="artist' + i + '" value="' + artist + '">'
				a += '<input type = "hidden" id="title' + i + '" value="' + title + '"></form>'
				document.getElementById("urldiv" + i).innerHTML = a
			}
		})

}
function searchTrack() {
	var artist = document.getElementById("sch_artist").value
	var track = document.getElementById("sch_track").value
	fetch(" http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=469da4f274a34075dac01550dd5e5ad3&artist=" + artist + "&track=" + track + "&format=json")
		.then(res => res.json())
		.then(json => {
			if (json.message == "Track not found" || json.message == "Invalid parameters - Your request is missing a required parameter") {
				alert("검색어를 확인해주세요")
			}
			console.log(json)
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
			console.log(json)
			document.getElementById("artist").innerHTML = json.album.artist
			document.getElementById("title").innerHTML = json.album.name

			document.getElementById("addArtist").value = json.album.artist
			document.getElementById("addTitle").value = json.album.name

			var albumtime = 0
			for (var i = 0; i < json.album.tracks.track.length; i++) {
				albumtime += json.album.tracks.track[i].duration
			}
			console.log(hms(albumtime))
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

function addSingleTitle() {
	for (var i = 0; i < numTrack; i++) {
		if (document.getElementById("artist" + i) !== null) {
			var artist = document.getElementById("artist" + i).value
			var title = document.getElementById("title" + i).value
			var URL = document.getElementById("URL" + i).value
			var suburl = getContextPath() + "/board/addsingletitle?artist=" + artist + "&title=" + title + "&URL=" + URL
			fetch(suburl)
		}
	}
	document.getElementById("addMusicPro").submit();
}


function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
};


function getSingleTitle(artist, title, i = "") {
	var url = getContextPath() + '/board/getsingletitle?artist=' + artist + '&title=' + title
	fetch(url).then(res => res.json())
		.then(json => {
			console.log(json)
			document.getElementById("videoId" + i).value = json.videoId
			if (json.url != null) {
				var a = '<button class="btn btn-secondary" type="button" onclick="playmusic(' + i + ')"><img src="" >play</button>'
				document.getElementById("playButton" + i).innerHTML = a

				var trackinfo = {
					i: i,
					videoId: json.videoId,
					artist: json.artist,
					title: json.title
				}
				playList.push(trackinfo)
			}
		})
}

function playmusic(i = "") {
	nowindex = playList.findIndex(obj => obj.videoId == document.getElementById("videoId" + i).value)
	makeplayer(nowindex)
}

function playalbum() {
	nowindex = 0
	makeplayer(nowindex)
}

function nextmusic() {
	if (nowindex < playList.length - 1) {
		nowindex += 1
		makeplayer(nowindex)
	} else {

	}
}

function previousmusic() {
	if (nowindex > 0) {
		nowindex -= 1
		makeplayer(nowindex)
	} else {
		alert("첫 곡입니다")
	}
}

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

function onPlayerStateChange(event) {
	if (event.data == YT.PlayerState.ENDED) {
		nextmusic()
	}
}



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
			console.log(json)
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

//댓글수정
function updateReply(reNo) {
	console.log('ddddd')
	if (modaldiv !== null) {
		modaldiv.remove()
	}

	var a = ""
	a += '<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">'
	a += '<div class="modal-dialog"><div class="modal-content">'
	a += '<div class="modal-header"><h5 class="modal-title" id="exampleModalLabel">댓글 수정</h5>'
	a += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div>'
	a += '<div class="modal-body"><textarea class="form-control" id="newreText" rows="3"></textarea></div>'
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

function countReply() {
	var url = getContextPath() + "/board/countreply?boardNo=" + boardNo
	fetch(url)
		.then(res => res.text())
		.then(text => {
			document.getElementById("countReply").innerHTML = "댓글 : " + text + " 개"
		})
}

function myBoard(bdType, nowPage) {
	var url = getContextPath() + "/user/myboard?bdType=" + bdType + "&nowPage=" + nowPage
	var urlpg = getContextPath() + "/user/myboardpageing?bdType=" + bdType + "&nowPage=" + nowPage
	fetch(url)
		.then(res => res.json())
		.then(json => {
			console.log(json)
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
	fetch(urlpg)
		.then(res => res.json())
		.then(json => {
			console.log(json)
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

function myLikeBoard(bdType, nowPage) {
	var url = getContextPath() + "/user/mylikeboard?bdType=" + bdType + "&nowPage=" + nowPage
	var urlpg = getContextPath() + "/user/mylikeboardpageing?bdType=" + bdType + "&nowPage=" + nowPage
	fetch(url)
		.then(res => res.json())
		.then(json => {
			console.log(json)
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
	fetch(urlpg)
		.then(res => res.json())
		.then(json => {
			console.log(json)
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