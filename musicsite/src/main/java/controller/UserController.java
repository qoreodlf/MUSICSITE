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
import model.User;
import service.BoardDao;
import service.UserDao;

@Controller
@RequestMapping("/user/")
public class UserController {

	@Autowired
	UserDao ud;

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

	@RequestMapping("join")
	public String join() throws Exception {
		return "join";
	}

	@RequestMapping("joinpro")
	public String joinPro(User user) throws Exception {
		User selectedUser = ud.selectUserOne(user.getUserEmail());
		System.out.println(user);
		System.out.println(selectedUser);
		if (selectedUser == null) {
			System.out.println(11132312);
			int num = ud.addUser(user);
			System.out.println(num);
		}

		return "redirect:/user/login";
	}

	@RequestMapping("login")
	public String login() throws Exception {
		return "login";
	}

	@RequestMapping("loginpro")
	public String loginPro(User user) throws Exception {
		User selectedUser = ud.selectUserOne(user.getUserEmail());
		if (selectedUser != null) {
			if (selectedUser.getUserPass().equals(user.getUserPass())) {
				session.setAttribute("loginUser", selectedUser);
			}
		}
		return "redirect:/";
	}

	@RequestMapping("logout")
	public String logout() throws Exception {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("mypage")
	public String mypagetest() throws Exception {

		/*
		 * String userEmail = (String) session.getAttribute("userEmail"); User userinfo
		 * = ud.selectUserOne(userEmail); request.setAttribute("userinfo", userinfo);
		 */

		return "mypage";
	}

	@RequestMapping("myboard")
	@ResponseBody
	public List<MusicBoard> myBoard(String bdType, int nowPage) throws Exception {
		//String userEmail = (String) session.getAttribute("userEmail");
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		List<MusicBoard> myBoardList = ud.usersMusicBoard(bdType, userEmail, nowPage, pg.getLimit());
		return myBoardList;
	}

	@RequestMapping("myboardpageing")
	@ResponseBody
	public Pageing myBoardPageing(String bdType, int nowPage) throws Exception {
		//String userEmail = (String) session.getAttribute("userEmail");
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		return pg;
	}

	@RequestMapping("mylikeboard")
	@ResponseBody
	public List<MusicBoard> myLikeBoard(String bdType, int nowPage) throws Exception {
		System.out.println(bdType + ",," + nowPage);
		//String userEmail = (String) session.getAttribute("userEmail");
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userLikeBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		List<MusicBoard> myBoardList = ud.usersLikeMusicBoard(bdType, userEmail, nowPage, pg.getLimit());
		return myBoardList;
	}

	@RequestMapping("mylikeboardpageing")
	@ResponseBody
	public Pageing myLikeBoardPageing(String bdType, int nowPage) throws Exception {
		System.out.println(bdType + "//" + nowPage);
		//String userEmail = (String) session.getAttribute("userEmail");
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userLikeBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		return pg;
	}

}
