package com.ezen.myProject.repository;

import java.util.List;

import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.PagingVO;

public interface BoardDAO {

	int insertBoard(BoardVO bvo);

	List<BoardVO> selectBoardList();

	BoardVO selectBoardOne(int bno);

	void readCount(int bno);

	int updateBoard(BoardVO bvo);

	int deleteBoard(int bno);

	List<BoardVO> selectBoardListPaging(PagingVO pvo);

	int selectCount();

	int searchCount(PagingVO pvo);

	int selectOneBno();

}
