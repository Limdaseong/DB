<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	* {margin : 0px; padding : 0px;}
	h3 { color : red; margin-top : 40px;}
	#container { margin: 0 auto; padding: 50px; width: 100%; height: 100vh; background : #3e3e3e; text-align: center;}
	#container h1 { color: #dedede; padding-bottom: 50px;}
	#container form { width: 900px; height: 900px; margin: 0 auto; text-align: center; padding-top: 50px;}
	form input { width: 500px; height: 40px; border-radius: 10px; margin-top : 15px;}
	#btn { width: 200px; "background: #2e2e2e; color : #dedede;}
	input:hover { background: #dedede;}
</style>
</head>
<body>
	<div id="container">
		<div>
			<h1>회원가입</h1>
			<hr>
			<form id="frm" action="join" method="post" onsubmit="return chk()">
				<div><label><input type="text" name="user_id" placeholder="아이디" required value="${data.user_id}"></label></div>
				<div><label><input type="password" name="user_pw" placeholder="비밀번호" required></label></div>
				<div><label><input type="password" name="user_pwre" placeholder="비밀번호 확인" required></label></div>
				<div><input type="text" name="nm" placeholder="이름" required value="${data.nm}"></div>
				<div><input type="email" name="email" placeholder="이메일" value="${data.email}"></div>
				<div><input type="submit" id="btn" value="회원가입"></div>
				<h3 class="err">${msg}</h3>
			</form>
		</div>
	</div>
	<script>
		function chk() {
			//name이 키값임
			if(frm.user_id.value.length < 5) {
				alert('아이디는 5글자 이상이되어야 합니다')
				frm.user_id.focus()
				return false
			} else if(frm.user_pw.value.length < 5) {
				alert('비밀번호는 5글자 이상이 되어야 합니다.')
				frm.user_pw.focus()
				return false
			} else if(frm.user_pw.value != frm.user_pwre.value) {
				alert('비밀번호를 확인해 주세요')
				frm.user_pw.focus()
				return false
			} else if(frm.nm.value.length > 0) {
				const korean = /[^가-힣]/;
				//const result = korean.test(frm.nm.value)
				if(korean.test(frm.nm.value)) {
					alert('이름은 한글만 입력해 주세요')
					frm.nm.focus()
					return false
				}
			} // else if 문은 하나밖에 실행이 안되는데 근데 이름을 적는 else if에서 반드시 실행이 되기 때문에 이메일 칸은  실행이 안되고 넘어가서 따로 if문을 써줘야한다
			
			if(frm.email.value.length > 0) {
				const email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
					
				if(!email.test(frm.email.value)) {
					alert('이메일을 확인해 주세요')
					frm.email.focus()
					return false
				}
			}
			return true
		}
	</script>
</body>
</html>