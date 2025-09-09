<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link rel="stylesheet" href="${path}/resources/css/board.css">
<!-- <link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;500&display=swap"
	rel="stylesheet"> -->

<script type="text/javascript">
	function confirmUpdateCheck() {
		return confirm("게시글을 수정하시겠습니까?");
	}
</script>
</head>
<body class="board-update">

	<div class="wrap">
		<!-- 헤더 부분 -->
		<%@ include file="/WEB-INF/views/setting/header.jsp" %>
		
		<section class="hero-section1">
		<!-- <div class="hero-container">
			<div class="hero-content">
				<h1 class="hero-title">랜딩 페이지 제목</h1>
				<p class="hero-description">실용성 있는 디자인과 직관적이며 대담한 추상적 조합으로, 사용하기
					자연스럽고 유용한 소프트웨어를 초점에 맞춘다.</p>
				<button class="hero-btn">더보기</button>
			</div>
		</div> -->
		</section>
		
		<div class="container">
			<div id="contents">
				<!-- <div class="titleArea">
					<h1 align="center"> 게시글 수정</h1>
				</div> -->
				<center><img alt="" src="resources/img_main/수정중.png" height="100px"></center>
				<div>
					<div class="table_div">
						<form action="${path}/board_updateAction" method="post"
								enctype="multipart/form-data" onsubmit="return confirmUpdateCheck();">
							<input type="hidden" name="b_num" value="${board.b_num}">
							<table>
								<tr>
									<th style="width: 150px"> 작성자 </th>
									<td style="width: 150px; text-align:left"> ${sessionScope.session_u_nickname} </td>
								</tr>
								<tr>
									<th style="width: 150px"> 카테고리 </th>
									<td style="width: 150px; text-align:left"> 
										<select class="input" name="b_category" id="b_category">
											<option value="자유" ${board.b_category == '자유' ? 'selected' : ''}>자유</option>
											<option value="꿀팁" ${board.b_category == '꿀팁' ? 'selected' : ''}>꿀팁</option>
											<option value="리뷰" ${board.b_category == '리뷰' ? 'selected' : ''}>리뷰</option>
											<option value="질문" ${board.b_category == '질문' ? 'selected' : ''}>질문</option>
										</select>
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 글제목 </th>
									<td style="text-align:center"> 
										<input style="width: 1000px" type="text" name="b_title" id="b_title" value="${board.b_title}">
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 글내용 </th>
									<td style="width: 150px; text-align:center">
										<textarea rows="5" cols="133" name="b_contents" id="b_contents">${board.b_contents}</textarea>
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 이미지 </th>
									<td style="width: 150px; text-align:left">
										<c:if test="${board.b_image != null}">
											<img src="${board.b_image}">
											<input type="file" class="input" name="b_image" 
											id="b_image" accept="fimage/*">
										</c:if>
										<c:if test="${board.b_image == null}">
											<input type="file" class="input" name="b_image" 
											id="b_image" accept="fimage/*">
										</c:if>
									</td>
								</tr>
							</table>
							<div align="right">
								<br>
								<button type="submit" class="inputButton">
									수정완료
								</button>
								<input type="reset" class="inputButton" value="수정전으로">
								<input type="button" class="inputButton" value="목록" onclick="window.location='${path}/board_list'">
							</div>
						</form>
					</div>
				</div>
			</div>
				
		</div>
			
		<!-- footer 부분 -->
		<%@ include file="/WEB-INF/views/setting/footer.jsp" %>
	</div>

</body>
</html>
