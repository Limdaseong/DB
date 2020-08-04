<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg = "";
	String err = request.getParameter("err");
	if(err != null) {
		switch(err) {
		case "10":
			msg = "등록할 수 없습니다";
			break;
		case "20":
			msg = "DB 에러 발생";
			break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
	/* .jj {background-color: #e74c3c}
		.bb {} */
	#msg {
		color: red;
	}
	
</style>
<!-- css는 아래에 쓰면 번쩍임 효과가 일어나서 밑에 쓰면 안됨 -->
</head>
<body>
	<div id="msg"><%=msg %></div>
	<div>
	<!-- on으로 시작하는 것은 이벤트이다 (뭐할 때) --> <!-- onclick은 어떤 태그든 쓸 수 있다 -->
	<form id="frm" action="/jsp/board_WriteProc.jsp" method="post" onsubmit="chk()"> <!-- 내용적으로 안길면 get방식 / 글 내용이 많거나 보안이 필요하다면 post방식 -->
	<!-- 폼태그를 통해서 이페이지에서 저페이지로 값을 전달하는데 값을 입력하는 방법과 값을 처리하는 방법을 따로 분리해서 소스를 적어야한다 안그르면 관리하기 힘들어지는 소스가 만들어진다 -->
	
		<div><label>제목: <input type="text" name="title" id="aa" class="bb jj oooo"></label></div> <!-- name만 키값이 된다 다른 것들은 안된다 -->
		<!-- id는 한 값에만 유일하게 주기위한 용도 (똑같은 곳에 주면 안됨) / class는 여러개한테 똑같은 그룹으로 의미를 줄 때 쓰는 용도 (한칸씩 뛰어 놓으면 따로따로 .(jj)이렇게 해도 된다) -->
		
		<div><label>내용: <textarea name="ctnt"></textarea></label></div>
		<div><label>작성자: <input type="text" name="i_student"></label></div>
		<div><input type="submit" value="글등록"></div>
	</form>
	</div>
	<script>
		function eleValid(ele, nm) {
			if(ele.value.length == 0) {
				alert(nm+'을(를) 입력해 주세요.')
				ele.focus()
				return true
			}
		}
	
		function chk() {
			//console.log(`title:\$(frm.title.value)`)
			if(eleValid(frm.title,'제목')) {
				return false
			} else if(eleValid(frm.ctnt, '내용')) {
				return false
			} else if(eleValid(frm.i_student, '작성자')) {
				return false
			}
		}
		// 요소들을 쓰기 위해서 바디 맨마지막에 쓴다 헤드에 쓸 경우는 선언할 때
		/* function chk() {
			console.log(`title:\$(frm.title.value)`) // jsp에서 사용하는 옐식이 있기 때문에 $앞에 \를 붙여야한다 그러나 자바스크립트에서 쓸때는 그냥 $
		  //console.log('title : ' + frm.title.value)

		    if(frm.title.value == '') {
		    	alert('제목을 입력해 주세요.')
		    	frm.title.focus()
		    	return false
		    } else if(frm.ctnt.value.length == 0) {
		    	alert('내용을 입력해 주세요.')
		    	frm.ctnt.focus()
		    	return false
		    } else if(frm.i_student.value.length === 0)
			return false
		} */
	</script>
</body>
</html>