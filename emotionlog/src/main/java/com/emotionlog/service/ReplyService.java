package com.emotionlog.service;

import java.util.List;

import com.emotionlog.domain.Criteria;
import com.emotionlog.domain.ReplyPageDTO;
import com.emotionlog.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri , Long dno);
	
	//// 댓글과 댓글수 처리 -> ReplyPageDTO 를 반환하는 메소드
	public ReplyPageDTO getListPage(Criteria cri, Long dno);
}
