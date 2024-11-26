package com.emotionlog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/api/admin/*")
@AllArgsConstructor
public class AdminController {
	
	// 전체 회원 리스트 조회
	@GetMapping("/users")
	public void getUserList() {
		
	}
	
	// 날짜별 작성된 일기 수 조회
	@GetMapping("/diary-counts")
	public void getDiaryCountsByDateRange() {
		
	}
	

}
