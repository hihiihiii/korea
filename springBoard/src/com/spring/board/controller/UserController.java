package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.board.HomeController;
import com.spring.board.service.userService;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.LoginVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class UserController {
	
	@Autowired
	userService userService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//회원가입 get
	@RequestMapping(value="/user/userRegister.do", method=RequestMethod.GET) 
	public String userRegister(Locale locale,Model model)throws Exception{
		logger.info("get register");
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>(); 
		comCodeList = userService.codePhoneList();
		model.addAttribute("codeName", comCodeList);
		
		return "user/userRegister";
	}
	
	//회원가입 post
	@RequestMapping(value="/user/userRegisterAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String userRegisterAction(Locale locale,UserVo userVo)throws Exception{
		logger.info("post register");
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
	
		int resultCnt = userService.userRegister(userVo);
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		result.put("success", (resultCnt > 0) ? "Y" : "N");
		System.out.println("callbackMsg::" + callbackMsg);
		return callbackMsg;	
	}
	
	//아이디 중복체크
	@RequestMapping(value="/user/idCheck.do", method= RequestMethod.POST)
	@ResponseBody
	public int userIdCheck(UserVo userVo)throws Exception{
		
		int result = userService.idCheck(userVo);
		
		return result;
	}
	
	//로그인get
	@RequestMapping(value="/user/userLogin.do", method=RequestMethod.GET)
	public String userLogin(UserVo userVo) throws Exception{
		
		return "user/userLogin";
	}
	
	//로그인POST
	@RequestMapping(value="/user/userLoginAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String userLoginAction(HttpServletRequest req, RedirectAttributes rttr,Model model,LoginVo loginVo,UserVo user)throws Exception{

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		HttpSession session = req.getSession();
		int resultCnt = userService.userLoginCnt(user); 	
		UserVo userVo = userService.userLogin(loginVo);
		
		if(resultCnt == 0) {
			session.setAttribute("user",null);
		}else {
			session.setAttribute("user",userVo);
		}

		/*
		 * result.put("success", (userVo.getUserPw().matches(loginVo.getUserPw())) ? "Y"
		 * : "N");
		 */
		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);
		return callbackMsg;
	}
	
	//로그아웃
	@RequestMapping(value="/user/userLogout.do", method=RequestMethod.GET)
	public String userLogout(HttpSession session) throws Exception{
		session.invalidate();
		
		return "redirect:/board/boardList.do";
	}

}
