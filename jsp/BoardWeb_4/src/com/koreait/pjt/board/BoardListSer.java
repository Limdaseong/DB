package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;

@WebServlet("/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		if(null == hs.getAttribute(Const.LOGIN_USER)) { // 게시판에 들어왔을 때 
			// 로그인되지 않은 사람은 로그인 창으로 보냄
			response.sendRedirect("/login"); 
			return;
		}
		// 로그인된 사람은 리스트를 볼 수 있음
		request.setAttribute("data", BoardDAO.selBoardList());
		ViewResolver.forward("board/list", request, response);
	}
}
