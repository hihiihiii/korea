package com.spring.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	//리스트목록
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	//상세보기
	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	//게시글 총갯수
	public int selectBoardCnt() throws Exception;

	//게시글 등록
	public int boardInsert(BoardVo boardVo) throws Exception;
	
	//수정
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	//삭제
	public int boardDelete(BoardVo boardVo) throws Exception;
	
	//게시물 조회
	public List<ComCodeVo> codeNameList() throws Exception; 
	
	

}
