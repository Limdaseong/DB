	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.koreait.pjt.vo.BoardVO" %>
<%@ page import="com.koreait.pjt.db.BoardDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%
	List<BoardVO> list = (List)request.getAttribute("data"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<div>${loginUser.nm }님 환영합니다!</div>
	<div>
		<a href="regmod">글쓰기</a>
	</div> <!-- 앞에 /를 안붙이면 마지막에 있는 주소로 들어감 첨부터 주소를 고치고 싶다면 /를 붙여야함 -->
	<h1>리스트</h1>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach items="${data}" var="item">
			<tr>
				<td>${item.i_board }</td>
				<td>${item.title }</td>
				<td>${item.ctnt }</td>
				<td>${item.r_dt }</td>
				<td>${item.hits }</td>					
			</tr>
		</c:forEach>		
	</table>
</body>
</html>