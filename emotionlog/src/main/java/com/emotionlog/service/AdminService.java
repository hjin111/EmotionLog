package com.emotionlog.service;

import java.util.List;

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QnAVO;
import com.emotionlog.domain.UsersVO;

public interface AdminService {
	
	// 전체 회원 리스트 조회
	public List<UsersVO> getUserList() throws Exception;
	
	// 날짜별 작성된 일기 수 조회
	public List<DiaryCountsVO> getDiaryCountsByDateRange() throws Exception;

	// 미답변 QnA 리스트 조회
	public List<QnAVO> getQnaList() throws Exception;
	
	// QnA 문의 상세 조회
	public QnAVO getQnaDetails(Long qno) throws Exception;

}
