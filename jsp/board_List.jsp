<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- @는 세팅임 -->
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.koreait.web.BoardVO" %>
<% //! //느낌표 있으면 메소드 바깥에 구현이 된거임 없으면 메소드 안에서 구현
	//int a = 10; 이 변수는 지역변수이다 
	
	/* int sum(int a, int b) {
		return a + b;
	}*/
	
	
%>
<!-- 이 부분을 스크립트 미션이라고 함 
	 %!는 메소드 밖에서 쓸 때이고 전역변수 취급
	 % 는 메소드 안에서 쓰는 것이다
-->

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
	//jsp는 응답이다 (화면을 보여주기 위함)%>



<%
	List<BoardVO> boardList = new ArrayList();	

	Connection con = null; // 데이터베이스 연결 담당!
	PreparedStatement ps = null; // (쿼리문 문장 완성 / 상세페이지 만들 때 사용) + 실행 = 쿼리문 실행 담당!
	ResultSet rs = null; // select문의 결과를 담을 담당(select일때만) 항상 있어야함!!
	//null로 선언하는 이유 : try에서도 쓰고 싶고 finally에서도 쓰고 싶어서
	
	
	String sql = " SELECT i_board, title FROM t_board ORDER BY i_board ASC "; // 컬럼명은 소문자로 명령어는 대문자로 보기 편하게 쓰기

	try {
		con = getCon();
		ps = con.prepareStatement(sql); // 스태틱 메소드일 확률이 너무 낮아서 prepareStatement는 스태틱이 아님 / sql부분을 호출하는 칭호는 " 인자 "이다
										// sql exception 일어남
		rs = ps.executeQuery();
		
		//exception처리를 잘해야 고수가 된다!!
		
		// while문 조건의 결과값은 boolean(true / false)
		// rs.next()는 다음 줄로 넘어가서 레코드가 있으면 true / 없으면 false
		while(rs.next()) {
			int i_board = rs.getInt("i_board"); // i_board 컬럼에 들어있는 값이 int로 리턴되고 i_board로 들어감
			String title = rs.getNString("title"); // title 컬럼에 들어있는 값이 String으로 리턴되고 title로 들어감
						   // getString과 비교했을 때 getNString 쓰는 것을 강추!!(오류가 잘안남)
			
			BoardVO vo = new BoardVO(); // 항상 while문 안에서 써야함 안그러면 다 같은 주소값으로 배출시켜서 다 똑같은 값이 나오게 됨
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);
		}
		
		// 국비 끝나고 4대보험이 들어간 날짜로부터 1년은 꼭 있어야 한다
		
	} catch(Exception e) {
		e.printStackTrace();
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
	<div>
	게시판 리스트
	<a href="/jsp/board_Write.jsp"><button>글쓰기</button></a> <!-- 화면 띄우는 용도(post방식으로?) -->
	</div>
	<table>
		<tr>
			<th>NO</th>
			<th>제목</th>
		</tr>
		<% for(BoardVO vo : boardList) { %>
		<tr>
			<td><%=vo.getI_board() %></td>
			<td>
				<a href="/jsp/board_Detail.jsp?i_board=<%= vo.getI_board()%>"> 
				<!-- ?(키값)=(value값) / &는 키값과 value값을 더 보내고 싶을 때 쓴다 (연결자) -->
					<%=vo.getTitle() %> <!-- 포스트 방식(보안면에서 좋다), 겟 방식(캐싱때문에 빠르다) -->
				</a>
			</td>
		</tr>
		<% } %> <!-- for문은 리스트가 있는 만큼 찍어낼 것이다 -->
	</table>
</body>
</html>