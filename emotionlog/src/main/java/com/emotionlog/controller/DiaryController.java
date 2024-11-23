package com.emotionlog.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
	private DiaryService service;
	
	/**
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-22
	 * 내용      : 목록에 대한 처리
	 */
	@GetMapping("/list")
	public String list(@RequestParam(value = "selectedDate", required = false) String selectedDate,@RequestParam(value = "regdate", required = false) String regdate,@RequestParam(value = "username", required = false) Long username,Model model) {
		try {
			// 회원 아이디 부분
			username = 2L;
			log.info("여기다아아아아앙아1"+ selectedDate);
			log.info("여기다아아아아앙아2"+ regdate);
	        
			String pickdate = null;
			if (selectedDate == null && regdate == null ) { // 처음 pickdate
	        	log.info("date 가 널이 지롱 ~~~~~~ㅎㅎㅎㅎㅎ");
	            LocalDate today = LocalDate.now();
	            pickdate = today.format(DateTimeFormatter.ofPattern("yyyy/MM"));
	        }
			else if(selectedDate != null && regdate == null) { // selectedDate
				pickdate = selectedDate;
			}
			else if(selectedDate == null && regdate != null) { // regdate
				pickdate= regdate;
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

	        model.addAttribute("year", year);
	        model.addAttribute("month", month);
	        model.addAttribute("dayOfWeek", dayOfWeek);
	        model.addAttribute("endDay", endDay);
	        model.addAttribute("pick_date", pickdate); // date도 추가
	        model.addAttribute("username", username);


	        // getlist.....
			DiaryVO diary = new DiaryVO();
			diary.setUsername(username);
			// Date 객체로 변환
			Date date_regdate = c.getTime();
		    diary.setRegdate(date_regdate); 
		    List<DiaryVO> dia = service.getList(diary);
		    log.info(dia);
		    for (DiaryVO d : dia) {
		        if (d.getRegdate() != null) {
		        	log.info("regdate type: " + d.getRegdate().getClass().getName());
		        }

		    }
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
	
//	// 페이징 처리!!
//	@GetMapping("/list")
//	public void list(Criteria cri ,Model model) {
//		try {
//			log.info("list......."+cri);
//			model.addAttribute("list",service.getList(cri));
//			// BoardController 에서는 PageDTO 를 사용할 수 있또록 Model에 담아서 화면에 전달해줄 필요가 있씁니당~
//			// 페이징 처리를 위한 클래스 설계
////			model.addAttribute("pageMaker",new PageDTO(cri,123)); // 전체페이지 123
//			
//			// 전체 페이지 개수
//			int total = service.getTotal(cri);
//			log.info("total: "+total);
//			model.addAttribute("pageMaker",new PageDTO(cri,total));
//		} catch (Exception e) {
//			// 유저에게 보여줄 메시지 리턴
//			// 이동 할 곳도 지정할수도
//			e.printStackTrace();
//			
//		}
//	}
//	
	//2. 등록 처리와 테스트
	// addFlashAttribute 의 경우 일회성으로만 데이터를 전달, 보관된 데이터는 단 한번만 사용할수 있게 보관
	@PostMapping("/register")
	public String register(DiaryVO diary, RedirectAttributes rttr) {
		try {
			log.info("register: "+diary);
			service.register(diary);
			rttr.addFlashAttribute("result",diary.getDno()); // 값 유지 하기 위해서 RedirectAttributes -> 세션 사용
			return "redirect:/api/diary/list"; // 새로운 화면으로 ,url 재이동
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// 게시물의 등록 작업은 POST 방식으로 처리하지만, 화면에서 입력을 받아야하므로
	// GET방식으로 입력 페이지를 볼 수 있도록~
	@GetMapping("/register")
	public void register(@RequestParam("regdate") String regdate,@RequestParam("username") Long username,Model model) {
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
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 조회 처리
	 */
	@GetMapping({"/get","/modify"})
	public void get (@RequestParam("dno") Long dno, Model model) {
		try {
			model.addAttribute("diary",service.get(dno));   
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 수정 처리
	 */
	@PostMapping("/modify")
	public String modify(@ModelAttribute DiaryVO diary,RedirectAttributes rttr) {
		try {
			if(service.modify(diary)) {
				rttr.addFlashAttribute("result","success");
			}

            System.out.println("Modify Request: " + diary);
			return "redirect:/api/diary/list" ;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 작성자    : 박혜정
	 * 작성일    : 2024-11-23
	 * 내용      : 삭제 처리
	 */
	@PostMapping("/remove")
	public String remove(@RequestParam("dno") Long dno, RedirectAttributes rttr) {
		try {
			if(service.remove(dno)) {
				rttr.addFlashAttribute("result","success");
			}
			
			return "redirect:/api/diary/list" ;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
