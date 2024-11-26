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

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QnAVO;
import com.emotionlog.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:**/*-context.xml")
@Log4j
public class AdminServiceTests {
	
	@Autowired
	AdminService service;
	
	@Autowired
	AdminMapper mapper;
	
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
	public void testGetQnaList() throws Exception {
	    List<QnAVO> qnaList = service.getQnaList();
	    log.info("QnA List: " + qnaList);
	}

	@Test
	public void testGetQnaDetail() throws Exception {
		Long testQno = 2L;
		QnAVO vo = mapper.getQnaDetails(testQno);
	}
}
