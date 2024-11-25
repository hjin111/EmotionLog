package com.emotionlog.mapper;

import org.apache.ibatis.annotations.Param;

import com.emotionlog.domain.UsersVO;

public interface UsersMapper {
	
	// 회원가입 - 사용자 정보 입력
	public void insert(UsersVO user);
	
	// 회원가입 - 권한 입력
	public void insertAuthority(@Param("username") Long username, 
			@Param("authority") String authority);
	
	

}
