package com.emotionlog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QboardVO;
import com.emotionlog.domain.UsersVO;
import com.emotionlog.mapper.AdminMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService {
	
	private AdminMapper mapper;

	@Override
	public List<UsersVO> getUserList() throws Exception {
		
		return mapper.getUserList();
	}

	@Override
	public List<DiaryCountsVO> getDiaryCountsByDateRange() throws Exception {
		
		return mapper.getDiaryCountsByDateRange();
	}

	@Override
	public List<QboardVO> getQboardList() throws Exception {

		return mapper.getQboardList();
	}

	@Override
	public QboardVO getQnaDetails(Long qno) throws Exception {
		
		return mapper.getQnaDetails(qno);
	}


}
