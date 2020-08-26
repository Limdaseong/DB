<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
rel="stylesheet">
</head>
<style>
	.pointerCursor {
		cursor: pointer;
	}
	.marginTop30 {
		margin-top:30;
	}
</style>
<body>
	<div>
		<a href="/list">리스트</a>
		<c:if test="${loginUser.i_user == data.i_user }">
			<button type="submit">
			<a href="/regmod?i_board=${data.i_board }">수정</a>
			</button>
			<form id="delFrm" action="/board/del" method="post">
				<input type="hidden" name="i_board" value="${data.i_board }">
				<button type="submit"><a href="#" onclick="submitDel()">삭제</a></button>
			</form>		
		</c:if>
	</div>
	<div>제목: ${data.title }</div>
	<div>작성일시: ${data.r_dt }</div>
	<div>작성자: ${data.nm }</div>
	<div>조회수: ${data.hits }</div>
	<div class="pointerCursor">
	<c:if test="${data.yn_like == 0 }">
			<span class="material-icons" 
			onclick="toggleLike(${data.yn_like})">favorite_border</span>
	</c:if>
	<c:if test="${data.yn_like == 1 }">
			<span class="material-icons" style="color:red;" 
			onclick="toggleLike(${data.yn_like})">favorite</span> 
	</c:if>
	</div>
	<hr>
	<div> ${data.ctnt }</div>
	
	<div class="marginTop30">
		<form id="cmtFrm" action="/board/cmt" method="post">
			<input type="hidden" name="i_cmt" value="0">
			<input type="hidden" name="i_board" value="${data.i_board }">
			<div>
				<input type="text" name="cmt" placeholder="댓글내용">
				<input type="submit" value="전송">
			</div>
		</form>
	</div>
	
	<div class="marginTop30">
		<table>
			<tr>
				<th>내용</th>
				<th>글쓴이</th>
				<th>등록일</th>
				<th>비고</th>
			</tr>
			<c:forEach items="${cmtList}" var="item">
				<tr>
					<td>${item.cmt }</td>
					<td>${item.nm}</td>
					<td>${item.r_dt }</td>
					<td>
						<c:if test="${loginUser.i_user == item.i_user }">
							<!-- <a href="/regmod?i_board=${data.i_board }">수정</a>
							<form id="delFrm" action="/board/del" method="post">
								<input type="hidden" name="i_board" value="${data.i_board }">
								<a href="#" onclick="submitDel()">삭제</a>
							</form> -->
							<form id="regfrm" action="/board/cmt" method="post">
								<button onclick>수정</button>
							</form>
							<button onclick="delcmt(${item.i_cmt})">삭제</button>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<script>
		function submitDel() {
			if(confirm('삭제?')){
				delFrm.submit()
			}
		}
		
		function toggleLike(yn_like) {
			location.href="/board/toggleLike?i_board=${data.i_board}&yn_like="+ yn_like  // 쿼리스트링에서 =을 기준으로 왼쪽은 키값이고 오른쪽은 value값이다
		}
		
		function delcmt(i_cmt) {
			location.href="/board/cmt?i_board=${data.i_board}&i_cmt=" + i_cmt
		}
	</script>
	
			
</body>
</html>