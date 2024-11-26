package com.emotionlog.domain;

import lombok.Data;

@Data
public class UsersVO {

	private String username;
	private String name;
	private String birthday;
	private String phone_number;
	private String password;
	private char gender;
	private char enabled = '1'; // 기본값 '1' 설정
	

}
