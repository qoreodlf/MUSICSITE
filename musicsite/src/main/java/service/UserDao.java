package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.MusicBoard;
import model.User;



@Repository
public class UserDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	private static final String ns = "user.";
	private Map<String, Object> map = new HashMap<String, Object>();
	
	public int addUser(User user) {
		int num = session.insert(ns+"adduser", user);
		return num;
	}
	
	public User selectUserOne(String userEmail) {
		User user = session.selectOne(ns+"selectuserone", userEmail);
		return user;
	}
	
	public List<MusicBoard> usersMusicBoard(String bdType, String userEmail,int nowPage, int limit){
		map.clear();
		map.put("bdType", bdType);
		map.put("userEmail", userEmail);
		map.put("start", (nowPage - 1) * limit + 1);
		map.put("end", (nowPage * limit));
		List<MusicBoard> usermbList = session.selectList(ns+"usersmusicboard", map);
		return usermbList;
	}
	
	public int userBoardCount(String bdType, String userEmail) {
		map.clear();
		map.put("bdType", bdType);
		map.put("userEmail", userEmail);
		
		int bdcount = session.selectOne(ns+"userboardcount", map);
		return bdcount;
	}
	
	public List<MusicBoard> usersLikeMusicBoard(String bdType, String userEmail,int nowPage, int limit){
		map.clear();
		map.put("bdType", bdType);
		map.put("userEmail", userEmail);
		map.put("start", (nowPage - 1) * limit + 1);
		map.put("end", (nowPage * limit));
		System.out.println("d:"+map);
		List<MusicBoard> usermbList = session.selectList(ns+"userslikemusicboard", map);
		return usermbList;
	}
	
	public int userLikeBoardCount(String bdType, String userEmail) {
		map.clear();
		map.put("bdType", bdType);
		map.put("userEmail", userEmail);
		System.out.println("s:"+map);
		int bdcount = session.selectOne(ns+"userlikeboardcount", map);
		return bdcount;
	}

}
