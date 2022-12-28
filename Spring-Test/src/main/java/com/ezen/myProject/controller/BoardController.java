package com.ezen.myProject.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.FileVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.handler.FileHandler;
import com.ezen.myProject.handler.PagingHandler;
import com.ezen.myProject.repository.UserDAO;
import com.ezen.myProject.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Inject
	private BoardService bsv;
	@Inject
	private UserDAO userDao;
	
	@Inject
	private FileHandler fhd;
	
	
	@GetMapping("/register")
	public String boardRegisterGet() {
		return "/board/register";
	}
	
	
	@PostMapping("/register")
	public String register(BoardVO bvo, RedirectAttributes reAttr,
			@RequestParam(name="files", required = false) MultipartFile[] files) { // required = false : files이 null 이라도 메서드 들어올 수 있게
		log.info(">>> bvo register " + bvo.toString());
		log.info(">>> files register " + files.toString());
		List<FileVO> fList = null; // 파일에 리스트를 담을 객체 준비
		if(files[0].getSize() > 0) { // files 에 데이터가 담겨 있음
			fList = fhd.uploadFiles(files); // FileHandler야 리스트 줘~
		} else {
			log.info("empty file");
			fList = new ArrayList<FileVO>();
		}
		
		int isOk = bsv.registerFile(new BoardDTO(bvo, fList));
		
//		int isOk = bsv.register(bvo);
		
		reAttr.addFlashAttribute("isOk", isOk > 0 ? "1" : "0"); // setAttribute 와 같음
		log.info("board register >> " + (isOk > 0 ? "OK" : "Fail"));
		return "redirect:/board/list";
	}
	
	// list, 페이징, 검색
	@GetMapping("/list") 
	public String list(Model model, PagingVO pvo) {
		log.info(">>> pageNo : " + pvo.getPageNo());
		List<BoardVO> list = bsv.getList(pvo);
		model.addAttribute("list", list);
		int totalCount = bsv.getPageCnt(pvo); // 전체 카운트 호출
		PagingHandler pgh = new PagingHandler(pvo, totalCount); // limit 이용한 한페이지 리스트 호출
		model.addAttribute("pgh", pgh);
		return "/board/list";
	}
	
	
//	@GetMapping("/detail")
//	public String detail(Model model, @RequestParam("bno") int bno) {
//		BoardVO board = bsv.getDetail(bno);
//		model.addAttribute("board", board);
//		return "/board/detail";
//	}
	
	
	// void 하고 return 없이 해도 가능
	// mapping인 detail로 다시 돌아가기 때문
	@GetMapping({"/detail", "/modify"})
	public void detail(Model model, @RequestParam("bno") int bno) { 
		BoardDTO bdto = bsv.getDetailFile(bno);
//		BoardVO board = bsv.getDetail(bno);
		log.info(">>> bdto.bvo : " + bdto.getBvo().toString()); // bvo
//		log.info(">>> bdto.fList : " + bdto.getFList().get(0).toString()); // fList
//		model.addAttribute("board", board);
		model.addAttribute("board", bdto.getBvo());
		model.addAttribute("fList", bdto.getFList());
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, RedirectAttributes reAttr,
			@RequestParam(name="files", required = false) MultipartFile[] files) {
		log.info("modify >>> " + bvo.toString());
		// user 비교 : 안 해도 상관은 없음
		UserVO user = userDao.getUser(bvo.getWriter());
		
		List<FileVO> fList = null; // 파일에 리스트를 담을 객체 준비
		if(files[0].getSize() > 0) { // files 에 데이터가 담겨 있음 (파일의 값이 있음)
			fList = fhd.uploadFiles(files); // FileHandler야 리스트 줘~
		} else {
			log.info("empty file");
			fList = new ArrayList<FileVO>();
		}
		int isUp = bsv.modifyFile(new BoardDTO(bvo, fList), user);
		
//		int isUp = bsv.modify(bvo, user);
		log.info(">>> modify : " + (isUp > 0 ? "Ok" : "Fail"));
		reAttr.addFlashAttribute(isUp > 0 ? "1" : "0");
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(RedirectAttributes reAttr, @RequestParam("bno") int bno, HttpServletRequest req) { // RedirectAttributes 없어도 됨
		HttpSession ses = req.getSession();
		UserVO user = (UserVO)ses.getAttribute("ses");
		int isOk = bsv.remove(bno, user);
		log.info(">>> remove : " + (isOk > 0 ? "Ok" : "fail"));
		return "redirect:/board/list";
	}
	
	// 첨부파일 삭제
	@DeleteMapping(value = "/file/{uuid}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("uuid") String uuid){
		log.info(">>> comment File delete uuid : " + uuid);
		int isUp = bsv.removeFile(uuid);
		return isUp > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	
	
	

}
