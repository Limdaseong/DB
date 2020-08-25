<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null ? '등록' : '수정' }</title>
<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
</head>
<body>
	<div>
		<form id="frm" action="regmod" method="post">
			<input type="hidden" name="i_board" value="${data.i_board }">
			<div>제목: <input type="text" name="title" required value="${data.title }"></div>
			<div>내용: <textarea name="ctnt" required>${data.ctnt }</textarea></div>
			<div><input type="submit" value="${data == null ? '등록' : '수정' }"></div>
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