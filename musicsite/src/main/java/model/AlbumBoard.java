package model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AlbumBoard {
	int no;
	String userEmail;
	String album;
	String artist;
	Date boardDate;
	String userNickname;
	
	
}
