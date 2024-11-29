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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	// 회원가입
	@GetMapping("/join")
	 public String joinForm(Model model) {
        model.addAttribute("user", new UsersVO()); // 새로운 UsersVO 객체를 모델에 추가하여 폼에 전달
        return "/api/users/join"; // join.jsp (회원가입 화면)
    }
	
	// 아이디 중복 체크
	@GetMapping(value = "/check-username", produces = "application/json") // JSON으로 응답 요청
	@ResponseBody
	public int checkUsername(@RequestParam String username) {
	    int check = service.idCheck(username);
	    return check;  
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
            model.addAttribute("error", "입력하신 정보가 일치하지 않습니다. 다시 시도해 주세요.");
            return "/api/users/login";
        }
    }

    @GetMapping("/success")
    public String usersLoginSuccess(Model model) {
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
            model.addAttribute("username", authentication.getName()); 
        }

        return "/api/users/success"; 
    }

    // 마이페이지 조회
    @GetMapping("/mypage")
    public void myPage(Model model) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	User user = (User) authentication.getPrincipal();
    	
    	String username = user.getUsername();
    
    	model.addAttribute("users", service.readMypage(username));
    	
    }
    
    // 마이페이지 수정
    @GetMapping("/mypageModify")
    public String myPageModify(Model model) {
    	
    	  Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
          User user = (User) authentication.getPrincipal();
          String username = user.getUsername();

          // 수정할 사용자 모델에 추가
          UsersVO users = service.readMypage(username);
          model.addAttribute("users", users);

          return "/api/users/mypageModify"; 
    	
    }
    
    
    // 마이페이지 수정 처리
    @PostMapping("/mypageModify")
    public String myPageModify(@ModelAttribute UsersVO updatedUser, Model model) {
        try {
        	
            service.update(updatedUser);
            
            model.addAttribute("message", "succeess");
            return "redirect:/api/users/mypage"; 
        } catch (Exception e) {
            log.error("Error updating", e);
            model.addAttribute("error", "fail");
            return "/api/users/mypageModify"; 
        }
    }
    
    // 사용자 삭제 처리
    @PostMapping("/delete")
    public String deleteUser(@RequestParam("username") String username, Model model) {
        try {
            service.delete(username);  
            model.addAttribute("message", "success");
            return "redirect:/";
        } catch (Exception e) {
            log.error("Error deleting user: ", e);
            model.addAttribute("error", "error");
            return "redirect:/api/users/login";
        }
    }
    
    
    @GetMapping("/findusername")
    public String findUsername() {
        return "/api/users/findusername";
    }
    
    
    // 아이디 찾기(이름, 전화번호 입력)
    @PostMapping("/findusername")
    public String findUsername(@RequestParam("name") String name, 
    			@RequestParam("phone_number") String phone_number,
    			RedirectAttributes redirectAttributes) {
		try {

			String username = service.findUsername(name, phone_number);
			redirectAttributes.addFlashAttribute("username", username);
			return "redirect:/api/users/findusersuccess";
		} catch (Exception e) {
			log.error("Error: ", e);
			redirectAttributes.addFlashAttribute("error", "아이디를 찾을 수 없습니다.");
			return "redirect:/api/users/findusername";
		}
    }
    
    @GetMapping("/findusersuccess")
    public String findUserSuccess() {
        return "/api/users/findusersuccess";  
    }
    
    
    
    // 비밀번호 변경 페이지
    @GetMapping("/passwordupdate")
    public String passwordUpdate() {
        return "/api/users/passwordupdate";
    }
    
    
    // 비밀번호 변경 처리
    @PostMapping("/passwordupdate")
    public String passwordUpdate(@RequestParam("username") String username,
                                 @RequestParam("phone_number") String phone_number,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 Model model) {
    	
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "새 비밀번호가 일치하지 않습니다.");
            return "/api/users/passwordupdate"; // 비밀번호 불일치시 폼으로 돌아감
        }

        // 아이디와 전화번호로 사용자 검색
        UsersVO user = service.findByUser(username, phone_number);

        if (user == null) {
            model.addAttribute("error", "아이디 또는 전화번호가 일치하지 않습니다.");
            return "/api/users/passwordupdate"; // 사용자 정보 불일치시 폼으로 돌아감
        }

        service.updatePassword(username, newPassword);

        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        return "redirect:/api/users/pwsuccess"; 
    }
    
    @GetMapping("/pwsuccess")
    public String findPwSuccess() {
        return "/api/users/pwsuccess";  
    }

 
    
}
