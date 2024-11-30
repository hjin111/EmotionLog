package com.emotionlog.mapper;

import static org.junit.Assert.assertNotEquals;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.emotionlog.domain.QboardVO;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:**/root-context.xml") // Spring 설정 파일 경로 (context 파일에 맞게 수정)
@Log4j
public class QnABoardMapperTests {

    @Autowired
    private QnABoardMapper QboardMapper;

    // QnA 전체 리스트 조회 테스트
    @Test
    public void testGetListQnA() {
        List<QboardVO> qnAList = QboardMapper.getListQnA();
        log.info("QnA 전체 리스트 조회 결과: " + qnAList);

        // 검증
        assertNotEquals(null, qnAList);
    }

    // QnA 등록 테스트
    @Test
    //@Transactional // 테스트 후 DB에 반영되지 않도록 설정
    public void testInsertQnA() {
        QboardVO qBoard = new QboardVO();
        //qBoard.setQno(5L);
        qBoard.setQtitle("테스트 제목");
        qBoard.setQcontent("테스트 내용");
        qBoard.setUsername("1"); // 작성자 ID (예시로 1L 사용)
        qBoard.setQdate(new Date());
        QboardMapper.insertQnA(qBoard);
        log.info("QnA 등록 성공: " + qBoard);

        // 등록 후 확인: qBoard의 qno 값이 자동 생성된 값으로 채워짐
        log.info("" + qBoard);
    }

    // QnA 수정 테스트
    @Test
    //@Transactional
    public void testUpdateQnA() {
        QboardVO qBoard = QboardMapper.readQnA(1L); // 예시로 qno가 1인 게시글을 조회
        if (qBoard != null) {
            qBoard.setQtitle("수정된 제목");
            qBoard.setQcontent("수정된 내용");

            int result = QboardMapper.updateQnA(qBoard);
            log.info("QnA 수정 결과: " + result);

            // 수정 후 결과 확인
            QboardVO updatedBoard = QboardMapper.readQnA(1L);
            log.info("수정된 QnA 제목: " + updatedBoard.getQtitle());
        }
    }

    // QnA 단건 조회 테스트
    @Test
    public void testReadQnA() {
        QboardVO qBoard = QboardMapper.readQnA(1L); // qno 1인 게시글을 조회
        log.info("QnA 조회 결과: " + qBoard);

        if (qBoard != null) {
            log.info("조회된 QnA 제목: " + qBoard.getQtitle());
        }
    }

    // QnA 삭제 테스트
    @Test
    //@Transactional
    public void testDeleteQnA() {
//        Long qno = 5L; // 삭제할 게시글 번호
        // 삭제 후 확인
        QboardMapper.deleteQnA(5L);
//        assertTrue(1==QboardMapper.deleteQnA(qno));
//        log.info("Delete Success"); // null이면 삭제 성공
    }
}
