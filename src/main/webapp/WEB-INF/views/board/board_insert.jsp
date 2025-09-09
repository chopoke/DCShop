<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>board_insert</title>

<link rel="stylesheet" href="${path}/resources/css/board.css">

<script type="text/javascript">
	$(function() {	
		// [게시글 작성 버튼] 클릭시 [게시글 작성처리]로 이동
		$('#btnSave').click(function() {
			if($('#b_category').val() == "") {
				alert("카테고리를 선택해주세요.");
				$('#b_category').focus();
				return false;
			}
			if($('#b_title').val() == "") {
				alert("글제목을 입력해주세요.");
				$('#b_title').focus();
				return false;
			}
			if($.trim($('#b_contents').val()) == "") {
				alert("글내용을 입력해주세요.");
				$('#b_contents').focus();
				return false;
			}
			
			document.insertForm.action="${path}/board_insertAction";
			document.insertForm.submit();
		});
		
	});
</script>
</head>
<body class="page-comm">

	<div class="wrap">
		<!-- 헤더 부분 -->
		<%@ include file="/WEB-INF/views/setting/header.jsp" %>
		
		<section class="hero-section1">
		
		</section>
		
		<!-- 컨텐츠 부분 -->
		<div id="container">
			<div id="contents">
				<!-- <div class="titleArea">
					<h1 align="center"> 게시글 작성</h1>
				</div> -->
				<center><img alt="" src="resources/img_main/작성중.png" height="100px"></center>
				<div>
					<div class="table_div">
						<form name="insertForm" method="post" enctype="multipart/form-data">
							<table>
								<tr>
									<th style="width: 150px"> 작성자 </th>
									<td style="width: 150px; text-align:left"> ${u_nickname} </td>
								</tr>
								<tr>
									<th style="width: 150px"> 카테고리 </th>
									<td style="width: 150px; text-align:left"> 
										<select class="input" name="b_category" id="b_category">
											<option value=""> 카테고리 선택 </option>
											<option value="자유"> 자유 </option>
											<option value="꿀팁"> 꿀팁 </option>
											<option value="리뷰"> 리뷰 </option>
											<option value="질문"> 질문 </option>
										</select>
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 글제목 </th>
									<td style="text-align:center">
										<input style="width: 1000px" type="text" class="input" name="b_title" 
										id="b_title" size="50" placeholder="글제목 입력"> 
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 글내용 </th>
									<td style="width: 150px; text-align:center">
										<textarea rows="5" cols="133" name="b_contents" id="b_contents"> </textarea>
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 이미지 </th>
									<td style="width: 150px; text-align:left">
										<input type="file" class="input" name="b_image" 
											id="b_image" accept="fimage/*">
									</td>
								</tr>
							</table>
							<div align="right">
								<br>
								<input type="button" class="inputButton" value="등록" id="btnSave">
								<input type="reset" class="inputButton" value="초기화">
								<input type="button" class="inputButton" value="목록" onclick="window.location='${path}/board_list'">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 끝 -->
		
		<!-- footer 부분 -->
		<%@ include file="/WEB-INF/views/setting/footer.jsp" %>
	</div>
	
</body>
</html>