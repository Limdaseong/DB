<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.BoardVO" %>

<%!//메소드 안에서 클래스를 만들 수 없으니까 
	Connection getCon() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "koreait2020";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		Connection con = DriverManager.getConnection(url, username, password); // sql exception 일어남
		System.out.println("접속 성공!"); // static이 붙은 메소드이기 때문에 사용 가능 -> 파라미터만으로 들어오는 것만으로 작동이 가능하다
		return con;						// static이 붙은 것은 쓰기 정말 편하다 , 클래스명인지 아는 방법 첫번째 글자가 대문자이다
}
%>


<% 
    String strI_board = request.getParameter("i_board");
	int i_board = Integer.parseInt(strI_board);
	
	String sql = " Delete from t_board where i_board = ? ";
	
	Connection con = null;
	PreparedStatement ps = null;
	int result = -1;
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		result = ps.executeUpdate();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(con != null) { try {con.close(); } catch(Exception e) {} }  // 한번에 다 묶어서 쓰면 한쪽에서 에러가 터지면 다른 것들이 안닫히고 catch문으로 넘어가기 때문에
		if(ps != null) { try {ps.close(); } catch(Exception e) {} }  // 다 따로 써야한다	}
	}
	
	System.out.println("result : " + result);
	switch(result) {
	case -1:
		response.sendRedirect("/jsp/board_Detail.jsp?err=-1&i_board="+ i_board);
		break;
	case 0:
		response.sendRedirect("/jsp/board_Detail.jsp?err=0&i_board="+ i_board);
		break;
	case 1:
		response.sendRedirect("/jsp/board_List.jsp");
		break;
	}
	// 자동세팅이 오토커밋이다
	
%>