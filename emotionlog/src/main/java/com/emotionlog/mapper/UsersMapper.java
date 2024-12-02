// 작성자 : 이혜진
package com.emotionlog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.emotionlog.domain.UsersVO;

@Mapper
public interface UsersMapper {
	
	// 회원가입 - 사용자 정보 입력
	public void insert(UsersVO user);
	
	// 회원가입 - 권한 입력
	public void insertAuthority(@Param("username") String username, 
			@Param("authority") String authority);
	
	// 아이디 중복 체크
	public int idCheck(String username);
	
	 // 사용자 정보 조회 (로그인 시 사용)
    public UsersVO read(String username);
	
    // 사용자 정보 조회 (마이페이지 사용)
    public UsersVO readMypage(String username);
    
    // 사용자 정보 수정
    public void update(UsersVO user);
    
    // 권한 삭제
    public void deleteAuthority(String username);
    
    // 사용자 정보 삭제
    public void delete(String username);

    // 아이디 찾기
	public String findUsername(@Param("name") String name, 
			@Param("phone_number")String phone_number);
	
	// 아이디와 전화번호로 사용자 찾기
	public UsersVO findByUser(@Param("username") String username, 
			@Param("phone_number")String phone_number);
	
	// 비밀번호 업데이트 
	public void updatePassword(@Param("username") String username, 
			@Param("newPassword")String newPassword);
    
}
