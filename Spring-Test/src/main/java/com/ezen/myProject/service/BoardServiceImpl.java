package com.ezen.myProject.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.FileVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.repository.BoardDAO;
import com.ezen.myProject.repository.FileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;

	@Override
	public int register(BoardVO bvo) {
		log.info(">>> board register check2");
		return bdao.insertBoard(bvo);
	}

	@Override
	public List<BoardVO> getList() {
		log.info(">>> board list check2");
		return bdao.selectBoardList();
	}

	@Override
	public BoardVO getDetail(int bno) {
		log.info(">>> board detail check2");
		bdao.readCount(bno);
		return bdao.selectBoardOne(bno);
	}

	@Override
	public int modify(BoardVO bvo, UserVO user) {
		log.info(">>> board modify check2");
		// 작성자 일치 여부 : 안 해도 되는 작업
		BoardVO tmpBoard = bdao.selectBoardOne(bvo.getBno());
		if(user == null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		return bdao.updateBoard(bvo);
	}

	@Override
	public int remove(int bno, UserVO user) {
		log.info(">>> board remove check2");
		BoardVO tmpBoard = bdao.selectBoardOne(bno);
		if(user == null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		return bdao.deleteBoard(bno);
	}

	@Override
	public List<BoardVO> getList(PagingVO pvo) {
		log.info(">>> board Paging List check2");
		return bdao.selectBoardListPaging(pvo);
	}

	@Override
	public int getPageCnt() {
		log.info(">>> board pageCnt check2");
		return bdao.selectCount();
	}

	@Override
	public int getPageCnt(PagingVO pvo) {
		return bdao.searchCount(pvo);
	}

	@Override
	public int registerFile(BoardDTO bdto) {
		// DB 나눠서 보내야 함
		int isOk = bdao.insertBoard(bdto.getBvo()); // 기존 게시글에 대한 내용을 DB에 저장 (BoardDAO)
		log.info(bdto.getFList().toString());
		if(isOk > 0 && bdto.getFList().size() > 0){ // FileDAO
			// 방금 넣은 bvo 객체가 DB에 저장 된 후 (insertBoard)
			int bno = bdao.selectOneBno(); // 가장 큰 bno 요청 (마지막 bno 가져오면 되니까)
			for(FileVO fvo : bdto.getFList()) {
				fvo.setBno(bno); // 방금 추가 된 bno를 파일에 set
				log.info(">>> insert file : " + fvo.toString());
				isOk *= fdao.insertFile(fvo);
			}
			
		}
		return isOk;
	}

	@Override
	public BoardDTO getDetailFile(int bno) {
		bdao.readCount(bno); // detail 선택시 조회수 올리기
		BoardDTO bdto = new BoardDTO(bdao.selectBoardOne(bno), fdao.selectFileList(bno));
		return bdto;
	}

	@Override
	public int modifyFile(BoardDTO boardDTO, UserVO user) {
		log.info(">>> board modify check2");
		// 작성자 일치 여부 (글쓴이, id 비교)
		BoardVO tmpBoard = bdao.selectBoardOne(boardDTO.getBvo().getBno());
		if(user == null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		// 수정
		int isUp = bdao.updateBoard(boardDTO.getBvo()); // bvo 내용 update
		if(isUp > 0 && boardDTO.getFList().size() > 0) {
			int bno = boardDTO.getBvo().getBno();
			for(FileVO fvo : boardDTO.getFList()) {
				fvo.setBno(bno);
				isUp *= fdao.insertFile(fvo); // 추가한 파일을 추가 (삭제 기능은 X 별도로 만들 예정)
			}
		}
		return isUp;
	}

	@Override
	public int removeFile(String uuid) {
		return fdao.deleteFile(uuid);
	} 

}
