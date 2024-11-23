package com.emotionlog.domain;

import java.util.Date;

import lombok.Data;

@Data
public class DiaryVO {
	private Long dno;
	private String title;
	private String content;
	private Date regdate;
	private Date updateDate;
	private String emotionStatus;
	private String enabled;
	private Long username;
}