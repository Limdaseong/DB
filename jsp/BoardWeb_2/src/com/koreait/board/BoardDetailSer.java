package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;

@WebServlet("/boardDetail") // 연결되는 주소값
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		
		int i_board = Utils.parseStrToInt(strI_board);
		if(i_board == 0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVO param = new BoardVO();		
		param.setI_board(i_board);
		
		BoardVO data = BoardDAO.selBoard(param); // DB로 값 받기 , param으로 받으면 나중에 수정할 때 수정하기 편하다
		request.setAttribute("data", data);
		
		String jsp = "/WEB-INF/view/boardDetail.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
//		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardDetail.jsp");
//		rd.forward(request, response);
	} // 주로 화면 띄우기에 씀

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
