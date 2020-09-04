package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/toggleLike")
public class BoardToggleSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		if(loginUser == null) {
			response.sendRedirect("/login");
		} 
		
		// 로그인 정보는 로그인하면서 세션에 들어가서 그 세션에 있는 정보로 i_user를 쓸 수 있다
		
		String strI_board = request.getParameter("i_board"); // ""안에 적은 값이 키값이다
		String strYn_like = request.getParameter("yn_like");
		
		int i_board = MyUtils.parseStrToInt(strI_board); // 파싱은 에러가 안터지게 하기 위해서 설정해 둔 것이다
		int yn_like = MyUtils.parseStrToInt(strYn_like, 3); // 
		
		BoardVO param = new BoardVO();
		
		param.setI_board(i_board);
		param.setI_user(loginUser.getI_user()); // 로그인한 사람의 i_user
		
		if(yn_like == 0) { // 좋아요 처리
			BoardDAO.insLike(param);
		} else if(yn_like == 1) { // 좋아요 취소 처리
			BoardDAO.delLike(param);
		}

		response.sendRedirect("/board/detail?i_board=" + i_board);
	}

}
