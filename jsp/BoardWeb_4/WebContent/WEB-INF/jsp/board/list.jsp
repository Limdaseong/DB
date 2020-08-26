
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.pjt.vo.BoardVO"%>
<%@ page import="com.koreait.pjt.db.BoardDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	
	List<BoardVO> list = (List) request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}
.row:hover {
	background-color: #b8e994;
	cursor: pointer;
}

.whenTd {
	color: red;
}
</style>
</head>
<body>
	<div>
		${loginUser.nm }님환영합니다!
		<a href="/logout">로그아웃</a>
	</div>
	<div>
		<a href="regmod">글쓰기</a>
	</div>
	<!-- 앞에 /를 안붙이면 마지막에 있는 주소로 들어감 첨부터 주소를 고치고 싶다면 /를 붙여야함 -->
	<h1>게시판 리스트</h1>

	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
			<th>조회수</th>
			<th>작성자</th>
			<th>등록일시</th>
		</tr>

		<!--
		 존재는 하지만 그 존재의미가 없다 null 대신 "" 이걸로 Test 
		<div>${data != "" ?  "등록글없음 ㅇㅇㅇㅇ" : "dd" }</div>
		-->

		<img src="Image\gunchim.jpg">

		<c:choose>
			<c:when test="${empty data }">
				<tr>
					<td colspan="5" style="color: red; align: center;">등록된 글이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${data}" var="item">
					<tr class="row" onclick="moveToDetail(${item.i_board})">
						<td>${item.i_board }</td>
						<td>${item.title }</td>
						<td>${item.hits }</td>
						<td>${item.i_user }</td>
						<td>${item.r_dt }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>



	</table>

	<script>
		function moveToDetail(i_board) {
			location.href = '/board/detail?i_board='+i_board //?뒤에부터는 쿼리스트링이라고 한다
		}
	</script>
</body>
</html>