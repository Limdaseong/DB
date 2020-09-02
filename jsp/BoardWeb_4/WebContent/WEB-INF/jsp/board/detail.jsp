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
	.containerPImg {
		display: inline-block;	
		width: 30px;
		height: 30px;
	    border-radius: 50%;
	    overflow: hidden;
	}
	
	.pImg {
	
		 object-fit: cover;
		  max-width:100%;
	}
	table {
	border: 1px solid black;
	}
	td, th {
	border: 1px solid black;
	}
</style>
<body>
	<div>
		<a href="/list?page=${param.page}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${param.searchType}">목록</a>
		<c:if test="${loginUser.i_user == data.i_user }">
			<a href="/regmod?i_board=${data.i_board }&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${param.searchType}">수정</a>
			<form id="delFrm" action="/board/del" method="post">
				<input type="hidden" name="i_board" value="${data.i_board }">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="searchText" value="${param.serachText}">
				<input type="hidden" name="searchType" value="${param.searchType}">
				<input type="hidden" name="record_cnt" value="${param.record_cnt}">
				<a href="#" onclick="submitDel()">삭제</a>
			</form>		
		</c:if>
	</div>
	
	<table>
		<tr>
			<td>제목</td>		<td id="elTitle">${data.title }</td>
			<td>작성일</td>	<td>${data.r_dt }</td>
			<td>작성자</td>
			<td colspan="2">
			${data.nm }
			<div class="containerPImg">
			<c:choose>
				<c:when test="${item.profile_img != null}">
					<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
				</c:when>
				<c:otherwise>
					<img class="pImg" src="/img/default_profile.jpg">
				</c:otherwise>
			</c:choose>
			</div>
			</td>
			<td>조회수</td>	<td>${data.hits }</td>
			<td>
				<div class="pointerCursor">
					<c:if test="${data.yn_like == 0 }">
						<span class="material-icons" onclick="toggleLike(${data.yn_like})">favorite_border</span>
					</c:if>
					<c:if test="${data.yn_like == 1 }">
						<span class="material-icons" style="color: red;"
							onclick="toggleLike(${data.yn_like})">favorite</span>
					</c:if>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="10" id="elCtnt">${data.ctnt }</td>
		</tr>
	</table>
	
	
	
	
	
	<%-- <div>제목: ${data.title }</div>
	<div>작성일시: ${data.r_dt }</div>
	<div>
		<div class="containerPImg">
			<c:choose>
				<c:when test="${item.profile_img != null}">
					<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
				</c:when>
				<c:otherwise>
					<img class="pImg" src="/img/default_profile.jpg">
				</c:otherwise>
			</c:choose>
		</div>
	</div>
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
	<div> ${data.ctnt }</div> --%>
	
	<div class="marginTop30">
		<form id="cmtFrm" action="/board/cmt" method="post">
			<input type="hidden" name="i_cmt" value="0">
			<input type="hidden" name="i_board" value="${data.i_board }">
			<div>
				<input type="text" name="cmt" placeholder="댓글내용">
				<input type="submit" id="cmtSubmit" value="전송">
				<input type="button" value="취소" onclick="cmtCancel()">
			</div>
		</form>
	</div>
	
	<div class="marginTop30">
		<table>
			<tr>
				<th>내용</th>
				<th> </th>
				<th>글쓴이</th>
				<th>등록일</th>
				<th>비고</th>
			</tr>
			<c:forEach items="${cmtList}" var="item">
				<tr>
					<td>${item.cmt }</td>
					<td>
						<div class="containerPImg">
								<c:choose>
									<c:when test="${item.profile_img != null}">
										<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
									</c:when>
									<c:otherwise>
										<img class="pImg" src="/img/default_profile.jpg">
									</c:otherwise>
								</c:choose>
							</div>
					</td>
					<td>${item.nm}</td>
					<td>${item.r_dt }</td>
					<td>
						<c:if test="${loginUser.i_user == item.i_user }">
						<button onclick="delcmt(${item.i_cmt})">삭제</button>
						<button onclick="modify(${item.i_cmt}, '${item.cmt }')">수정</button>
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
			if(confirm('삭제하시겠습니까?')){
			location.href="/board/cmt?i_board=${data.i_board}&i_cmt=" + i_cmt
			}
		}
		
		function modify(i_cmt, cmt) {
			console.log("i_cmt : " + i_cmt)
			cmtFrm.i_cmt.value = i_cmt // i_cmt가 들어가지고
			cmtFrm.cmt.value = cmt // cmt가 들어가지고
			cmtFrm.cmtSubmit.value = '수정'
		}
		
		function cmtCancel() {
			cmtFrm.i_cmt.value = 0 
		//	폼id.inputNAME.값 = 값
			cmtFrm.cmt.value = ''
			cmtFrm.cmtSubmit.value ='전송'
		}
		
		function doHighlight() {
			var searchText = '${param.searchText}'
			var searchType = '${param.searchType}'
			
			if(searchText == '') {
				return
			}
			
			switch(searchType) {
			case 'a':
				var txt = elTitle.innerText
				txt = txt.replace(new RegExp('${param.searchText}','gi'), '<span class="highlight">' + searchText + '</span>')
				elTilte.innerHTML = txt
				console.log('txt : ' + txt)
				break; 
			case 'b':
				var txt = elCtnt.innerText
				txt = txt.replace(new RegExp('${param.searchText}','gi'), '<span class="highlight">' + searchText + '</span>')
				elCtnt.innerHTML = txt
				break;
			case 'c':
				var txt = elTitle.innerText
				txt = txt.replace(new RegExp('${param.searchText}','gi'), '<span class="highlight">' + searchText + '</span>')
        		elTitle.innerHTML = txt
        		
        		txt = elCtnt.innerText
        		txt = txt.replace(new RegExp('${param.searchText}','gi'), '<span class="highlight">' + searchText + '</span>')
        		elCtnt.innerHTML = txt
				break;
			}
		}
		
		doHighlight()
	</script>
	
			
</body>
</html>