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
import model.Reply;
import model.SingleTitle;
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
	@RequestMapping("musicboard")
	public String musicBoard(String bdType) throws Exception {
		List<MusicBoard> mbList = bd.musicBoardList(bdType);
		request.setAttribute("mbList", mbList);
		return "musicBoard";
	}
	
	@RequestMapping("musicboardpost")
	public String musicBoardPost(int no) throws Exception {
		int num = bd.readCountUp(no);
		MusicBoard mbOne = bd.musicBoardOne(no);
		request.setAttribute("mbOne", mbOne);
		return "musicBoardPost";
	}
	
	@RequestMapping("addmusicboard")
	public String addmusicBoard() throws Exception {
		return "addMusicBoard";
	}
	
	@RequestMapping("addmusicboardpro")
	public String addMusicBoardPro(MusicBoard musicBoard) throws Exception {
		String userEmail = (String) session.getAttribute("userEmail");
		musicBoard.setUserEmail(userEmail);
		if(musicBoard.getUrl() == null || musicBoard.getUrl()=="") {
			musicBoard.setUrl("notLiveBoard");
			musicBoard.setVideoId("notLiveBoard");
		}else {
			musicBoard.setVideoId(musicBoard.getUrl().split("v=")[1].split("&")[0]);
		}
		if(musicBoard.getBdType().equals("l")) {
			musicBoard.setArtist("LiveBoard");
		}else if (musicBoard.getBdType().equals("m")) {
			musicBoard.setArtist("MusicVideo");
		}
		System.out.println(musicBoard);
		int num = bd.addMusicBoard(musicBoard);
		return "redirect:/";
	}
	
	

	/////////////////////////////////////
	@RequestMapping("getsingletitle")
	@ResponseBody
	public SingleTitle getSingleTitle(SingleTitle singleTitle) throws Exception {
		SingleTitle selectedSingle = bd.selectSingle(singleTitle);
		System.out.println(selectedSingle);
		if (selectedSingle == null) {
			SingleTitle nullSingleTitle = new SingleTitle();
			nullSingleTitle.setArtist(null);
			nullSingleTitle.setTitle(null);
			nullSingleTitle.setURL(null);
			return nullSingleTitle;
		}
		return selectedSingle;
	}

	@RequestMapping("addsingletitle")
	@ResponseBody
	public void addSingleTitle(SingleTitle singleTitle) throws Exception {
		System.out.println("ㄹㄹㄹㄹ"+singleTitle);
		String url = singleTitle.getURL();
		String videoId = url.split("v=")[1].split("&")[0];
		singleTitle.setVideoId(videoId);
		if (url != null && url != "") {
			int num = bd.addSingleTittle(singleTitle);
			System.out.println(num);
		}
	}

	@RequestMapping("hasurl")
	@ResponseBody
	public int hasURL(SingleTitle singleTitle) throws Exception {
		System.out.println(singleTitle);
		SingleTitle selectedSingle = bd.selectSingle(singleTitle);
		if (selectedSingle == null) {
			System.out.println(selectedSingle);
			return 0;
		} else {
			System.out.println(selectedSingle);
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
		System.out.println(boardNo + userEmail);
		System.out.println("userid=" + userEmail);
		int likeCheck = bd.likeCheck(boardNo, userEmail); // 해당개시물을 좋아요 눌렀는지
		System.out.println("likecheck:" + likeCheck);

		if (likeCheck == 0) {
			bd.insertLike(boardNo, userEmail);
			bd.updateLike(boardNo);
			bd.updateLikeCheck(boardNo, userEmail);
		} else if (likeCheck == 1) {
			bd.updateLikeCheckCancel(boardNo, userEmail);
			bd.updateLikeCancel(boardNo);
			bd.deleteLike(boardNo, userEmail);
		}
		request.setAttribute("likeCheck", likeCheck);
		return likeCheck;
	}
	
	///////////////////////////댓글기능/////////////////
	@RequestMapping("addreply")
	@ResponseBody
	public int addReply(Reply reply) throws Exception{
		System.out.println(reply);
		int num = bd.addReply(reply);
		return num;
	}
	
	@RequestMapping("replylist")
	@ResponseBody
	public List<Reply> replyList(String boardNo, String type) throws Exception{
		List<Reply> reList = bd.replyList(boardNo, type);
		return reList;
	}
	
	@RequestMapping("updatereply")
	@ResponseBody
	public int updateReply(String reNo, String reText) throws Exception{
		System.out.println(reNo+reText);
		int num = bd.updateReply(reNo, reText);
		System.out.println(num);
		return num;
	}
	
	@RequestMapping("deletereply")
	@ResponseBody
	public int deleteReply(String reNo) throws Exception{
		int num = bd.deleteReply(reNo);
		return num;
	}
	
	@RequestMapping("countreply")
	@ResponseBody
	public int countReply(String boardNo) throws Exception{
		int num = bd.countReply(boardNo);
		return num;
	}
	
}
