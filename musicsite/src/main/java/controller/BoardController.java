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

import model.AlbumBoard;
import model.SingleBoard;
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
	////////////////////////////////////////////////ALBUM BOARD///////////////////////
	@RequestMapping("albumboard")
	public String albumBoard() throws Exception{
		List<AlbumBoard> abList =bd.albumBoardList();
		request.setAttribute("abList", abList);
		return "albumBoard";
	}
	
	@RequestMapping("albumboardpost")
	public String albumBoardPost(int no) throws Exception{
		AlbumBoard abOne =bd.albumBoardOne(no);
		request.setAttribute("abOne", abOne);
		return "albumBoardPost";
	}
	
	
	@RequestMapping("addalbumboard")
	public String addAlbumBoard() throws Exception{
		return "addAlbumBoard";
	}
	
	@RequestMapping("addalbumboardpro")
	public String addAlbumBoardPro(AlbumBoard albumBoard) throws Exception{
		String userEmail = (String) session.getAttribute("userEmail");
		albumBoard.setUserEmail(userEmail);
		System.out.println(albumBoard);
		int num = bd.addABoard(albumBoard);
		return "redirect:/";
	}
	
	
	/////////////////////////////////////SINGLE BOARD/////////////////////////////
	@RequestMapping("singleboard")
	public String singleBoard() throws Exception{
		//추가하기
		return "singleBoard";
	}
	
	@RequestMapping("singleboardpost")
	public String singleBoardPost(int no) throws Exception{
		
		return "singleBoardPost";
	}
	
	@RequestMapping("addsingleboard")
	public String addSingleBoard() throws Exception{
		return "addSingleBoard";
	}
	
	@RequestMapping("addsingleboardpro")
	public String addSingleBoardPro(SingleBoard singleBoard) throws Exception{
		String userEmail = (String) session.getAttribute("userEmail");
		singleBoard.setUserEmail(userEmail);
		System.out.println(singleBoard);
		int num = bd.addSBoard(singleBoard);
		System.out.println(num);
		return "redirect:/";
	}
	/////////////////////////////////////
	@RequestMapping("getsingletitle")
	@ResponseBody
	public SingleTitle getSingleTitle(SingleTitle singleTitle) throws Exception{
		SingleTitle selectedSingle = bd.selectSingle(singleTitle);
		System.out.println(selectedSingle);
		if (selectedSingle==null) {
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
	public void addSingleTitle(SingleTitle singleTitle) throws Exception{
		System.out.println(singleTitle);
		String url = singleTitle.getURL();
		String videoId = url.substring(32);
		singleTitle.setVideoId(videoId);
		if (url != null && url != "") {
			int num = bd.addSingleTittle(singleTitle);
			System.out.println(num);
		}
	}
	
	@RequestMapping("hasurl")
	@ResponseBody
	public int hasURL(SingleTitle singleTitle) throws Exception{
		System.out.println(singleTitle);
		SingleTitle selectedSingle = bd.selectSingle(singleTitle);
		if (selectedSingle ==null) {
			System.out.println(selectedSingle);
			return 0;
		}else {
			System.out.println(selectedSingle);
			return 1;
		}
	}
}
