package com.emotionlog.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.emotionlog.domain.AboardVO;
import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QboardVO;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:**/*-context.xml")
@Log4j
public class AdminServiceTests {
	
	@Autowired
	AdminService service;
	
	@Test
	public void testGetUserList() throws Exception {
		service.getUserList().forEach(u -> log.info(u));
	}
	
	@Test
	public void testGetDiaryCountsByDateRange() throws Exception {
		List<DiaryCountsVO> result = service.getDiaryCountsByDateRange();
		
		// assertNotNull 순서: 메시지, 테스트 객체
        assertNotNull("결과가 null입니다.", result);
        assertTrue("7일 단위 데이터가 아닙니다.", result.size() <= 7);

        for (DiaryCountsVO diaryCounts : result) {
            assertNotNull("날짜 정보가 null입니다.", diaryCounts.getRegdateStr());
            assertTrue("작성된 일기 수는 음수일 수 없습니다.", diaryCounts.getDailyCount() >= 0);
        }
        
	}
	
	@Test
	public void testGetQboardList() throws Exception {
	    List<QboardVO> qboardList = service.getQboardList();
	    log.info("QnA List: " + qboardList);
	}

	@Test
	public void testGetQboardDetails() throws Exception {
		Long qno = 2L;
		QboardVO vo = service.getQboardDetails(qno);
	}
	
	@Test
	public void testGetAnswer() throws Exception {
		Long qno = 1L;
		AboardVO vo = service.getAnwser(qno);
		log.info(vo);
	}
	
//	@Transactional
	@Test
	public void testCreateAnswer() throws Exception {
		AboardVO vo = new AboardVO();
		vo.setAtitle("RE: 테스트");
		vo.setAcontent("테스트 본문");
		vo.setUsername("1");
		vo.setQno(1L);
		
		service.createAnswer(vo);
		
		log.info(vo);
		
	}
	
}
