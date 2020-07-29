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


String title = null;
String ctnt = null;
int i_student = 0;
		
%>

<%

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	
	
	String strI_board = request.getParameter("i_board");

	String sql = " SELECT * FROM t_board WHERE i_board = " + strI_board;

	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery(); // executeQuery는 ResultSet을 얻기 위한 메소드이다
		
		if(rs.next()) {
			title = rs.getNString("title");
			ctnt = rs.getNString("ctnt");
			i_student = rs.getInt("i_student");
			
		}
		out.println("login!!");
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error!");
	} finally {
		if(rs != null) { try {rs.close(); } catch(Exception e) {} }  // 한번에 다 묶어서 쓰면 한쪽에서 에러가 터지면 다른 것들이 안닫히고 catch문으로 넘어가기 때문에
		if(ps != null) { try {ps.close(); } catch(Exception e) {} }  // 다 따로 써야한다
		if(con != null) { try {con.close(); } catch(Exception e) {}	}  // 이것들을 안닫아주면 메모리 부족 현상으로 서버가 죽는다
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>상세 페이지 : <%=strI_board %></div>
	<%= title %>
	<%= ctnt %>
	<%= i_student %>
</body>
</html>