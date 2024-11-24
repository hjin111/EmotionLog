package com.emotionlog.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.emotionlog.domain.UsersVO;
import com.emotionlog.mapper.UsersMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service 
@AllArgsConstructor
@Transactional
public class UsersServiceImpl implements UsersService{

	private UsersMapper mapper;
	
	@Override
	public void join(UsersVO user, String authority) throws Exception {
        // 사용자 정보 로그 출력
        log.info("회원가입된 user : " + user);

        // 사용자 정보 users 테이블에 삽입
        mapper.insert(user);

        // 사용자 권한을 authorities 테이블에 삽입
        mapper.insertAuthority(user.getUsername(), authority);
    }

}
