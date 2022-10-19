package scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import model.MusicBoard;
import service.BoardDao;

@Component
public class Scheduler {
	@Autowired
	BoardDao bd;
	
	//00시마다 업데이트
	@Scheduled(cron = "0 39 22 * * *")
	public void setRnadomMBTable() {
		int clear = bd.clearRandomMB();
		
		//randomMB 테이블에 bdtype l 중 무작위 하나 추가
		MusicBoard randomLive = bd.getRandomBoard("l");
		int addLive = bd.addRandomMB(randomLive);
		
		//randomMB 테이블에 bdtype m 중 무작위 하나 추가
		MusicBoard randomMV = bd.getRandomBoard("m");
		int addMV = bd.addRandomMB(randomMV);
	}
	
}
