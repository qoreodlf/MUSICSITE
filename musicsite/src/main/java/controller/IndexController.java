package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import model.MusicBoard;
import service.BoardDao;

@Controller
public class IndexController {
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
	
	@RequestMapping("/")
	public String index() throws Exception{
		//앨범, 싱글 추천순으로 가져오기(최신 1주일로 변경 필요)
		List<MusicBoard> abList = bd.musicBoardListRecocnt("a");
		List<MusicBoard> sbList = bd.musicBoardListRecocnt("s");
		
		//randomMB에서 라이브, 뮤비 비디오아이디 가져오기
		String liveVideoId = bd.randomMBOne("l");
		String MBVideoId = bd.randomMBOne("m");

		request.setAttribute("liveVideoId", liveVideoId);
		request.setAttribute("MBVideoId", MBVideoId);
		request.setAttribute("abList", abList);
		request.setAttribute("sbList", sbList);
		
		
		
		return "home";
	}
	
}
