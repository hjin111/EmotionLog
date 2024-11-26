package com.emotionlog.mapper;

import java.util.List;

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QboardVO;
import com.emotionlog.domain.UsersVO;

public interface AdminMapper {

	public List<UsersVO> getUserList();
	
	public List<DiaryCountsVO> getDiaryCountsByDateRange();
	
	public List<QboardVO> getQboardList();
	
	public QboardVO getQboardDetails(Long qno);
}
