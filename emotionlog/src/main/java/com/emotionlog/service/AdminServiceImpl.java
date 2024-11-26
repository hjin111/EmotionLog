package com.emotionlog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QnAVO;
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
	public List<QnAVO> getQnaList() throws Exception {

		return mapper.getQnaList();
	}

	@Override
	public QnAVO getQnaDetails(Long qno) throws Exception {
		
		return mapper.getQnaDetails(qno);
	}


}
