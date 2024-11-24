package com.emotionlog.service;

import org.springframework.stereotype.Service;

import com.emotionlog.domain.UsersVO;
import com.emotionlog.mapper.UsersMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service 
@AllArgsConstructor
public class UsersServiceImpl implements UsersService{

	private UsersMapper mapper;
	
	@Override
	public void join(UsersVO user) throws Exception {
		
		log.info("회원가입된 user : " + user);
		mapper.insert(user);
		
	}

}
