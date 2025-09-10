<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>board_list</title>

<link rel="stylesheet" href="${path}/resources/css/board.css">

<script type="text/javascript">
	$(function() {
		var isLoggedIn = '${not empty sessionScope.sessionid}' === 'true';
		$('#btnInsert').click(function() {
			if(isLoggedIn) {
				location.href="${path}/board_insert";
			} else {
				if(confirm("글 작성하려면 로그인 해주세요.")) {	// 확인 눌렀을 때
					// 로그인 페이지로 이동	
					location.href="${path}/login_main.do";
				}
				// 취소 누르면 목록페이지 그대로 유지
			}
		});
	});
</script>

	<c:if test="${param.delete == 'success'}">
	
	<script>alert("삭제가 완료되었습니다.");</script>
	
	</c:if>
	
	<c:if test="${param.update == 'success'}">
	
	<script>alert("수정이 완료되었습니다.");</script>
	
	</c:if>



</head>
<body class="page-comm">
	<div class="wrap">
		<!-- 헤더부분 -->
		<%@ include file="/WEB-INF/views/setting/header.jsp" %>
		
		<section class="hero-section1">
		
		</section>

		<!-- 컨텐츠부분 -->
		<!-- <div id="container1">
			<div id="contests">
				<div class="image-container1">
					<input type="text" placeholder="Search"
							class="board_search" />
				</div>
			</div>
		</div> -->
		<div id="container">
			<div id="contests">
				<div class="titleArea mx-auto w-[400px]">
					<form id="searchForm" method="get" 
						action="${pageContext.request.contextPath}/board_list">
					<!-- <h1 align="center">게시판</h1> -->
					<!-- <center><img alt="" src="resources/img_main/자유게시판3.png" width="350px"></center> -->

						<div class="image-container">
							<input type="text" placeholder="Search" class="board_search" name="keyword" value="${fn:escapeXml(param.keyword)}"/>
							<div class="son"><a href="?sortOrder=rn" data-sort="rn">최신순</a>&nbsp;<a href="?sortOrder=viewCnt" data-sort="viewCnt">조회순</a>&nbsp;<a href="?sortOrder=commCnt" data-sort="commCnt">댓글순</a>
							</div>
							<a class="a_icon" href="#"><img alt="" src="resources/img_main/icon/돋보기.png"></a>
					      	<img  class="p_img" alt="" src="resources/img_main/고개틀2.png">
					      	<div class="text-overlay">
					        	<b>자유게시판</b>
					      	</div>
				    	</div>
					</form>
				</div>

				<div>
					<!-- 검색 부분 -->
				</div>

				<div class="table_div">
					<form name="boardList">
						<table>
							<tr>
								<th style="width: 80px">번호</th>
								<th style="width: 80px">
									<div class="board-filter">
									  <a href="#" class="filter-link" id="filterLink">전체▼</a>
									  <div class="filter-menu">
									    <a href="?category=all" data-cat="all">전체</a>
									    <a href="?category=free" data-cat="free">자유</a>
									    <a href="?category=honeytip" data-cat="honeytip">꿀팁</a>
									    <a href="?category=review" data-cat="review">리뷰</a>
									    <a href="?category=question" data-cat="question">질문</a>
									  </div>
									</div>
								</th>
								
								<th style="width: auto">제목</th>
								<th style="width: 100px">작성자</th>
								<th style="width: 80px"><img
									src="/DCShop/resources/image/board/추천_total.png"></th>
								<th style="width: 80px">조회</th>
								<th style="width: 200px">작성일</th>
							</tr>

							<!-- 게시글이 있으면 -->
							<%@ include file = "board_content.jsp" %>
						</table>

						<div align="right">
							<br> <input type="button" class="inputButton" value="글쓰기"
								id="btnInsert">
						</div>

						<div class="paging">
							<ul class="pagination">
								<!-- 페이징 처리 -->
								<!-- 이전 버튼 활성화 -->
								<c:if test="${paging.startPage > 10}">
									<li><a href="${path}/board_list?pageNum=${paging.prev}<c:if test='${keyword != null}'>&keyword=${keyword}</c:if>"
										class="prevPage"> << </a></li>
								</c:if>

								<!-- 페이지 번호 처리 -->
								<c:forEach var="num" begin="${paging.startPage}"
									end="${paging.endPage}">
									<li><a href="${path}/board_list?pageNum=${num}<c:if test='${keyword != null}'>&keyword=${keyword}</c:if>"
										class="<c:if test='${num == paging.currentPage}'> active </c:if>">
											${num} </a></li>
								</c:forEach>

								<!-- 다음 버튼 활성화 -->
								<c:if test="${paging.endPage < paging.pageCount}">
									<li><a href="${path}/board_list?pageNum=${paging.next}<c:if test='${keyword != null}'>&keyword=${keyword}</c:if>"
										class="nextPage"> >> </a></li>
								</c:if>
							</ul>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- footer부분 -->
		<%@ include file="/WEB-INF/views/setting/footer.jsp" %>
	</div>
	
<script>
	document.addEventListener("DOMContentLoaded", function(){		// 페이지 로드시 실행
		// url 에서 가져온 값으로 카테고리 변경해서 보여주기
		const url = new URLSearchParams(window.location.search);	// 현재주소에서 search한 key-vlaue쌍 -> url에 담음
		const category = url.get('category') || 'all' ;
		const name = {all : "전체", free : "자유", honeytip : "꿀팁", review : "리뷰", question : "질문"}	// 매핑할 데이터
		const el = document.querySelector(".filter-link");		// 링크들을 담은 요소
	    if (el) el.textContent = (name[category] || "전체") + "▼";	// 기존에 보이던 요소 덮어씌우기
	    
	    const form = document.getElementById("searchForm");			// 폼 가져오기
	    const catInput = document.getElementById("categoryInput");	// 카테고리들 가져오기
	    
	    if (catInput) catInput.value = category;
	    
	    document.querySelectorAll("#filter-menu a").forEach(a =>
	    	a.addEventListener("click", function(e){
	    		e.preventDefault();
	    		catInput.value = this.dataset.cat;
	    	      form.action = "${pageContext.request.contextPath}/board_list?pageNum=1";		// 카테고리 변경시 페이지 번호 1
	    	      form.submit();
	    	})
	    )
	    
	    const cur = new URL(location.href);
	    document.querySelectorAll(".pagination a").forEach(a => {
	      	const target = new URL(a.getAttribute("href"), location.origin);
	      	const pageNum = target.searchParams.get("pageNum");
	      	const next = new URLSearchParams(cur.search);
	      	if (pageNum) next.set("pageNum", pageNum);
	      	a.href = cur.pathname + "?" + next.toString();
	    });
	});
</script>	
</body>
</html>