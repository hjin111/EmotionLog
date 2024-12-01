package com.emotionlog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.emotionlog.domain.QboardVO;
import com.emotionlog.mapper.QnABoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class QnAServiceImpl implements QnAService {

    private QnABoardMapper qmapper;

    // QnA 조회 - 전체
    @Override
    public List<QboardVO> getListQnA() throws Exception{
        return qmapper.getListQnA();
    }

    // QnA 등록
    @Override
    public void createQnA(QboardVO qBoard) throws Exception {
        log.info("Create..." + qBoard);
    	qmapper.insertQnA(qBoard);
    }

    // QnA 수정
    @Override
    public boolean updateQnA(QboardVO qBoard) throws Exception {
        log.info("updated...." + qBoard);
    	if(qmapper.updateQnA(qBoard)==0)
    		throw new RuntimeException(qBoard.getQno() + "번 게시물이 수정되지 않음.");
    	return true;
    }

    // QnA 조회 - 단 건
    @Override
    public QboardVO detailQnA(Long qno) throws Exception{
        log.info("Detail..."+qno);
        QboardVO qBoard = qmapper.readQnA(qno);
        if(qBoard==null)
        	throw new RuntimeException(qBoard.getQno() + "번 게시물이 존재하지 않습니다.");
    	return qmapper.readQnA(qno);
    }

    // QnA 삭제
    @Override
    public boolean deleteQnA(Long qno) throws Exception {
        log.info("Delete...."+ qno);
        if(qmapper.deleteQnA(qno)==0) //삭제되지 않으면-
        	throw new RuntimeException(qno + "번 게시물이 삭제되지 않음");
    	return true;
    }
}
