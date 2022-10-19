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
	
	
	//회원가입페이지
	@RequestMapping("join")
	public String join() throws Exception {
		return "join";
	}
	
	//회원가입
	@RequestMapping("joinpro")
	public String joinPro(User user) throws Exception {
		User selectedUser = ud.selectUserOne(user.getUserEmail());

		//선택된유저 없으면 유저추가
		if (selectedUser == null) {
			int num = ud.addUser(user);
		}

		return "redirect:/user/login";
	}
	
	//이메일중복체크
	@RequestMapping("checkhasemail")
	@ResponseBody
	public int checkHasEmail(String userEmail) throws Exception{
		User selectedUser = ud.selectUserOne(userEmail);
		if (selectedUser == null) {
			return 0;
		} else {
			return 1;
		}
	}
	
	//닉네임 중복체크
	@RequestMapping("checkhasnickname")
	@ResponseBody
	public int checkHasNickname(String userNickname) throws Exception{
		User selectedUser = ud.selectUserOneByNickname(userNickname);
		if (selectedUser == null) {
			return 0;
		} else {
			return 1;
		}
	}

	//로그인페이지
	@RequestMapping("login")
	public String login() throws Exception {
		return "login";
	}

	//로그인
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

	//로그아웃
	@RequestMapping("logout")
	public String logout() throws Exception {
		session.invalidate();
		return "redirect:/";
	}

	//마이페이지
	@RequestMapping("mypage")
	public String mypagetest() throws Exception {

		/*
		 * String userEmail = (String) session.getAttribute("userEmail"); User userinfo
		 * = ud.selectUserOne(userEmail); request.setAttribute("userinfo", userinfo);
		 */
		//jsp에서 AJAX로 처리

		return "mypage";
	}

	//내가쓴게시글
	@RequestMapping("myboard")
	@ResponseBody
	public List<MusicBoard> myBoard(String bdType, int nowPage) throws Exception {
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		List<MusicBoard> myBoardList = ud.usersMusicBoard(bdType, userEmail, nowPage, pg.getLimit());
		return myBoardList;
	}

	//마이보드페이징
	@RequestMapping("myboardpageing")
	@ResponseBody
	public Pageing myBoardPageing(String bdType, int nowPage) throws Exception {

		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		return pg;
	}

	//내가 좋아요 누른 게시글
	@RequestMapping("mylikeboard")
	@ResponseBody
	public List<MusicBoard> myLikeBoard(String bdType, int nowPage) throws Exception {
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userLikeBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		List<MusicBoard> myBoardList = ud.usersLikeMusicBoard(bdType, userEmail, nowPage, pg.getLimit());
		return myBoardList;
	}

	//내가 좋아요 누른 게시글 페이징
	@RequestMapping("mylikeboardpageing")
	@ResponseBody
	public Pageing myLikeBoardPageing(String bdType, int nowPage) throws Exception {
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		int count = ud.userLikeBoardCount(bdType, userEmail);
		Pageing pg = new Pageing(nowPage, count);
		return pg;
	}
	
	
	//////////////////////////////회원정보변경///////////////////////
	
	@RequestMapping("checkpass")
	@ResponseBody
	public int checkPass(String userPass) throws Exception{
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		User selectedUser = ud.selectUserOne(userEmail);
		
		if(selectedUser.getUserPass().equals(userPass)) {
			return 0; //비밀번호 일치하면 0 리턴
		}else {
			return 1; //비밀번호 틀리면 1 리턴
		}
	}
	
	@RequestMapping("updatenickname")
	public String updateNickname() throws Exception{
		return "updateNickname";
	}
	
	//닉네임변경
	@RequestMapping("updatenicknamepro")
	public String updateNicknamePro(String userNickname) throws Exception{
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		ud.updateNickname(userNickname, userEmail);
		
		User selectedUser = ud.selectUserOne(userEmail);
		session.setAttribute("loginUser", selectedUser);
		return "redirect:/user/mypage";
	}
	
	@RequestMapping("updatepass")
	public String updatePass() throws Exception{
		return "updatePass";
	}
	
	
	//비밀번호 변경
	@RequestMapping("updatepasspro")
	public String updatePassPro(String newPass1) throws Exception{
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		ud.updatePass(newPass1, userEmail);
		
		User selectedUser = ud.selectUserOne(userEmail);
		session.setAttribute("loginUser", selectedUser);
		return "redirect:/user/mypage";
	}
	
	@RequestMapping("deleteuser")
	public String deleteUser() throws Exception{
		return "deleteUser";
	}
	
	//회원탈퇴
	@RequestMapping("deleteuserpro")
	public String deleteUserPro(String userPass) throws Exception{
		User loginUser = (User) session.getAttribute("loginUser");
		String userEmail = loginUser.getUserEmail();
		ud.deleteUser(userEmail);
		
		session.invalidate();
		return "redirect:/";
		
	}
}
