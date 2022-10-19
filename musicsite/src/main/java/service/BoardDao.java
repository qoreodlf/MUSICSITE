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
	
	//보드 삭제
	public int deleteMusicboard(int no) {
		int num = session.delete(ns+"deletemusicboard",no);
		return num;
	}
	
	public List<MusicBoard> musicBoardList(String bdType,int nowPage, int limit) {
		map.clear();
		map.put("bdType", bdType);
		map.put("start", (nowPage - 1) * limit + 1);
		map.put("end", (nowPage * limit));
		List<MusicBoard> mbList = session.selectList(ns+"musicboardlist", map);
		return mbList;
	}
	
	public MusicBoard musicBoardOne(int no) {
		MusicBoard selectedMB = session.selectOne(ns+"musicboardone", no);
		return selectedMB;
	}
	
	public List<MusicBoard> musicBoardListRecocnt(String bdType) {
		List<MusicBoard> mbList = session.selectList(ns+"musicboardlistrecocnt", bdType);
		return mbList;
	}
	
	
	public int boardCount(String bdType) {
		int num = session.selectOne(ns+"boardcount", bdType);
		return num;
	}
	
	public MusicBoard getRandomBoard(String bdType) {
		MusicBoard selectedMB = session.selectOne(ns+"getrandomboard", bdType);
		return selectedMB;
	}
	
	public int clearRandomMB() {
		int num = session.delete(ns+"clearrandommb");
		return num;
	}
	
	public int addRandomMB(MusicBoard musicBoard) {
		int num = session.insert(ns+"addrandommb", musicBoard);
		return num;
	}
	
	public String randomMBOne(String bdType) {
		String videoId = session.selectOne(ns+"randommbone",bdType);
		return videoId;
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
	
	public List<Reply> replyList(String boardNo, String type,int nowPage, int limit) {
		map.clear();
		map.put("boardNo", boardNo);
		map.put("type", type);
		map.put("start", (nowPage - 1) * limit + 1);
		map.put("end", (nowPage * limit));
		List<Reply> replylist = session.selectList(ns+"replylist", map);
		return replylist;
	}
	
	public int countReply(String boardNo) {
		int recnt = session.selectOne(ns+"countreply", boardNo);
		return recnt;
	}

}
