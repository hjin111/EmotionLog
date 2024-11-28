package com.emotionlog.service;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.emotionlog.domain.UsersVO;
import com.emotionlog.mapper.AuthoritiesMapper;
import com.emotionlog.mapper.UsersMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service 
@AllArgsConstructor
public class UsersServiceImpl implements UsersService, UserDetailsService{

	private UsersMapper mapper;
	private BCryptPasswordEncoder passwordEncoder; // BCryptPasswordEncoder 주입
	
	private AuthoritiesMapper authoritiesMapper;
	
	@Override
	@Transactional
	public void join(UsersVO user, String authority) throws Exception {
        // 사용자 정보 로그 출력
        log.info("회원가입된 user : " + user);
        
        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword); // 암호화된 비밀번호로 설정

        // 사용자 정보 users 테이블에 삽입
        mapper.insert(user);

        // 사용자 권한을 authorities 테이블에 삽입
        mapper.insertAuthority(user.getUsername(), authority);
    }
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UsersVO user = mapper.read(username);
		
		if (user == null) {
			throw new UsernameNotFoundException("User not found with username: " + username);
		}

		// 권한 조회
		Collection<? extends GrantedAuthority> authorities = authoritiesMapper.getAuthority(username);

		// UserDetails로 변환하여 반환
		return new User(user.getUsername(), user.getPassword(), user.getEnabled() == '1', // enabled가 '1'이면 true로 설정
				true, // accountNonExpired는 true로 설정
				true, // credentialsNonExpired는 true로 설정
				true, // accountNonLocked는 true로 설정
				authorities // Authorities 반환
		);
	}

	@Override
	public UsersVO readMypage(String username) {
		
		UsersVO user = mapper.readMypage(username);
		log.info(user);
		
		return user;
	}

	@Override
	public void update(UsersVO user) {
		mapper.update(user);
		log.info(user);
		
	}

	@Override
	@Transactional
	public void delete(String username) {
		mapper.deleteAuthority(username); // 권한 삭제
		mapper.delete(username); // 사용자 정보 삭제
		
	}

	@Override
	public String findUsername(String name, String phone_number) {
		String username =  mapper.findUsername(name, phone_number);
		return username;
	}
	
	
}
