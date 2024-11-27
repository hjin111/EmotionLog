package com.emotionlog.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
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

import com.emotionlog.domain.UsersVO;
import com.emotionlog.service.UsersService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/api/users/*")
@AllArgsConstructor // 생성자도 만들고 서비스를 주입 받아서 여기다가 주입 할거임
public class UsersController {
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	private UsersService service;
	
	// logger.info("Authenticated User: " + authentication.getName()); 이거 찍을려고 주입한거임
	private static final Logger logger = LoggerFactory.getLogger(UsersController.class);
	
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
    
    @PostMapping("/login")
    public String usersLogin(@RequestParam String username, @RequestParam String password, Model model) {
        try {
            UsernamePasswordAuthenticationToken token =
                    new UsernamePasswordAuthenticationToken(username, password);

            log.info("Attempting authentication for username: " + username);
            

            // 인증 처리
            Authentication authentication = authenticationManager.authenticate(token);
            
            log.info("Authentication successful: " + authentication);
            logger.info("Authenticated User: " + authentication.getName());

            // 인증 정보를 SecurityContext에 저장
            SecurityContextHolder.getContext().setAuthentication(authentication);
            log.info("SecurityContext 저장 완료");

            model.addAttribute("username", username);

            return "redirect:/api/users/success";
        } catch (Exception e) {
            log.error("Authentication failed: ", e);
            model.addAttribute("error", "Invalid username or password");
            return "/api/users/login";
        }
    }

    @GetMapping("/success")
    public String usersProfile(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        log.info("Authentication: " + authentication);

        // 인증 정보가 null인 경우를 처리
        if (authentication == null) {
            log.warn("Authentication is null, redirecting to login page");
            return "redirect:/api/users/login"; // 인증이 없으면 로그인 페이지로 리디렉션
        }

        Object principal = authentication.getPrincipal();
        log.info("Principal: " + principal);

        if (principal instanceof UsersVO) {
            // CustomUserDetailsService가 반환한 사용자 객체인 경우
            UsersVO user = (UsersVO) principal;
            model.addAttribute("username", user.getUsername());
        } else if (principal instanceof org.springframework.security.core.userdetails.User) {
            // Spring Security 기본 UserDetails 객체인 경우
            User user = (User) principal;
            model.addAttribute("username", user.getUsername());
        } else {
            model.addAttribute("username", authentication.getName()); // 기본 처리
        }

        return "/api/users/success"; // success.jsp 반환
    }

    @GetMapping("/mypage")
    public void myPage(Model model) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	User user = (User) authentication.getPrincipal();
    	
    	String username = user.getUsername();
    
    	model.addAttribute("users", service.readMypage(username));
    	
    }
    

}
