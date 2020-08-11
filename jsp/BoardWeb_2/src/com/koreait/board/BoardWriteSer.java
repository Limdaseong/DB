package com.koreait.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.db.DbCon;
import com.koreait.board.vo.BoardVO;

@WebServlet("/boardWrite")
public class BoardWriteSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsp = "/WEB-INF/view/boardRegMod.jsp";
		request.getRequestDispatcher(jsp).forward(request, response); //redirect는 무적권 get방식이다
	} // jsp파일은 dispatcher로 연다

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_student = request.getParameter("i_student"); // HTML에서는 정수형이란것은 없다
		
		System.out.println("title : " + title);
		System.out.println("ctnt : " + ctnt);
		System.out.println("i_student : " + strI_student);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_student(Utils.parseStrToInt(strI_student));
		
		int result = BoardDAO.insBoard(param);
		System.out.println("result : " + result);

		if(result == 1) {
			response.sendRedirect("/boardList");
		} else {
			request.setAttribute("msg", "에러가 발생하였습니다.");
			doGet(request, response);
		}
		
	} 

}
