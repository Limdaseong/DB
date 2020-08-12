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
	<div>
		<button onclick="doDel(${data.i_board})">삭제</button>
		<a href="/boardMod?i_board=${data.i_board}"><button>수정</button></a> 
		<!-- 수정, 삭제, 삽입은 pk값을 필요로 한다 -->
	</div>
	<div>상세페이지</div>
	<div>글번호 : ${data.i_board}</div>
	<div>제목 : ${data.title}</div>
	<div>내용 : ${data.ctnt}</div>
	<div>작성자 : ${data.i_student}</div>
	
	<script>
		function doDel(i_board) {
			if(confirm('삭제하시겠습니까?')) {
				location.href='/boardDelete?i_board=' + i_board
			}
		}
		
		// 선택 눌렀을 때 함수 호출해야하고 i_board값도 잘 보내야함 주소값을 대응할 수 있는 서블릿을 만들어야한다 
		// 그리고 보드리스트로 가는 것까지 
	</script>
</body>
</html>