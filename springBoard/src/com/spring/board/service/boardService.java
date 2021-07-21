package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	//게시판 상세보기
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	//게시판 총갯수
	public int selectBoardCnt() throws Exception;

	//게시판 작성
	public int boardInsert(BoardVo boardVo) throws Exception;
	
	//수정
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	//삭제
	public int boardDelete(BoardVo boardVo) throws Exception;
	
	//check
	public List<ComCodeVo> codeNameList() throws Exception;



}
