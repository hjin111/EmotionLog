package com.emotionlog.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.emotionlog.domain.Criteria;
import com.emotionlog.domain.ReplyVO;

public interface ReplyMapper {

	// 등록(create)
	public int insert(ReplyVO vo);
	
	// 조회(read)
	public ReplyVO read(Long rno); // 특정 댓글 읽기
	
	// 삭제(delete)
	public int delete(Long rno);
	
	// 수정(update)
	public int update(ReplyVO reply);
	
	// 페이징 -> 일딴 추후에
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("dno") Long dno);
}
