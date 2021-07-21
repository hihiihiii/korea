package com.spring.board.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.board.dao.UserDao;
import com.spring.board.service.userService;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.UserVo;

@Service
public class userServiceImpl implements userService{
	
	@Inject
	private UserDao dao;

	//회원가입
	@Override
	public int userRegister(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		
		return dao.userRegister(userVo);
		
	}
	//중복체크
	@Override
	public int idCheck(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return dao.idCheck(userVo);
	}

	//codeList
	@Override
	public List<ComCodeVo> codePhoneList() throws Exception {
		// TODO Auto-generated method stub
		return dao.codePhoneList();
	}

	//로그인
	@Override
	public UserVo userLogin(LoginVo loginVo) throws Exception {
		// TODO Auto-generated method stub
		return dao.userLogin(loginVo);
	}
	
	@Override
	public int userLoginCnt(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return dao.userLoginCnt(userVo);
	}
	
	
	

}
