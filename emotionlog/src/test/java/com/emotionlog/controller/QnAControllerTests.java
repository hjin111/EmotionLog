package com.emotionlog.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:**/*-context.xml")
@Log4j
public class QnAControllerTests {

    @Autowired
    private WebApplicationContext ctxQnA;

    private MockMvc mockMvc;

    @Before
    public void setupQnA() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctxQnA).build();
    }

    // QnA 조회 - 전체
    @Test
    public void testListQnA() throws Exception {
        log.info(mockMvc.perform(MockMvcRequestBuilders.get("/qna/list"))
                .andReturn()
                .getModelAndView()
                .getModelMap());
    }

    // QnA 등록 처리
    @Test
    public void testCreateQnA() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/qna/create")
                .param("qno", "5")
        		.param("qtitle", "테스트 제목")
                .param("qcontent", "테스트 내용")
                .param("username", "2")) 
                .andReturn()
                .getModelAndView()
                .getViewName();
        log.info("Result Page: " + resultPage);
    }

    // QnA 조회 - 단 건
    @Test
    public void testDetailQnA() throws Exception {
        log.info(mockMvc.perform(MockMvcRequestBuilders.get("/qna/detail")
                .param("qno", "1")) // QnA 번호
                .andReturn()
                .getModelAndView()
                .getModelMap());
    }

    // QnA 수정 처리
    @Test
    public void testUpdateQnA() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/qna/update")
                .param("qno", "1") // QnA 번호
                .param("qtitle", "수정된 제목")
                .param("qcontent", "수정된 내용")
                .param("username", "1"))
                .andReturn()
                .getModelAndView()
                .getViewName();
        log.info("Result Page: " + resultPage);
    }

    // QnA 삭제
    @Test
    public void testDeleteQnA() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/qna/delete")
                .param("qno", "1")) // QnA 번호
                .andReturn()
                .getModelAndView()
                .getViewName();
        log.info("Result Page: " + resultPage);
    }
}
