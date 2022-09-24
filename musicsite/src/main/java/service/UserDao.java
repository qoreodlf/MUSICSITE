package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
