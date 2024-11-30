package com.emotionlog.service;

import java.util.List;

import com.emotionlog.domain.QboardVO;

public interface QnAService {

    // QnA 조회 - 전체
    public List<QboardVO> getListQnA() throws Exception;

    // QnA 등록
    public void createQnA(QboardVO qBoard) throws Exception;

    // QnA 수정
    public boolean updateQnA(QboardVO qBoard) throws Exception;

    // QnA 조회 - 단 건
    public QboardVO detailQnA(Long qno) throws Exception;

    // QnA 삭제
    public boolean deleteQnA(Long qno) throws Exception;
}
