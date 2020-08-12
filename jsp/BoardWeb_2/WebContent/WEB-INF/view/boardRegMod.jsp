<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null ? "글등록" : "글수정" }글등록</title>
<style>
	.err {
		color: #e74c3c;
	}
</style>
</head>
<body>
	<div>${data == null ? '글등록' : '글수정' }
	<!-- 제목 글쓰기 / a태그로 날라가면  get방식  --></div>
	<div class="err">${msg }</div>
	<form action="/${data == null ? 'boardWrite' : 'boardMod' }" method="post" onsubmit="return chk()">
		<input type="hidden" name="i_board" value="${data.i_board }">
		<div><label>제목: <input type="text" name="title" value="${data.title }"></label></div>
		<div><label>내용: <textarea name="ctnt">${data.ctnt }</textarea></label></div>
		<div><label>작성자: <input type="text" name="i_student" value="${data.i_student }" ${data == null ? "":'readonly'}></label></div>
		<div><input type="submit" value="${data == null ? '글등록' : '글수정' }"></div>
		<!-- name이 키값이다 -->
	</form>
	
	<script>
		function eleValid(ele, nm) {
			if(ele.value.length == 0) {
				alert(nm+'을(를) 입력해 주세요.')
				ele.focus()
				return true
			}
		}
		
		function chk() {
			if(eleValid(frm.title, '제목')) {
				return false
			} else if(eleValid(frm.ctnt, '내용')) {
				return false
			} else if(eleValid(frm.i_student, '작성자')) {
				return false
			}		
		}
	</script>
</body>
</html>