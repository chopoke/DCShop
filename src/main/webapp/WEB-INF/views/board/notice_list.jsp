<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지/이벤트</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board.css">
<script type="text/javascript">
	$(function() {
		var isLoggedIn = '${not empty sessionScope.sessionid}' === 'true';
		$('#btnInsert').click(function() {
			if (isLoggedIn) {
				location.href = "${path}/notice_insert";
			} else {
				if (confirm("글 작성하려면 로그인 해주세요.")) { // 확인 눌렀을 때
					location.href = "${path}/login_main.do";
				}
			}
		});
	});
</script>

<c:if test="${param.delete == 'success'}">
	<script>
		alert("삭제가 완료되었습니다.");
	</script>
</c:if>

<c:if test="${param.update == 'success'}">
	<script>
		alert("수정이 완료되었습니다.");
	</script>
</c:if>
</head>
<body class="page-comm">
	<div class="wrap">
		<!-- 헤더부분 -->
		<%@ include file="/WEB-INF/views/setting/header.jsp"%>

		<section class="hero-section1"></section>

		<!-- 타이틀/검색 박스 (자유게시판과 동일 스타일) -->
		<div id="container">
			<div id="contests">
				<div class="titleArea mx-auto w-[400px]">
					<div class="image-container">
						<input type="text" placeholder="Search" class="board_search" /> <a
							href="#"><a class="a_icon1" href="#"><img alt="" src="resources/img_main/icon/돋보기.png"></a>
						<img class="p_img1" alt="" src="resources/img_main/고개틀2.png">
						<div class="text-overlay">
								<b>공지/이벤트</b>
						</div>
					</div>
				</div>
			</div>
		</div>







		<!-- 게시글 목록 -->
		<div class="board-list table_div">
			<form>
				<table>
					<tr>
						<th style="width: 80px">번호</th>
						<th style="width: 80px">
							<div class="board-filter">
								<a href="#" class="filter-link">구분▼</a>
								<div class="filter-menu">
									<a href="#">전체</a> 
									<a href="#">공지</a> 
									<a href="#">이벤트</a>
						<th style="width: auto">제목</th>
						<th style="width: 100px">작성자</th>
						<th style="width: 80px"><img
							src="/DCShop/resources/image/board/추천_total.png"></th>
						<th style="width: 80px">조회</th>
						<th style="width: 200px">작성일</th>
					</tr>
					<!-- 게시글이 있으면 -->
					<c:forEach var="board" items="${list}">
						<c:forEach var="user" items="${board.userDTO}">
							<tr>
								<td class="num">${board.b_num}</td>
								<td>${board.b_category}</td>
								<td class="title"><a
									href="${path}/notice_detail?b_num=${board.b_num}&listClick=1">
										${board.b_title} <c:if test="${board.b_comments != 0}">[${board.b_comments}]</c:if>
								</a></td>
								<td>${user.u_nickname}</td>
								<td>${board.b_recommend}</td>
								<td>${board.b_views}</td>
								<td><fmt:formatDate value="${board.b_dateposted}"
										pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</c:forEach>
				</table>
				<!-- 글쓰기 버튼 (로그인 시) -->
				<div align="right">
					<br> <input type="button" class="inputButton" value="글쓰기"
						id="btnInsert">
				</div>
			</form>
		</div>

		<!-- 페이징 -->
		<div class="paging">
			<ul class="pagination">
				<!-- 이전 버튼 활성화 -->
				<c:if test="${paging.startPage > 10}">
					<li><a href="${path}/notice_list?pageNum=${paging.prev}"
						class="prevPage"> << </a></li>
				</c:if>
				<!-- 페이지 번호 처리 -->
				<c:forEach var="num" begin="${paging.startPage}"
					end="${paging.endPage}">
					<li><a href="${path}/notice_list?pageNum=${num}"
						class="<c:if test='${num == paging.currentPage}'> active </c:if>'">${num}</a>
					</li>
				</c:forEach>
				<!-- 다음 버튼 활성화 -->
				<c:if test="${paging.endPage < paging.pageCount}">
					<li><a href="${path}/notice_list?pageNum=${paging.next}"
						class="nextPage"> >> </a></li>
				</c:if>
			</ul>
		</div>

		<!-- footer부분 -->
		<%@ include file="/WEB-INF/views/setting/footer.jsp"%>
	</div>
</body>
</html>
