package com.emotionlog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/qna/*")
@AllArgsConstructor

public class QnAController {

	@Autowired
	private QnAService qservice;

	// QnA 조회 - 전체
	@GetMapping(value = "/list")
	public String GetlistQnA(Model model) {
		try {
			List<QboardVO> qnAList = qservice.getListQnA();
			model.addAttribute("qnaList", qnAList);
			return "qna/list"; // JSP 경로: qna/list.jsp
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// QnA 작성(등록)
	@PostMapping(value = "/create")
	public String createQnA(QboardVO qBoard, RedirectAttributes rttr) {
		try {
			log.info("Create: " + qBoard);
			qservice.createQnA(qBoard);
			rttr.addFlashAttribute("result: ", qBoard.getQno());
			return "redirect:/qna/list"; // 등록 후 목록 페이지로 리다이렉트
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	// QnA 수정
	@PostMapping(value = "/update")
	public String updateQnA(QboardVO qBoard, RedirectAttributes rttr) {
		try {
			log.info("Update: " + qBoard);
			qservice.updateQnA(qBoard);
			rttr.addFlashAttribute("result", "success");
			return "redirect:/qna/list";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}	
	
	// QnA 조회 - 단 건
	@GetMapping(value = "/detail")
	public String detailQnA(QboardVO qBoard, @RequestParam("qno") Long qno, Model model) {
		try {
			qservice.detailQnA(qno);
			model.addAttribute("qBoard", qBoard);
			return "qna/detail"; // JSP 경로: qna/detail.jsp
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// QnA 삭제
	@PostMapping(value = "/delete")
	public String deleteQnA(@RequestParam("qno") Long qno, RedirectAttributes rttr) {
		try {
			log.info("Delete: " + qno);
			qservice.deleteQnA(qno);
			rttr.addFlashAttribute("result", "success");
			return "redirect:/qna/list";
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}		
	}
}