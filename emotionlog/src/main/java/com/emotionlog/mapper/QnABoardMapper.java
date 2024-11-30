package com.emotionlog.mapper;

import java.util.List;

import com.emotionlog.domain.QboardVO;

public interface QnABoardMapper {
    // QnA 전체리스트 조회
    public List<QboardVO> getListQnA();

    // QnA 등록
    public void insertQnA(QboardVO qBoard);

    // QnA 수정
    public int updateQnA(QboardVO qBoard);

    // QnA 조회 - 단 건
    public QboardVO readQnA(Long qno);

    // QnA 삭제
    public int deleteQnA(Long qno);
}
