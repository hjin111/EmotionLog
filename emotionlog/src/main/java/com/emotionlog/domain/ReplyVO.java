package com.emotionlog.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno;
	private Long dno;
	
	private String reply;
	private String replyer;
	private Date reply_date;
	private Date update_date;
}
