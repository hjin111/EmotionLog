package com.emotionlog.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.emotionlog.domain.QboardVO;
import com.emotionlog.service.QnAService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/api/qna/*")
@AllArgsConstructor
public class QnAController {

    private QnAService qservice;

    // 메소드마다 인증 확인을 위한 공통 메소드
    private boolean isAuthenticated() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName());
    }

    // QnA 조회 - 전체
    @GetMapping(value = "/list")
    public String GetlistQnA(Model model) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }

            List<QboardVO> qnAList = qservice.getListQnA();
            model.addAttribute("qnaList", qnAList);
            return "/api/qna/list"; // JSP 경로: /api/qna/list.jsp
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // QnA 생성 - 폼
    @GetMapping(value = "/create")
    public String GetcreateQnA(Model model) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }
            return "/api/qna/create"; // JSP 경로: /api/qna/create.jsp
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // QnA 작성(등록)
    @PostMapping(value = "/create")
    public String createQnA(QboardVO qBoard, RedirectAttributes rttr) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }

            // 현재 인증된 사용자의 username을 가져옴
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String username = auth.getName();
            qBoard.setUsername(username);

            log.info("Create: " + qBoard);
            qservice.createQnA(qBoard);
            rttr.addFlashAttribute("result", qBoard.getQno()); // addFlashAttribute에 공백 사용 X
            return "redirect:/api/qna/detail?qno=" + qBoard.getQno();
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/api/qna/list"; // 에러 발생 시 작성 폼으로 리다이렉트
        }
    }
    
    // QnA 수정 - 폼
    @GetMapping(value = "/update")
    public String GetupdateQnA(@RequestParam("qno") Long qno, Model model) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }

            QboardVO qBoard = qservice.detailQnA(qno);
            model.addAttribute("qBoard", qBoard);
            return "/api/qna/update"; // JSP 경로: /api/qna/update.jsp
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // QnA 수정
    @PostMapping(value = "/update")
    public String updateQnA(QboardVO qBoard, RedirectAttributes rttr) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }

            // 현재 인증된 사용자의 username을 가져옴
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String username = auth.getName();
            qBoard.setUsername(username);

            log.info("Update: " + qBoard);
            qservice.updateQnA(qBoard);
            rttr.addFlashAttribute("result", "success");
            return "redirect:/api/qna/list"; // 수정 후 목록 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/api/qna/update?qno=" + qBoard.getQno(); // 에러 발생 시 수정 폼으로 리다이렉트
        }
    }

    // QnA 조회 - 단 건
    @GetMapping(value = "/detail")
    public String detailQnA(@RequestParam("qno") Long qno, Model model) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }

            QboardVO qBoard = qservice.detailQnA(qno);
            model.addAttribute("qBoard", qBoard);
            return "/api/qna/detail"; // JSP 경로: /api/qna/detail.jsp
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/qna/list"; // 에러 발생 시 목록 페이지로 리다이렉트
        }
    }

    // QnA 삭제
    @PostMapping(value = "/delete")
    public String deleteQnA(@RequestParam("qno") Long qno, RedirectAttributes rttr) {
        try {
            if (!isAuthenticated()) {
                return "redirect:/api/users/login";
            }

            log.info("Delete: " + qno);
            qservice.deleteQnA(qno);
            rttr.addFlashAttribute("result", "success");
            return "redirect:/api/qna/list";
        } catch(Exception e) {
            e.printStackTrace();
            return null;
        }		
    }
}
