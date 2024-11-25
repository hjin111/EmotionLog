package com.emotionlog.service;

import java.util.List;

import com.emotionlog.domain.UsersVO;

public interface AdminService {
	
	// 전체 회원 리스트 조회
	public List<UsersVO> getUserList() throws Exception;

}
