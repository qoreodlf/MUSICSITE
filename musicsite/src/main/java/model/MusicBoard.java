package model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MusicBoard {
	int no;
	String userEmail;
	String title;
	String artist;
	Date boardDate;
	String userNickname;
	String bdType;
	int recocnt;
	int readcnt;
	String bdText;
	String url;
	String videoId;
	String datechange;
	
	
}
