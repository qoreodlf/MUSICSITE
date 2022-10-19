package model;

import lombok.Getter;
import lombok.Setter;
import service.BoardDao;

@Getter
@Setter
public class Pageing {
	//int nowPage;
	int startPg;  //1,2,3,4,5 =>1  6,7,8,9,10 =>6
	int endPg;
	int bottomLine = 5; //페이징 수
	int limit = 5; //한 페이지당 게시글 수 
	int maxPg;
	
	public Pageing(int nowPage, int boardCount){ //boardCount : 해당 카테고리 보드, 댓글의 전체 수
		this.maxPg = (boardCount / limit) + (boardCount % limit == 0 ? 0 : 1);
		this.startPg = (nowPage-1)/bottomLine * bottomLine + 1;
		this.endPg = startPg + bottomLine-1;
		if(endPg>=maxPg) {
			this.endPg = maxPg;
		}
	}
	
}
