package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/detail")
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		
				
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		} //로그인 확인
		
		
		String strI_board = request.getParameter("i_board");
		int i_board = MyUtils.parseStrToInt(strI_board);
		
		ServletContext application = getServletContext();
		// 부모 서블릿에 상속을 받아서 getServletcontext를 쓸 수 있다
		// page context -> request -> session -> application (크기순 {작음 -> 큼)
		Integer readI_user = (Integer)application.getAttribute("read_" + strI_board);
		if(readI_user == null || readI_user != loginUser.getI_user()) {
			BoardDAO.addHits(i_board);
			application.setAttribute("read_"+strI_board, loginUser.getI_user());
		}
		//조회수 올려!

		BoardVO param = new BoardVO();
		param.setI_user(loginUser.getI_user());
		param.setI_board(i_board);
		request.setAttribute("data", BoardDAO.selBoard(param));
		
		request.setAttribute("cmtList", BoardCmtDAO.selCmtList(i_board));
		
		ViewResolver.forward("board/detail", request, response);
			
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
