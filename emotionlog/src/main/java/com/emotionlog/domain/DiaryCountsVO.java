package com.emotionlog.domain;

import lombok.Data;

@Data
public class DiaryCountsVO {
	
	private String regdateStr; // 날짜 (문자열 형태)
    private int dailyCount; // 해당 날짜에 작성된 일기 개수

}
