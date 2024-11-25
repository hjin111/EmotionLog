package com.emotionlog.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.emotionlog.domain.Criteria;
import com.emotionlog.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:**/*-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private Long[] dnoArr = {1L,2L,3L,4L,5L,6L,7L,8L,9L,10L};
	
	@Autowired
	private ReplyMapper mapper;
	
	@Test 
	public void testMapper() {
		log.info(mapper);
	}
	
	// 등록 (create)
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i-> {
			ReplyVO vo = new ReplyVO();
			
			// 게시물의 번호
			vo.setDno(dnoArr[i%5]);
			vo.setReply("댓글테스트" +i);
			vo.setReplyer("replyer" +i);
			
			mapper.insert(vo);
		});
	}
	
	// 조회(read)
	@Test
	public void testRead() {
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	// 삭제(delete)
	@Test
	public void testDelete() {
		Long targetRno = 1L;
		mapper.delete(targetRno);
	}
	
	// 수정(update)
	@Test
	public void testUpdate() {
		Long targetRno = 10L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update Reply");
		
		int count = mapper.update(vo);
		
		log.info("UPDATE COUNT:" + count);
	}
	
	// 페이징 처리(list)
	@Test
	public void testList() {
		Criteria cri= new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, dnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
}
