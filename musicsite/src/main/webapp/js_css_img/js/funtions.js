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

function hasURL(artist, title, i) {
		var url = getContextPath()+'/board/hasurl?artist=' + artist + '&title=' + title
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