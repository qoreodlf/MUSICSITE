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

/*function ytlink(artist, tittle) {
	var artist = artist
	var tittle = tittle

	console.log(artist + tittle)

	var key = "AIzaSyDStbHDY024iw1mo_R8g_0VzESgNQIkWUU"
	var part = 'snippet'
	var maxResults = 10
	var q = artist + " " + tittle
	var type = "video"
	var videoCategoryId = 10
	var videoLicense = "youtube"
	var url = "https://www.googleapis.com/youtube/v3/search?key=" + key + "&part=" + part + "&maxResults=" + maxResults
		+ "&q=" + q + "&type=" + type + "&videoCategoryId" + videoCategoryId + "&videoLicense" + videoLicense
	var zzz = ""
	fetch(url)
		.then(res => res.json())
		.then(json => json.items[0].id.videoId)
		.then(id => "https://www.youtube.com/watch?v=" + id)
		.then(youtubeURL => {
			console.log(youtubeURL)
	//zzz=youtubeURL
		})

	
}
*/

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
				var a = '<button type="button" onclick="playmusic(' + i + ')"><img src="" >play</button>'
				document.getElementById("playButton" + i).innerHTML = a

				var trackinfo = {
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
		alert("마지막 곡입니다")
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
	var reText = document.getElementById("replyText").value
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
		replyList()
		countReply()
		document.getElementById("replyText").value = ""
	})
}
//댓글리스트	
function replyList() {
	var url = getContextPath() + "/board/replylist?boardNo=" + boardNo + "&type=" + boardType
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

				a += '<small>&nbsp;</small><p class="mb-1">' + json[i].reText + '</p></li>'
			}
			document.getElementById("replyList").innerHTML = a
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
	var reText = document.getElementById('newreText').value
	var url = getContextPath() + "/board/updatereply?reNo=" + reNo + "&reText=" + reText
	fetch(url)
		.then(res => res.text())
		.then(text => {
			if (text == 1) {
				alert("댓글이 수정되었습니다.")
			}
			replyList()
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
			replyList()
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