package com.emotionlog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.emotionlog.domain.Criteria;
import com.emotionlog.domain.ReplyPageDTO;
import com.emotionlog.domain.ReplyVO;
import com.emotionlog.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service // 비즈니스 영역을 담당하는 객체임을 표시, 작성된 어노테이션은 패키지를 읽어 들이는 동안 처리
@AllArgsConstructor // 모든 파라미터를 이용하는 생성자
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO vo) {
		log.info("register....."+vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get....."+rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify....."+vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("remove....."+rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long dno) {
		log.info("get Reply List of a Board" + dno);
		return mapper.getListWithPaging(cri, dno);
	}

	// 댓글과 댓글수 처리
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long dno) {
		
		return new ReplyPageDTO(mapper.getCountByDno(dno),mapper.getListWithPaging(cri, dno));
	}
	
}
