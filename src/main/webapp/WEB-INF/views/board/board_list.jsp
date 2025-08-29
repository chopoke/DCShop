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
<body>
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
					<!-- <h1 align="center">게시판</h1> -->
					<!-- <center><img alt="" src="resources/img_main/자유게시판3.png" width="350px"></center> -->

					<div class="image-container">
						<input type="text" placeholder="Search" class="board_search" />
						<a href="#"><img alt="" src="resources/img_main/icon/돋보기.png"></a>
				      	<img alt="" src="resources/img_main/고개틀2.png">
				      	<div class="text-overlay">
				        	<h4><b>자유게시판</b></h4>
				      	</div>
				    </div>
					
				</div>

				<div>
					<!-- 검색 부분 -->
				</div>

				<div class="table_div">
					<form name="boardList">
						<table>
							<tr>
								<th style="width: 80px">번호</th>
								<th style="width: 80px">구분</th>
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
                           <td class="title">
                              <a href="${path}/board_detail?b_num=${board.b_num}&listClick=1"> 
                                 ${board.b_title} 
                                 <c:if test="${board.b_comments != 0}">
                                    [${board.b_comments}]
                                 </c:if>
                              </a>
                           </td>
                           <td>${user.u_nickname}</td>
                           <td>${board.b_recommend}</td>
                           <td>${board.b_views}</td>
                           <td>${board.b_dateposted}</td>
                        </tr>
                        </c:forEach>
                     </c:forEach>
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
									<li><a href="${path}/board_list?pageNum=${paging.prev}"
										class="prevPage"> << </a></li>
								</c:if>

								<!-- 페이지 번호 처리 -->
								<c:forEach var="num" begin="${paging.startPage}"
									end="${paging.endPage}">
									<li><a href="${path}/board_list?pageNum=${num}"
										class="<c:if test='${num == paging.currentPage}'> active </c:if>">
											${num} </a></li>
								</c:forEach>

								<!-- 다음 버튼 활성화 -->
								<c:if test="${paging.endPage < paging.pageCount}">
									<li><a href="${path}/board_list?pageNum=${paging.next}"
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
</body>
</html>