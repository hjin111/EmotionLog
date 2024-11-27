package com.emotionlog.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.emotionlog.domain.DiaryVO;
import com.emotionlog.service.DiaryService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller // 스프링의 빈으로 인식할수 있게
@Log4j  
@RequestMapping("/api/diary/*") 
@AllArgsConstructor // BoardController는 BoardService에 대해서 의존적이므로 @AllArgsConstructor를 이용해서 생성자를 만들고 자동으로 주입하도록 한다!
public class DiaryController {
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	private DiaryService service;
	
	/**
	 * 메소드명  : listDiary (GET)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-22
	 * 내용      : 목록에 대한 처리
	 */
	@GetMapping("/list")
	public String listDiary(@RequestParam(value = "selectedDate", required = false) String selectedDate
					  ,@RequestParam(value = "regdate", required = false) String regdate
					  ,@ModelAttribute(value = "regdate") String regdateFromModel
					  ,@RequestParam(value = "username", required = false) String username
					  ,Model model) {
		try {
	
			// 회원 아이디 부분
			 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			 User user = (User) authentication.getPrincipal();			
			username = user.getUsername();

			// pick date 설정 부분
	        String pickdate = null;
	        // 원래 문자열을 LocalDate로 파싱
	        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	        // "yyyy/MM" 형식으로 포맷팅
	        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy/MM");

	        
	        if (selectedDate == null && regdate == null && (regdateFromModel == null || regdateFromModel.equals(""))) {
	            // 초기 pickdate 설정
	            LocalDate today = LocalDate.now();
	            pickdate = today.format(DateTimeFormatter.ofPattern("yyyy/MM"));
	        } else if (selectedDate != null) {
	        	pickdate = selectedDate;
	        } else if (regdate != null) {
	            LocalDate date = LocalDate.parse(regdate, inputFormatter);
	            String formattedDate = date.format(outputFormatter);
	            pickdate = formattedDate;
	        } else if (regdateFromModel != null && !regdateFromModel.equals("")) {	                       
	            LocalDate date = LocalDate.parse(regdateFromModel, inputFormatter);
	            String formattedDate = date.format(outputFormatter);
	            pickdate = formattedDate;
	        }
			
			
	        // 입력받은 date 파싱 (예: 2024/11)
	        String[] parts = pickdate.split("/");
	        int year = Integer.parseInt(parts[0]);
	        int month = Integer.parseInt(parts[1]);

	        // Calendar 객체 생성
	        Calendar c = Calendar.getInstance();
	        c.set(Calendar.YEAR, year);
	        c.set(Calendar.MONTH, month - 1); // 0부터 시작
	        c.set(Calendar.DAY_OF_MONTH, 1);

	        // 달력 관련 데이터 계산
	        int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
	        int endDay = c.getActualMaximum(Calendar.DAY_OF_MONTH);

	        // 달력 관련 변수 보내기~~
	        model.addAttribute("year", year);
	        model.addAttribute("month", month);
	        model.addAttribute("dayOfWeek", dayOfWeek);
	        model.addAttribute("endDay", endDay);
	        model.addAttribute("pick_date", pickdate);
	        model.addAttribute("username", username);


	        // diary 변수 보내기 ~~
			DiaryVO diary = new DiaryVO();
			diary.setUsername(username);
			Date date_regdate = c.getTime();			// Date 객체로 변환
		    diary.setRegdate(date_regdate); 
		    List<DiaryVO> dia = service.getList(diary);
		    log.info(dia);

		    model.addAttribute("diary",dia);

	        // AJAX 요청에 응답할 JSP 반환
	        return "/api/diary/list"; // JSP의 특정 부분만 반환
			
		} catch (Exception e) {
			// 유저에게 보여줄 메시지 리턴
			// 이동 할 곳도 지정할수도
	        e.printStackTrace();
	        return "error"; // 오류 페이지 반환
			
		}
	}
	
	/**
	 * 메소드명  : registerDiary (POST)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 등록 처리 
	 */ 
	// addFlashAttribute 의 경우 일회성으로만 데이터를 전달, 보관된 데이터는 단 한번만 사용할수 있게 보관
	@PostMapping("/register")
	public String registerDiary(DiaryVO diary, RedirectAttributes rttr) {
		try {
			log.info("register: "+diary);
			service.register(diary);
			rttr.addFlashAttribute("result",diary.getDno()); // 값 유지 하기 위해서 RedirectAttributes -> 세션 사용
	        // SimpleDateFormat 사용하여 Date를 String으로 변환
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
	        String formattedDate = dateFormat.format(diary.getRegdate());
			rttr.addFlashAttribute("regdate", formattedDate);
			log.info("regdate!!!!!!!!!!!!: "+diary.getRegdate());

			return "redirect:/api/diary/list"; // 새로운 화면으로 ,url 재이동
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 메소드명  : registerDiary (GET)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 등록 처리
	 */
	// 게시물의 등록 작업은 POST 방식으로 처리하지만, 화면에서 입력을 받아야하므로
	// GET방식으로 입력 페이지를 볼 수 있도록~
	@GetMapping("/register")
	public void registerDiary(@RequestParam("regdate") String regdate
						,@RequestParam("username") String username
						,Model model) {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date regdate_df = dateFormat.parse(regdate);  // Date 객체로 변환

			model.addAttribute("regdate",regdate_df);
			model.addAttribute("username",username);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * 메소드명  : getDiary (GET)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 조회 처리 
	 */
	@GetMapping({"/get","/modify"})
	public void getDiary(@RequestParam("dno") Long dno, Model model) {
		try {
			model.addAttribute("diary",service.get(dno));   
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 메소드명  : modifyDiary (POST)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 수정 처리
	 */
	@PostMapping("/modify")
	public String modifyDiary(@ModelAttribute DiaryVO diary,RedirectAttributes rttr) {
		try {
			if(service.modify(diary)) {
				rttr.addFlashAttribute("result","success");
				// SimpleDateFormat 사용하여 Date를 String으로 변환
		        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		        String formattedDate = dateFormat.format(diary.getRegdate());
				rttr.addFlashAttribute("regdate", formattedDate);			
			}

            System.out.println("Modify Request: " + diary);
			return "redirect:/api/diary/list" ;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 메소드명  : removeDiary (POST)
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 삭제 처리
	 */
	@PostMapping("/remove")
	public String removeDiary(@ModelAttribute DiaryVO diary, RedirectAttributes rttr) {
		try {
			if(service.remove(diary.getDno())) {
				rttr.addFlashAttribute("result","success");
				// SimpleDateFormat 사용하여 Date를 String으로 변환
		        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		        String formattedDate = dateFormat.format(diary.getRegdate());
				rttr.addFlashAttribute("regdate", formattedDate);			
				}
			
			return "redirect:/api/diary/list" ;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
