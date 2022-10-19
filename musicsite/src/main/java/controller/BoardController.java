package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.MusicBoard;
import model.Pageing;
import model.Reply;
import model.SingleTitle;
import model.User;
import service.BoardDao;

@Controller
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	BoardDao bd;

	HttpServletRequest request;
	Model m;
	HttpSession session;

	@ModelAttribute
	void init(HttpServletRequest request, Model m) {
		this.request = request;
		this.m = m;
		this.session = request.getSession();
	}

	//보드타입에 따른 리스트+페이징
	@RequestMapping("musicboard")
	public String musicBoard(String bdType, int nowPage) throws Exception {
		int boardCount = bd.boardCount(bdType);
		Pageing pg = new Pageing(nowPage, boardCount);
		List<MusicBoard> mbList = bd.musicBoardList(bdType, nowPage, pg.getLimit());
		request.setAttribute("mbList", mbList);
		request.setAttribute("bottomline", pg.getBottomLine());
		request.setAttribute("startPg", pg.getStartPg());
		request.setAttribute("endPg", pg.getEndPg());
		request.setAttribute("maxPg", pg.getMaxPg());
		return "musicBoard";
	}
	
	//게시글페이지
	@RequestMapping("musicboardpost")
	public String musicBoardPost(int no) throws Exception {
		int num = bd.readCountUp(no);
		MusicBoard mbOne = bd.musicBoardOne(no);
		request.setAttribute("mbOne", mbOne);
		return "musicBoardPost";
	}
	
	//게시글작성페이지
	@RequestMapping("addmusicboard")
	public String addmusicBoard() throws Exception {
		return "addMusicBoard";
	}
	
	//게시글작성
	@RequestMapping("addmusicboardpro")
	public String addMusicBoardPro(MusicBoard musicBoard) throws Exception {
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		musicBoard.setUserEmail(userEmail);
		if(musicBoard.getUrl() == null || musicBoard.getUrl()=="") {
			musicBoard.setUrl("notLiveBoard");
			musicBoard.setVideoId("notLiveBoard");
		}else {
			//유튜브 url에서 videoID 만 자르기
			musicBoard.setVideoId(musicBoard.getUrl().split("v=")[1].split("&")[0]);
		}
		if(musicBoard.getBdType().equals("l")) {
			musicBoard.setArtist("LiveBoard");
		}else if (musicBoard.getBdType().equals("m")) {
			musicBoard.setArtist("MusicVideo");
		}
		int num = bd.addMusicBoard(musicBoard);
		return "redirect:/";
	}
	
	//게시글 삭제
	@RequestMapping("deleteboard")
	public String deleteBoard(int no, String bdType) throws Exception{
		int num = bd.deleteMusicboard(no);
		return "redirect:/board/musicboard?bdType="+bdType+"&nowPage=1";
		
	}
	
	

	/////////////////////////////////////
	//싱글타이틀 가져오기
	@RequestMapping("getsingletitle")
	@ResponseBody
	public SingleTitle getSingleTitle(SingleTitle singleTitle) throws Exception {
		SingleTitle selectedSingle = bd.selectSingle(singleTitle);
		
		//싱글타이틀에 있으면 selectedSingle, 없으면 nullSingleTitle 리턴
		if (selectedSingle == null) {
			SingleTitle nullSingleTitle = new SingleTitle();
			nullSingleTitle.setArtist(null);
			nullSingleTitle.setTitle(null);
			nullSingleTitle.setURL(null);
			return nullSingleTitle;
		}
		return selectedSingle;
	}

	//싱글타이틀 추가
	@RequestMapping("addsingletitle")
	@ResponseBody
	public void addSingleTitle(SingleTitle singleTitle) throws Exception {
		String url = singleTitle.getURL();
		String videoId = url.split("v=")[1].split("&")[0];  //유튜브 url에서 videoID 만 자르기
		singleTitle.setVideoId(videoId);
		
		//유알엘 있는것만 추가
		if (url != null && url != "") {
			int num = bd.addSingleTittle(singleTitle);
		}
	}

	//싱글테이블에 추가된 트랙인지 확인
	@RequestMapping("hasurl")
	@ResponseBody
	public int hasURL(SingleTitle singleTitle) throws Exception {
		SingleTitle selectedSingle = bd.selectSingle(singleTitle);
		
		if (selectedSingle == null) {
			return 0;
		} else {
			return 1;
		}
	}

	////// 추천기능////////////
	// 추천수
	@RequestMapping("countlike")
	@ResponseBody
	public int countLike(int no) throws Exception {
		System.out.println(no);
		int countLike = bd.countLike(no);
		return countLike;
	}

	// 게시물 추천기능(백대일)
	@ResponseBody
	@RequestMapping("updatelike")
	public int updateLike(int boardNo, String userEmail) throws Exception {
		int likeCheck = bd.likeCheck(boardNo, userEmail); // 해당개시물을 좋아요 눌렀는지

		if (likeCheck == 0) {
			bd.insertLike(boardNo, userEmail);
			bd.updateLike(boardNo);
		} else if (likeCheck == 1) {
			bd.updateLikeCancel(boardNo);
			bd.deleteLike(boardNo, userEmail);
		}
		request.setAttribute("likeCheck", likeCheck);
		return likeCheck;
	}
	
	///////////////////////////댓글기능/////////////////
	//댓글달기
	@RequestMapping("addreply")
	@ResponseBody
	public int addReply(Reply reply) throws Exception{
		int num = bd.addReply(reply);
		return num;
	}
	
	//게시글별 댓글 리스트
	@RequestMapping("replylist")
	@ResponseBody
	public List<Reply> replyList(String boardNo, String type, int nowPage) throws Exception{
		int reCount = bd.countReply(boardNo);
		Pageing pg = new Pageing(nowPage, reCount);
		List<Reply> reList = bd.replyList(boardNo, type,nowPage, pg.getLimit());
		return reList;
	}
	
	//댓글 페이징
	@RequestMapping("replypageing")
	@ResponseBody
	public Pageing replyPageing(String boardNo, int nowPage) throws Exception{
		int reCount = bd.countReply(boardNo);
		Pageing pg = new Pageing(nowPage, reCount);
		return pg;
	}
	
	//댓글수정
	@RequestMapping("updatereply")
	@ResponseBody
	public int updateReply(String reNo, String reText) throws Exception{
		int num = bd.updateReply(reNo, reText);
		return num;
	}
	
	//댓글삭제
	@RequestMapping("deletereply")
	@ResponseBody
	public int deleteReply(String reNo) throws Exception{
		int num = bd.deleteReply(reNo);
		return num;
	}
	
	//댓글 수
	@RequestMapping("countreply")
	@ResponseBody
	public int countReply(String boardNo) throws Exception{
		int num = bd.countReply(boardNo);
		return num;
	}
	
}
