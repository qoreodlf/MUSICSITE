<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<button onclick="myFunction(this.id);return false;" id="one"
		value="T82K0Vgucpg">1</button>
	<button onclick="myFunction(this.id);return false;" id="two"
		value="lBgMFO0zuq8">2</button>
	<button onclick="myFunction(this.id);return false;" id="three"
		value="8rX2UfWCtfA">3</button>
	<button onclick="myFunction(this.id);return false;" id="fowr"
		value="40bRn--FL3Y">4</button>
		
	<button onclick="destroy()">destroy</button>
	<input type="hidden" id="ss">
	<div id="video"></div>

	<script src="https://www.youtube.com/iframe_api"></script>
	<script>
		playlist=['T82K0Vgucpg','lBgMFO0zuq8','8rX2UfWCtfA','40bRn--FL3Y']
        var player
        function myFunction(id){
			var vid=document.getElementById(id).value
        	document.getElementById("ss").value=vid
            document.getElementById("video").innerHTML = "<div id='player'></div>";
            document.getElementById(id).addEventListener('click',()=>{
        		player = new YT.Player('player', {
                    height: '390',
                    width: '640',
                   	videoId: playlist[playlist.indexOf(vid)],//document.getElementById("ss").value,
                    events: {
                        'onReady': e => e.target.playVideo()
                    }
        		})
        	})
        }
        
        function destroy() {
			player.destroy()
		}
      
        </script>
</body>
</body>
</html>