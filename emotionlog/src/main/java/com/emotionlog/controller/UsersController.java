package com.emotionlog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.emotionlog.domain.UsersVO;
import com.emotionlog.service.UsersService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/api/users/*")
@AllArgsConstructor // 생성자도 만들고 서비스를 주입 받아서 여기다가 주입 할거임
public class UsersController {
	
	private UsersService service;
	
	@GetMapping("/join")
	 public String joinForm(Model model) {
        model.addAttribute("user", new UsersVO()); // 새로운 UsersVO 객체를 모델에 추가하여 폼에 전달
        return "/api/users/join"; // join.jsp (회원가입 화면)
    }

    // 회원가입 요청 처리
    @PostMapping("/join")
    public String usersJoin(@ModelAttribute UsersVO user, String authority) throws Exception {
        service.join(user, authority);
        return "redirect:/api/users/login"; 
    }
    
    
    @GetMapping("/login")
    public String loginForm() {
        return "/api/users/login";
    }
    
    // 로그인 요청 처리
    
    

}
