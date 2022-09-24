package model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SingleBoard {
	String userEmail;
	String artist;
	String single;
	Date boardDate;
	String userNickname;
}
