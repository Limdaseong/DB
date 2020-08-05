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
	String strI_board = request.getParameter("i_board");  // 레코드를 대표하는 값 
	// pk는 구분할 수 있기 때문에 사용한다
	// 항상 패키지명은 소문자이고 클래스명은 대문자로 시작한다

	if(strI_board == null) {
%>

		<script>
			alert('잘 못 된 접근입니다.')
			location.href='/jsp/board_List.jsp'
		</script>

<% 
		return ;
	}

	int i_board = Integer.parseInt(strI_board);
	
	BoardVO vo = new BoardVO();
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null; // 자료를 가져오고 싶다면 resultset이 무조건 필요하다
		
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	// +연산자로 값을 주입하는 것은 가독성이 떨어진다
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1,i_board); // 1은 첫번째 ?이고 ,뒤에 있는 것은 그 순서에 있는 ?에 들어갈 값이다
		//ps.setString(1, strI_board);
		rs = ps.executeQuery(); // executeQuery는 ResultSet을 얻기 위한 메소드이다
								// 다 쓰고 나서 마지막에 실행
		
		if(rs.next()) { // 바로 해줄 수 있는데 if안에 넣는 이유 : 0인 경우에 대비하기 위해서
						// if랑 while이 헷갈린다면 while을 넣자
			String title = rs.getNString("title"); // 컬럼 명을 불러오기 때문에 순서는 상관없다
			String ctnt = rs.getNString("ctnt"); // 레퍼런스 변수에 
			int i_student = rs.getInt("i_student"); // 숫자로 바꿀 수 없는 문자열을 적을 경우 예외 에러가 발생한다
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
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

<%--
	Q&A
	Q1. 연결하엿는데 왜 또 연결하나?
	A1 : 
	Q2. title 
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<a href="/jsp/board_List.jsp">리스트로 가기</a>
		<a href="#" onclick="procDel(<%=i_board%>)">삭제</a>
		<a href="/jsp/boardMod.jsp?i_board=<%=i_board%>">수정</a>
	</div>-
	<div>제목 : <%=vo.getTitle() %></div>
	<div>내용 : <%=vo.getCtnt() %></div>
	<div>작성자 : <%=vo.getI_student() %></div>
	
	<script>
		function procDel(i_board) {
			//alert('i_board : '+ i_board') // enter로 구분을 해놨다면 ;를 안써도 된다
			if(confirm('삭제 하시겠습니까?')) { //confirm의 리턴 타입은 boolean(ture / false)
				location.href = '/jsp/board_Del.jsp?i_board=' + i_board
				// 삭제할 때는 executeUpdate를 쓰자
			}
		}

	</script>
</body>
</html>