package com.emotionlog.service;

import java.util.List;

import com.emotionlog.domain.DiaryVO;

public interface DiaryService {

	// 등록 작업의 구현
	public void register(DiaryVO diary) throws Exception;
	
	// 조회 작업의 구현
	public DiaryVO get(Long dno) throws Exception;
	
	// 삭제 구현
	public boolean remove (Long dno) throws Exception;
	
	// 수정 구현
	public boolean modify(DiaryVO diary) throws Exception;
	
	// 목록(리스트) 작업의 구현
	public List<DiaryVO> getList(DiaryVO diary) throws Exception;
//	public List<BoardVO> getList(Criteria cri) throws Exception;
//	
//	// 전체 페이지 개수
//	public int getTotal(Criteria cri);
}
