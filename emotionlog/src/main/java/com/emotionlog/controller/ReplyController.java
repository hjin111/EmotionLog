package com.emotionlog.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.emotionlog.domain.Criteria;
import com.emotionlog.domain.ReplyPageDTO;
import com.emotionlog.domain.ReplyVO;
import com.emotionlog.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 스프링의 빈으로 인식할수 있게
@Log4j  
@RequestMapping("/api/replies/*") 
@AllArgsConstructor // BoardController는 BoardService에 대해서 의존적이므로 @AllArgsConstructor를 이용해서 생성자를 만들고 자동으로 주입하도록 한다!
public class ReplyController {
	private ReplyService service;
	
	/**
	 * 메소드명  : createReply (POST)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-25
	 * 내용      : 등록 작업
	 */
	@PostMapping(value ="/new",
				 consumes = "application/json",
				 produces = {MediaType.TEXT_PLAIN_VALUE} ) // JSON 방식의 데이터만 처리하도록, 문자열을 반환하도록
	public ResponseEntity<String> createReply(@RequestBody ReplyVO vo) // JSON 데이터를 ReplyVO 타입으로 변환하도록 지정(1.HTTP 요청본문읽기 2.JSON/XML 자동매핑)
	{
		log.info("ReplyVO: "+vo);
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT: "+ insertCount);
		
		return insertCount == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
								: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/**
	 * 메소드명  : getReply (GET)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-25
	 * 내용      : 댓글 조회
	 */
	@GetMapping(value ="/{rno}",
				produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> getReply(@PathVariable("rno") Long rno){
		log.info("get:"+rno);
		return new ResponseEntity<ReplyVO>(service.get(rno),HttpStatus.OK);
	}
	
	
	/**
	 * 메소드명  : removeReply (DELETE)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-25
	 * 내용      : 댓글 삭제
	 */
	@DeleteMapping(value="/{rno}"
				  ,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> removeReply(@PathVariable("rno") Long rno){
		log.info("remove: "+rno);
		return service.remove(rno) == 1
			 ? new ResponseEntity<String>("success",HttpStatus.OK)
			 : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	/**
	 * 메소드명  : modifyReply (PUT,PATCH)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-25
	 * 내용      : 댓글 수정
	 */
	@RequestMapping(method   = {RequestMethod.PUT,RequestMethod.PATCH},
					value    = "/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modifyReply(@RequestBody ReplyVO vo,
										 @PathVariable("rno") Long rno)
	{
		vo.setRno(rno);
		log.info("rno:"+rno);
		log.info("modify 수정수정"+vo);
		return service.modify(vo) == 1
				? new ResponseEntity<String>("success",HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/*
	 * // 특정 게시물의 댓글 목록 확인
	 * 
	 * @GetMapping(value = "/pages/{dno}/{page}", produces =
	 * {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	 * public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int
	 * page, @PathVariable("dno") Long dno){ log.info("getlist....."); Criteria cri
	 * = new Criteria(page,10); log.info(cri); return new
	 * ResponseEntity<>(service.getList(cri,dno), HttpStatus.OK); }
	 */
	
	/**
	 * 메소드명  : getListReply (GET)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-26
	 * 내용      : 새롭게 추가된 getListPage()를 호출하고 데이터를 전송하는 형태
	 */
	@GetMapping(value    = "/pages/{dno}/{page}",
			    produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getListReply(@PathVariable("page")int page,@PathVariable("dno") Long dno){
		Criteria cri = new Criteria(page,10);
		log.info("get Reply List dno : " + dno);
		log.info("cri:"+cri);
		return new ResponseEntity<ReplyPageDTO>(service.getListPage(cri, dno),HttpStatus.OK);
	}
	     
}
