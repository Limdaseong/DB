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

import com.koreait.board.db.DbCon;

@WebServlet("/boardWrite")
public class BoardWriteSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	} // jsp파일은 dispatcher로 연다

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_student = request.getParameter("i_student");

		if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
			response.sendRedirect("/jsp/board_Write.jsp?err=10");
			return;
		}
		
		int i_student = Integer.parseInt(strI_student);
		int result = -1;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		String sql = " INSERT INTO t_board (i_board, title, ctnt, i_student) "
				+ " SELECT nvl(max(i_board), 0)+1, ?, ?, ? "
				+ " FROM t_board ";
		
		try {
    		con = DbCon.getCon();
    		ps = con.prepareStatement(sql);
    		ps.setNString(1, title);
    		ps.setNString(2, ctnt);
    		ps.setInt(3, i_student);
    		result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}
		
		String jsp = "/WEB-INF/view/boardRegMod";
		request.getRequestDispatcher(jsp).forward(request, response);
		
	} 

}
