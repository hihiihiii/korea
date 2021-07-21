package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	//total
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	//board view
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	//write
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	//update
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	//delete
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardDelete(boardVo);
		
	}

	//code List
	@Override
	public List<ComCodeVo> codeNameList() throws Exception {
		return boardDao.codeNameList();
	}


	
}
