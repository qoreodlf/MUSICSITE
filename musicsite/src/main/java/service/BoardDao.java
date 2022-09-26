package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.MusicBoard;
import model.Reply;
import model.SingleTitle;
import model.User;



@Repository
public class BoardDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	private static final String ns = "board.";
	private Map<String, Object> map = new HashMap<String, Object>();
	
	
	public int addMusicBoard(MusicBoard musicBoard) {
		int num = session.insert(ns+"addmusicboard", musicBoard);
		return num;
	}
	
	public List<MusicBoard> musicBoardList(String bdType) {
		List<MusicBoard> mbList = session.selectList(ns+"musicboardlist", bdType);
		return mbList;
	}
	///////////////album board/////////////////////
	public List<MusicBoard> albumBoardList() {
		List<MusicBoard> albumList = session.selectList(ns+"albumboardlist");
		return albumList;
	}
	
	public MusicBoard albumBoardOne(int no) {
		MusicBoard selectedAB = session.selectOne(ns+"albumboardone", no);
		return selectedAB;
	}
	
	
	//////////////////////single board////////////////////
	public List<MusicBoard> singleBoardList() {
		List<MusicBoard> sbList= session.selectList(ns+"singleboardlist");
		return sbList;
	}
	
	public MusicBoard singleBoardOne(int no) {
		MusicBoard selectedSB = session.selectOne(ns+"singleboardone", no);
		return selectedSB;
	}
	
	
	//////////////////////////////////////////////////////////
	public SingleTitle selectSingle(SingleTitle singleTitle) {
		SingleTitle st = session.selectOne(ns+"selectsingle", singleTitle);
		return st;
	}
	
	public int addSingleTittle(SingleTitle singleTitle) {
		int num = session.insert(ns+"addsingletitle",singleTitle);
		return num;
	}
	
	
	
	////////////////////////추천기능////////////////////////////
	
	public int updateLike(int no) {
		int num = session.update(ns+"updateLike", no);
		return num;
	}
	
	public int updateLikeCancel(int no) {
		int num = session.update(ns+"updateLikeCancel", no);
		return num;
	}
	
	public int insertLike(int boardNo, String userEmail) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("userEmail", userEmail);
		int num = session.insert(ns+"insertLike", map);
		return num;
	}
	
	public int deleteLike(int boardNo, String userEmail) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("userEmail", userEmail);
		int num = session.insert(ns+"deleteLike", map);
		return num;
	}
	
	public int updateLikeCheck(int boardNo, String userEmail) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("userEmail", userEmail);
		int num = session.insert(ns+"updateLikeCheck", map);
		return num;
	}
	
	public int updateLikeCheckCancel(int boardNo, String userEmail) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("userEmail", userEmail);
		int num = session.insert(ns+"updateLikeCheckCancel", map);
		return num;
	}
	
	public int likeCheck(int boardNo, String userEmail) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("userEmail", userEmail);
		int num = session.selectOne(ns+"likeCheck", map);
		return num;
	}
	
	public int countLike(int no) {
		int num = session.selectOne(ns+"countlike", no);
		return num;
	}
	
	
	///////////////////////조회수 업
	public int readCountUp(int no) {
		int num = session.update(ns+"readcountup" , no);
		return num;
	}
	
	//////////////////////댓글//////////////////////////////
	public int addReply(Reply reply) {
		int num = session.insert(ns+"addreply", reply);
		return num;
	}
	
	public int updateReply(String reNo, String reText) {
		map.clear();
		map.put("reText", reText);
		map.put("reNo", reNo);
		System.out.println(map);
		int num = session.update(ns+"updatereply", map);
		return num;
	}
	
	public int deleteReply(String reNo) {
		int num = session.delete(ns+"deletereply", reNo);
		return num;
	}
	
	public List<Reply> replyList(String boardNo, String type) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("type", type);
		List<Reply> replylist = session.selectList(ns+"replylist", map);
		return replylist;
	}
	
	public int countReply(String boardNo) {
		int recnt = session.selectOne(ns+"countreply", boardNo);
		return recnt;
	}

}
