package com.emotionlog.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/api/admin")
@AllArgsConstructor
public class AdminController {
	
	private AdminService service;
	
	// 관리자 페이지 접속
	@GetMapping("")
	public String accessAdmin() {
		return "api/admin/admin";
	}
	
	
	// 전체 회원 리스트 조회(뷰
	@GetMapping("/users")
	public void getUserList() {
		
	}
	
	// 날짜별 작성된 일기 수 조회
	@GetMapping("/diary-counts")
	@ResponseBody
	public ResponseEntity<List<DiaryCountsVO>> getDiaryCountsByDateRange() {
		try {
			List<DiaryCountsVO> diaryCounts = service.getDiaryCountsByDateRange();
	        return new ResponseEntity<>(diaryCounts, HttpStatus.OK);
		} catch (Exception e) {
			 return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	// 미답변 문의 리스트 조회
	@GetMapping("/qna")
	public void getQboardList() {
		
	}
	
	// QnA 문의 상세 조회
	@GetMapping("/qna/{qno}")
	public void getQboardDetails() {
		
	}
	
	// QnA 문의 답변 조회
	@GetMapping("/qna/answer/{qno}")
	public void getAnswer() {
		
	}
	
	// QnA 답변 작성
	@PostMapping("/qna/answer/{qno}")
	public void createAnswer() {
		
	}

}
