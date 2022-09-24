package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import service.UserDao;

@Controller
@RequestMapping("/test/")
public class test {
	
	@Autowired
	UserDao ud;
	
	HttpServletRequest request;
	Model m;
	HttpSession session;

	@ModelAttribute
	void init(HttpServletRequest request, Model m) {
		this.request = request;
		this.m = m;
		this.session = request.getSession();
	}
	
	@RequestMapping("aaa")
	public String aaaa() {
		return "testpage";
	}
	
	@RequestMapping("addalbumboard")
	public String addAlbumBoard() throws Exception{
		return "addAlbumBoard2";
	}

}