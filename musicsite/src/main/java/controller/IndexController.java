package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
		List<MusicBoard> abList = bd.musicBoardListRecocnt("a");
		List<MusicBoard> sbList = bd.musicBoardListRecocnt("s");
		request.setAttribute("abList", abList);
		request.setAttribute("sbList", sbList);
		
		return "home";
	}
}
