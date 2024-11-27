package com.emotionlog.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.emotionlog.domain.DiaryCountsVO;
import com.emotionlog.domain.QboardVO;
import com.emotionlog.domain.UsersVO;
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
	
	// 전체 회원 리스트 조회
	@GetMapping("/users")
	public String getUserList(Model model) {
	    try {
	        List<UsersVO> userList = service.getUserList(Integer.MAX_VALUE);
	        model.addAttribute("users", userList);
	        
	        return "api/admin/userList";  // 전체 페이지 렌더링 (userList.jsp)
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";  // 에러 페이지
	    }
	}
	
	
	// 회원 리스트 조회(5)
	@GetMapping("/userpart")
	@ResponseBody
	public ResponseEntity<List<UsersVO>> getUserListAjax(@RequestParam(value = "limit", required = false) Integer limit) throws Exception {
        if (limit == null) {
            limit = Integer.MAX_VALUE;  // limit이 없으면 모든 데이터를 조회
        }

        List<UsersVO> userList = service.getUserList(limit);

        if (userList.isEmpty()) {
            // 데이터가 없을 경우 404 상태 코드와 함께 빈 리스트 반환
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        // 데이터를 정상적으로 가져온 경우 200 OK와 데이터 반환
        return new ResponseEntity<>(userList, HttpStatus.OK);
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
	// 미답변 문의 리스트 조회(5)
	@GetMapping("/qna")
	@ResponseBody
	public ResponseEntity<List<QboardVO>> getQboardList(@RequestParam(value = "limit", required = false) Integer limit) throws Exception {
		if (limit == null) {
            limit = Integer.MAX_VALUE;  // limit이 없으면 모든 데이터를 조회
        }

        List<QboardVO> qList = service.getQboardList(limit);

        if (qList.isEmpty()) {
            // 데이터가 없을 경우 404 상태 코드와 함께 빈 리스트 반환
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        // 데이터를 정상적으로 가져온 경우 200 OK와 데이터 반환
        return new ResponseEntity<>(qList, HttpStatus.OK);
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
