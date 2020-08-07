<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- pageContext.setAttribute("b", "ddd")  이렇게 페이지콘텍스에 적혀있다면 ${b} 이렇게 사용 가능--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div>상세페이지</div>
	<div>글번호 : ${data.i_board}</div>
	<div>제목 : ${data.title}</div>
	<div>내용 : ${data.ctnt}</div>
	<div>작성자 : ${data.i_student}</div>
</body>
</html>