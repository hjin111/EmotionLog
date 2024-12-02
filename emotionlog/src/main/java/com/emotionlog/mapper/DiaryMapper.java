/**
 * 작성자    : 박혜정
 * 작성일    : 2024-11-22
 */

package com.emotionlog.mapper;

import java.util.List;

import com.emotionlog.domain.DiaryVO;


public interface DiaryMapper {

	// 월별 일기 리스트
	public List<DiaryVO> getList(DiaryVO diary);
	
	// 1. create(select) 처리
	// insert 만 처리되고 생성된 pk 값은 알 필요가 없는 경우
	public void insert(DiaryVO diary);
//	
	// insert문이 실행되고 생성된 pk 값을 알아야 하는 경우
	public void insertSelectKey(DiaryVO diary);
//	
	// 2. read(select) 처리
	public DiaryVO read(Long dno);
//	
//	// 3. delete 처리
	public int delete(Long dno);
//	
	// 4.update 처리
	public int update(DiaryVO diary);
	
//	// 페이징 처리 : Criteria 타입을 파라미터로 사용하는 메서드
//	public List<BoardVO> getListWithPaging(Criteria cri);
//	
//	// 전체 데이터의 개수
//	public int getTotalCount(Criteria cri);
}
