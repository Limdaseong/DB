<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.container { width: 900px; margin 0 auto;}
</style>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="container">
	<h1>로그인</h1>
	<form action="/login" method="post" id="frm" onsubmit="return chk()">
		<div> <%-- 다시 바꿔주기 --%>
			<div><input type="text" name="user_id" placeholder="아이디" required value="ddddd" <%-- ${user_id} --%>></div>
			<div><input type="password" name="user_pw" placeholder="비밀번호" required value="ddddd"></div>
			<div><input type="submit" value="로그인"></div>
			<h3 class="err">${msg}</h3>
		</div>
	</form>
	<a href="/join">회원가입</a>
	</div>
	<script>
		function chk() {
			if(frm.user_id.value.length < 5) {
				alert('아이디를 5글자 이상 입력해 주세요.')
				frm.user_id.focus()
				return false
			} else if(frm.user_pw.value.length < 5) {
				alert('비밀번호를 5글자 이상 입력해 주세요.')
				frm.user_pw.focus()
				return false
			}
		}
	</script>
</body>
</html>