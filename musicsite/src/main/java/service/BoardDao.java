package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.AlbumBoard;
import model.SingleBoard;
import model.SingleTitle;
import model.User;



@Repository
public class BoardDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	private static final String ns = "board.";
	private Map<String, Object> map = new HashMap<String, Object>();
	
	public int addABoard(AlbumBoard albumBoard) {
		int num = session.insert(ns+"addaboard", albumBoard);
		return num;
	}
	
	public List<AlbumBoard> albumBoardList() {
		List<AlbumBoard> albumList = session.selectList(ns+"albumboardlist");
		return albumList;
	}
	
	public AlbumBoard albumBoardOne(int no) {
		AlbumBoard selectedAB = session.selectOne(ns+"albumboardone", no);
		return selectedAB;
	}
	
	public int addSBoard(SingleBoard singleBoard) {
		int num = session.insert(ns+"addsboard", singleBoard);
		return num;
	}
	
	public SingleTitle selectSingle(SingleTitle singleTitle) {
		SingleTitle st = session.selectOne(ns+"selectsingle", singleTitle);
		return st;
	}
	
	public int addSingleTittle(SingleTitle singleTitle) {
		int num = session.insert(ns+"addsingletitle",singleTitle);
		return num;
	}
	

}
