package com.emotionlog.service;

import com.emotionlog.domain.UsersVO;

public interface UsersService {

	// 회원가입 
	public void join(UsersVO user) throws Exception;
}
