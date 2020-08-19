<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록/수정</title>
</head>
<body>

	<div>
		<form id="frm" action="regmod" method="post">
			<div>제목: <input type="text" name="title" ></div>
			<div>내용: <textarea name="ctnt"></textarea></div>
			<%--<input type="hidden" name="i_user" value="${loginUser.i_user }"> --%>
			<div><input type="submit" value="등록"></div>
		</form>
	</div>
	<h3>${msg }</h3>
	<script>
	function chk() {
		if(frm.title.value.length > 100) {
			alert('제목을 100자 이상 입력해 주세요.')
			frm.title.focus()
			return false
		} else if(frm.ctnt.value.length > 2000) {
			alert('내용을 2000자 이상 입력해 주세요.')
			frm.title.focus()
			return false
		}
	}
	</script>
</body>
</html>