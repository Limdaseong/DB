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
		<div class="container">
		<form id="frm" action="regmod" method="post">
			<div><input type="hidden" name="i_board" value="${data.i_board }"></div>
			<div><input id="title" type="text" name="title" placeholder="제목을 입력하세요" value="${data.title }"></div>
			<div><textarea name="ctnt" placeholder="내용을 입력하세요">${data.ctnt }</textarea></div>
			<div><button type="submit">${data.i_board == null ? '글등록' : '글수정'}</button></div>
		</form>
	</div>
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