<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.BoardVO" %>

<%! 
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

	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	
	BoardVO vo = new BoardVO();
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	//String a = null;
	//String b = null;
	//int c = 0;
	
	// 연결할 때는 무조건 예외 처리 하기
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		rs = ps.executeQuery();
		if(rs.next()){
			//a = rs.getNString("title");
			//b = rs.getNString("ctnt");
			//c = rs.getInt("i_student");
			
			String title = rs.getNString("title"); 
			String ctnt = rs.getNString("ctnt");  
			int i_student = rs.getInt("i_student"); 
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally{
		if(rs != null) { try {rs.close(); } catch(Exception e) {} }
		if(ps != null) { try {ps.close(); } catch(Exception e) {} }
		if(con != null) { try {con.close(); } catch(Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
	<form id="frm" action="/jsp/board_ModProc.jsp" method="post" onsubmit="chk()">
		<input type="hidden" name="i_board" value="<%=strI_board %>">
		<div><label>제목: <input type="text" name="title" id="aa" class="bb jj oooo" value="<%=vo.getTitle() %>"></label></div> 
		<div><label>내용: <textarea name="ctnt"><%=vo.getCtnt() %></textarea></label></div>
		<div><label>작성자: <input type="text" name="i_student" value="<%=vo.getI_student()%>" readonly></label></div>
		<div><input type="submit" value="글수정"></div>
	</form>
	</div>
</body>
</html>