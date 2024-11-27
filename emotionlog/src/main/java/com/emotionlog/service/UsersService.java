package com.emotionlog.service;

import com.emotionlog.domain.UsersVO;

public interface UsersService {

	// 회원가입 
	public void join(UsersVO user, String authority) throws Exception;
	
	// 사용자 정보 조회(마이페이지 사용)
	public UsersVO readMypage(String username);
}
