package com.emotionlog.service;

import com.emotionlog.domain.UsersVO;

public interface UsersService {

	// 회원가입 
	public void join(UsersVO user, String authority) throws Exception;
	
	// 사용자 정보 조회(마이페이지 사용)
	public UsersVO readMypage(String username);
	
	// 사용자 정보 수정
	public void update(UsersVO user);
	
	// 사용자 정보 삭제
	public void delete(String username);
	
}
