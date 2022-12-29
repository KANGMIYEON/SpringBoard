package com.ezen.myProject.service;

import java.util.List;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.FileVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;

public interface BoardService {

	int register(BoardVO bvo);

	List<BoardVO> getList();

	BoardVO getDetail(int bno);

	int modify(BoardVO bvo, UserVO user);

	int remove(int bno, UserVO user);

	List<BoardVO> getList(PagingVO pvo);

	int getPageCnt();

	int getPageCnt(PagingVO pvo);

	int registerFile(BoardDTO boardDTO);

	BoardDTO getDetailFile(int bno);

	int modifyFile(BoardDTO boardDTO, UserVO user);

	int removeFile(String uuid);

	FileVO getFile(String uuid);

}
