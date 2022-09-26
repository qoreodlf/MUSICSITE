package model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reply {
 
	int boardNo;
	int reNo;
	String userEmail;
	String reText;
	String reDate;
	String type;
	String userNickname;
}
