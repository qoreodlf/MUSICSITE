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
	
	public User selectUserOneByNickname(String userNickname) {
		User user = session.selectOne(ns+"selectuseronebynickname", userNickname);
		return user;
	}
	
	public int updateNickname(String userNickname, String userEmail) {
		map.clear();
		map.put("userNickname", userNickname);
		map.put("userEmail", userEmail);
		int num = session.update(ns+"updatenickname",map);
		return num;
	}
	
	public int updatePass(String newPass1, String userEmail) {
		map.clear();
		map.put("userPass", newPass1);
		map.put("userEmail", userEmail);
		int num = session.update(ns+"updatepass",map);
		return num;
	}
	
	public int deleteUser(String userEmail) {
		int num = session.delete(ns+"deleteuser", userEmail);
		return num;
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
