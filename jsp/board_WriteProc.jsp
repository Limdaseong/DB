<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!	Connection getCon() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "koreait2020";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		Connection con = DriverManager.getConnection(url, username, password); // sql exception 일어남
		System.out.println("접속 성공!"); // static이 붙은 메소드이기 때문에 사용 가능 -> 파라미터만으로 들어오는 것만으로 작동이 가능하다
		return con;						// static이 붙은 것은 쓰기 정말 편하다 , 클래스명인지 아는 방법 첫번째 글자가 대문자이다
}
%>

<!-- select nvl(max(i_board),0) + 1 from t_board -->

<%
	request.setCharacterEncoding("UTF-8");
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
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3, i_student);
		result = ps.executeUpdate();
		out.print("게시글 올림성공!!");
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(con != null) { try {con.close(); } catch(Exception e) {} }
		if(ps != null) { try {ps.close(); } catch(Exception e) {} }
	}
	
	int err = 0; // 사이트에 최초
	switch(result) {
	case 1:
		response.sendRedirect("/jsp/board_List.jsp");
		return;
		
	case 0:
		err = 10; // 실행은 전부 제대로 됐는데 바뀐 것이 없을 때
		break;
		 
	case -1:
		err = 20; // 실행에서부터 에러가 떴을 때
		break;
	}
	response.sendRedirect("/jsp/board_Write.jsp?err="+err);
%>

<!--  -->
