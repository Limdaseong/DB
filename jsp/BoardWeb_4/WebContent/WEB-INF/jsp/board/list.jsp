
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.pjt.vo.BoardVO"%>
<%@ page import="com.koreait.pjt.db.BoardDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	
	List<BoardVO> list = (List) request.getAttribute("data");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
rel="stylesheet">
<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}
.row:hover {
	background-color: #b8e994;
	cursor: pointer;
}

.whenTd {
	color: red;
}

#page {
	text-decoration:none;
	color:blue;
}
#pageSelected {
	text-decoration:none;
	color:red;
}
#page:hover {
	color:green;
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
.highlight {
		color: red;
		font-weight: bold;
	}
	
	#likeListContainer {	
		display: none;		
		padding: 10px;		
		border: 1px solid #bdc3c7;
		position: absolute;
		left: 0px;
		top: 30px;
		width: 130px;
		height: 200px;
		overflow-y: auto;
		background-color: white !important;
	}	
		
	.profile {
		background-color: white !important;
		display: inline-block;	
		width: 25px;
		height: 25px;
	    border-radius: 50%;
	    overflow: hidden;
	}		
	
	.likeItemContainer {
		display: flex;
		width: 100%;
	}
	
	.likeItemContainer .nm {
		background-color: white !important;
		margin-left: 7px;
		font-size: 0.7em;
		display: flex;
		align-items: center;
	}

</style>
</head>
<body>
	<div>
		${loginUser.nm }님환영합니다!
		<a href="/profile">프로필</a>
		<a href="/logout">로그아웃</a>
	</div>
	<div>
		<a href="regmod">글쓰기</a>
	</div>
	
	
	<%-- 상단 콤보박스(레코드 수 : ) --%>
	<div>
		<form action="/list" id="selFrm" method="get">
		<input type="hidden" name="page" value="${page}">
		<input type="hidden" name="searchText" value="${param.searchText}">
			레코드 수 : 
			<select name="record_cnt" onchange="changeRecordCnt()">
				<c:forEach begin="10" end="30" step="10" var="item">
					<c:choose>
						<c:when
						test="${param.record_cnt == item}">
							<option value="${item}" selected>${item}개</option>
						</c:when>
						<c:otherwise>
							<option value="${item}">${item}개</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</form>
	</div>
	<!-- 앞에 /를 안붙이면 마지막에 있는 주소로 들어감 첨부터 주소를 고치고 싶다면 /를 붙여야함 -->
	<h1>게시판 리스트</h1>

	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
			<th>조회수</th>
			<th>좋아요</th>
			<td> </td> 
			<th> </th>
			<th>작성자</th>
			<th>등록일시</th>
		</tr>

		<!--
		 존재는 하지만 그 존재의미가 없다 null 대신 "" 이걸로 Test 
		<div>${data != "" ?  "등록글없음 ㅇㅇㅇㅇ" : "dd" }</div>
		-->


		<%-- 게시글 나타내는 곳 --%>
		<c:choose>
			<c:when test="${empty data }">
				<tr>
					<td colspan="6" style="color: red; align: center;">등록된 글이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${data}" var="item">
					<tr class="row" >
						<td >${item.i_board }</td>
						<td onclick="moveToDetail(${item.i_board})">${item.title }		<span style="font-size: small;">[${item.cmt_cnt}]</span></td>
						<td>${item.hits }</td>
						<!--  -->
						<td><span onclick="getLikeList(${item.i_board}, ${item.like_cnt},this)">${item.like_cnt}</span></td>
						<td>
							<div class="pointerCursor">
									<c:if test="${item.yn_like == 0 }">
										<span class="material-icons")>favorite_border</span>
									</c:if>
									<c:if test="${item.yn_like == 1 }">
										<span class="material-icons" style="color: red;">favorite</span>
									</c:if>
							</div>
						</td>
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
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>

	</table>
	
	<%-- 페이지수 나타내는 곳 --%>
	<div class="fontCenter">
	<c:forEach var="item" begin="1" end="${pagingCnt}" >
			<%-- <span><a href="/list?page=${item}" id="page">${item}</a></span>--%>
			<%-- <button onclick="moveToList(${item})">${item }</button> --%>
			<c:choose>
					<c:when test="${page == item}">
						<a href="/list?page=${item}&item=" id="pageSelected">${item}</a>
					</c:when>
					<c:otherwise>
						<a href="/list?page=${item}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${searchType}" id="page">${item}</a>
					</c:otherwise>
				</c:choose>
	</c:forEach>
	
	<div id="likeListContainer">
	</div>
	
	<%-- 검색 --%>
	<div>
		<form action="/list">
			<select name="searchType">
				<option value="a" ${searchType == 'a' ? 'selected' : ' ' }>제목</option>
				<option value="b" ${searchType == 'b' ? 'selected' : ' ' }>내용</option>
				<option value="c" ${searchType == 'c' ? 'selected' : ' ' }>제목+내용</option>
			</select>
			<input type="search" name="searchText" value="${param.searchText }">
			<input type="hidden" name="record_cnt" value="${param.record_cnt}">
			<input type="submit" value="검색">
		</form>
	</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>
	
	let beforeI_board = 0
	function getLikeList(i_board, cnt, span) {
		console.log("i_board : " + i_board)
		if(cnt == 0) { return }
		
		if(beforeI_board == i_board) {
			likeListContainer.style.display = 'none'
			return
		} else{
			beforeI_board = i_board
			likeListContainer.style.display = 'unset'
		}			
		
		
		const locationX = window.scrollX + span.getBoundingClientRect().left
		const locationY = window.scrollY + span.getBoundingClientRect().top + 30
		
		likeListContainer.style.left = `\${locationX}px`
		likeListContainer.style.top = `\${locationY}px`
		
		likeListContainer.style.opacity = 1
		likeListContainer.innerHTML = ""
		
		
		axios.get('/board/likeList', {
			params: {
				'i_board' : i_board  //key, 변수명이 같을때는 이렇게 사용, 원래는 i_board: i_board 이렇게 해야 함
			}
		}).then(function(res) {				
			if(res.data.length > 0) {					
				for(let i=0; i<res.data.length; i++) {
					const result = makeLikeUser(res.data[i])
					likeListContainer.innerHTML += result
				}
			}
		})
	}
	
	function makeLikeUser(one) {
		const img = one.profile_img == null ? 
				'<img class="pImg" src="/img/default_profile.jpg">'
				: 
				`<img class="pImg" src="/img/user/\${one.i_user}/\${one.profile_img}">`
		
		const ele = `<div class="likeItemContainer">
			<div class="profileContainer">
				<div class="profile">
					\${img}
				</div>
			</div>
			<div class="nm">\${one.nm}</div>
		</div>`			
		return ele
	}
	
		<%-- let beforI_board = 0
		
		function getLikeList(i_board, cnt, span) {
			if(cnt == 0) { return }
			
			if(beforeI_board == i_board && likeListContainer.style.opacity == 1) {
				likeListContainer.style.display = 'none'
				return
			} else if(beforeI_board) {
				beforeI_board = i_board
				likeListContainer.style.display = 'unset'
			}
			
			const locationX = window.scrollX + span.getBoundingClientRect().left
			const locationY = window.scrollY + span.getBoundingClientRect().top + 30
			
			likeListContainer.style.left = `\${locatinX}px`
			likeListContainer.style.top = `\${locatinY}px`
			
			likeListContainer.style.opacity = 1
			likeListContainer.innerHTML = ""
			
			axios.get('/board/likeList', {
				params: {
					i_board key, 변수명이 같을 때는 이렇게 사용, 원래는 i_board : i_board 이렇게 해야 함  
				}
			}).then(function(res) {
				
				if(res.data.length > 0) {
					for(let i=0; i<res.data.length;i++) {
						const result = makeLikeUser(res.data[i])
						likeListContainer.innerHTML += result
					}
				}
			})
		}
		
		function makeLikeUser(item) {
			const img = item.profile_img == null ?
					'<img class="pImg" src="/img/default_profile.jpg">'
					:
					`<img class="pImg" src="/img/user/\${one.i_user}/\${one.profile_img}">`
			
			const ele = `<div class="likeItemContainer">
				<div class="profileContainer">
					<div class="profile">
						\${img} // \를 안쓰면 EL식이 된다
					</div>
				</div>
				<div class="nm">\${one.nm}</div>
			</div>`
			return ele
		} --%>
		
		
	
		function moveToDetail(i_board) {
			location.href = '/board/detail?page=${page}&searchText=${param.searchText}&searchType=${searchType}&record_cnt=${param.record_cnt}&i_board=' + i_board 
					//?뒤에부터는 쿼리스트링이라고 한다
		}
		
		function changeRecordCnt() {
			selFrm.submit()
		}
	</script>
</body>
</html>