package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.UserVo;

public interface userService {

	//회원가입
	public int userRegister(UserVo userVo)throws Exception;
	
	//중복체크
	public int idCheck(UserVo userVo)throws Exception;
	
	//codeList
	public List<ComCodeVo> codePhoneList() throws Exception;
	
	//로그인
	public UserVo userLogin(LoginVo loginVo) throws Exception;
	
	public int userLoginCnt(UserVo userVo) throws Exception;

	
	
}
