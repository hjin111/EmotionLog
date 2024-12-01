// 작성자 : 이혜진
package com.emotionlog.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;

@Mapper
public interface AuthoritiesMapper {

	// 권한 가져오기
	public List<GrantedAuthority> getAuthority(String username);
	
}
