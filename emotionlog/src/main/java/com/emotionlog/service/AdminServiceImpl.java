package com.emotionlog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.emotionlog.domain.AboardVO;
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
	public List<UsersVO> getUserList(Integer limit) throws Exception {
		
		return mapper.getUserList(limit);
	}

	@Override
	public List<DiaryCountsVO> getDiaryCountsByDateRange() throws Exception {
		
		return mapper.getDiaryCountsByDateRange();
	}

	@Override
	public List<QboardVO> getQboardList(Integer limit) throws Exception {

		return mapper.getQboardList(limit);
	}

	@Override
	public QboardVO getQboardDetails(Long qno) throws Exception {
		
		return mapper.getQboardDetails(qno);
	}

	@Override
	public AboardVO getAnwser(Long qno) throws Exception {
		
		return mapper.getAnswer(qno);
	}

	@Override
	public void createAnswer(AboardVO vo) throws Exception {
		
		mapper.createAnswer(vo);
		
	}



}
