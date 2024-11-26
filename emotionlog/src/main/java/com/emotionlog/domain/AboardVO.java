package com.emotionlog.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AboardVO {
	private Long ano;
	private String atitle;
	private String acontent;
	private Date adate;
	private String username;
	private Date aupdate_date;
}
