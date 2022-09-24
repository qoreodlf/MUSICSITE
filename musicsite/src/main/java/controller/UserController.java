package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import model.User;
import service.UserDao;

@Controller
@RequestMapping("/user/")
public class UserController {

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
	
	@RequestMapping("join")
	public String join() throws Exception{
		return "join";
	}
	
	@RequestMapping("joinpro")
	public String joinPro(User user) throws Exception{
		User selectedUser = ud.selectUserOne(user.getUserEmail());
		System.out.println(user);
		System.out.println(selectedUser);
		if(selectedUser == null) {
			System.out.println(11132312);
			int num = ud.addUser(user);
			System.out.println(num);
		}
		
		return "redirect:/user/login";
	}
	
	@RequestMapping("login")
	public String login() throws Exception{
		return "login";
	}
	
	@RequestMapping("loginpro")
	public String loginPro(User user) throws Exception{
		User selectedUser = ud.selectUserOne(user.getUserEmail());
		if (selectedUser != null) {
			if (selectedUser.getUserPass().equals(user.getUserPass())) {
				session.setAttribute("userEmail", selectedUser.getUserEmail());
				session.setAttribute("userNickname", selectedUser.getUserNickname());
			}
		}
		return "redirect:/";
	}
	
	@RequestMapping("logout")
	public String logout() throws Exception{
		session.invalidate();
		return "redirect:/";
	}
}
