package com.spring.board.dao.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.UserDao;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{

	@Inject
	private SqlSession sqlSession;
	
	//회원가입
	@Override
	public int userRegister(UserVo userVo) {
		return sqlSession.insert("user.userRegister",userVo);
	}

	//중복체크
	@Override
	public int idCheck(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.idCheck",userVo);
	}
	
	//codeList
	@Override
	public List<ComCodeVo> codePhoneList() throws Exception {
		
		return sqlSession.selectList("user.codePhoneList");
	}
	
	//로그인
	@Override
	public UserVo userLogin(LoginVo loginVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.userLogin",loginVo);
	}

	//로그인 cnt
	@Override
	public int userLoginCnt(UserVo userVo) throws Exception {
		
		return sqlSession.selectOne("user.userLoginCnt",userVo);
	}
	
	

}
