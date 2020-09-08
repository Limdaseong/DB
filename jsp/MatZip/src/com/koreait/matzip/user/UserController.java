package com.koreait.matzip.user;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.Const;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.UserVO;

public class UserController {
	
	private UserService service;
	
	public UserController() {
		service = new UserService();
	}
	
	//           /user/login
	public String login(HttpServletRequest request) { // request만 해줌
		String error = request.getParameter("error");
		
		if(error != null) {
			switch(error) {
			case "2":
				request.setAttribute("msg", "아이디를 확인해 주세요.");
				break;
			case "3":
				request.setAttribute("msg", "비밀번호를 확인해 주세요");
				break;
			}
		}
		
		request.setAttribute(Const.TITLE, "로그인");
		request.setAttribute(Const.VIEW, "user/login");
		return ViewRef.TEMP_DEFAULT;
		
		// 화면 열 때 필수!!
	}
	
	public String loginProc(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		String user_pw= request.getParameter("user_pw");
		
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(user_pw);
		
		int result = service.login(param);
		
		if(result == 1) {
			return "redirect:/rest/restMap";
		} else {
			return "redirect:/user/login?error=" + result;
		}
	}
	
	public String join(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "회원가입");
		request.setAttribute(Const.VIEW, "user/join");
		return ViewRef.TEMP_DEFAULT;
	}
	
	public String joinProc(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String nm = request.getParameter("nm");
		
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(user_pw);
		param.setNm(nm);
		
		service.join(param);
		
		return "redirect:/user/login";
	}
	
	public String ajaxIdChk(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw("");
		
		int result = service.login(param);
		
		return String.format("ajax:{\"result\": %s}", result);
	}
}
