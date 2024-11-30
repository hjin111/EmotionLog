package com.emotionlog.service;

import java.util.List;

import com.emotionlog.domain.AboardVO;
import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QboardVO;
import com.emotionlog.domain.UsersVO;

public interface AdminService {
	
	// 전체 회원 리스트 조회
	public List<UsersVO> getUserList(Integer limit) throws Exception;
	
	// 날짜별 작성된 일기 수 조회
	public List<DiaryCountsVO> getDiaryCountsByDateRange() throws Exception;

	// 미답변 문의 리스트 조회
	public List<QboardVO> getQboardList(Integer limit) throws Exception;
	
	// QnA 문의 상세 조회
	public QboardVO getQboardDetails(Long qno) throws Exception;
	
	// QnA 답변 조회
	public List<AboardVO> getAnwser(Long qno) throws Exception;
	
	// QnA 답변 작성
	public int createAnswer(AboardVO vo) throws Exception;
	
	// QnA 답변 삭제
	public int deleteAnswer(Long ano) throws Exception;

	// QnA 답변 수정
	public int updateAnswer(Long ano, String acontent) throws Exception;


}
