
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

#page {
	text-decoration:none;
	color:blue;
}
#pageSelected {
	text-decoration:none;
	color:red;
}
#page:hover {
	color:green;
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
	
	<div>
		${param.page == null ? 1 : param.page}
		<form action="/list" id="selFrm" method="get">
		<input type="hidden" name="page" 
		value="${param.page == null ? 1 : param.page }">
			레코드 수 : 
			<select name="record_cnt" onchange="changeRecordCnt()">
				<c:forEach begin="10" end="30" step="10" var="item">
					<c:choose>
						<c:when test="${param.record_cnt == item || (param.record_cnt == null && item == 10)}">
							<option value="${item}" selected>${item}개</option>
						</c:when>
						<c:otherwise>
							<option value="${item}">${item}개</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</form>
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
	<div class="fontCenter">
	<c:forEach var="item" begin="1" end="${pagingCnt}" >
			<%-- <span><a href="/list?page=${item}" id="page">${item}</a></span>--%>
			<%-- <button onclick="moveToList(${item})">${item }</button> --%>
			<c:choose>
					<c:when test="${param.page == item}">
						<a href="/list?page=${item}" id="pageSelected">${item}</a>
					</c:when>
					<c:otherwise>
						<a href="/list?page=${item}" id="page">${item}</a>
					</c:otherwise>
				</c:choose>
	</c:forEach>
	</div>
	<script>
		function moveToDetail(i_board) {
			location.href = '/board/detail?i_board='+i_board //?뒤에부터는 쿼리스트링이라고 한다
		}
		
		function changeRecordCnt() {
			selFrm.submit()
		}
	</script>
</body>
</html>