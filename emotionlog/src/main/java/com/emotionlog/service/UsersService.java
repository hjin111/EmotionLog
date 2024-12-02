package com.emotionlog.service;

import com.emotionlog.domain.UsersVO;

public interface UsersService {

	// 회원가입 
	public void join(UsersVO user, String authority) throws Exception;
	
	// 아이디 중복 체크
	public int idCheck(String username);
	
	// 사용자 정보 조회(마이페이지 사용)
	public UsersVO readMypage(String username);
	
	// 사용자 정보 수정
	public void update(UsersVO user);
	
	// 사용자 정보 삭제
	public void delete(String username);
	
	// 아이디 찾기
	public String findUsername(String name, String phone_number);
	
	// 아이디와 전화번호로 사용자 찾기
    public UsersVO findByUser(String username, String phone_number);

    // 비밀번호 업데이트
    public void updatePassword(String username, String newPassword);
	
}
