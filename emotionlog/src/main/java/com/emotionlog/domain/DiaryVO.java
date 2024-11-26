/**
 * 작성자    : 박혜정
 * 작성일    : 2024-11-22
 */

package com.emotionlog.domain;

import java.util.Date;

import lombok.Data;

@Data
public class DiaryVO {
	private Long dno;
	private String title;
	private String content;
	private Date regdate;
	private Date update_date;
	private String emotion_status;
	private String enabled;
	private Long username;
	

}
