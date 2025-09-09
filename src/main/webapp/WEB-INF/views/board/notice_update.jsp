<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지/이벤트 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">
    <style>
        .write-form { max-width: 800px; margin: 0 auto; padding: 20px; }
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; }
        .form-control:focus { outline: none; border-color: #007bff; box-shadow: 0 0 0 2px rgba(0,123,255,.25); }
        textarea.form-control { min-height: 300px; resize: vertical; }
        .btn-group { text-align: right; margin-top: 30px; }
        .btn { padding: 10px 20px; margin: 0 6px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; text-decoration: none; display: inline-block; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .btn:hover { opacity: 0.9; }
        .current-image { margin: 10px 0; padding: 10px; background-color: #f8f9fa; border-radius: 4px; }
        .current-image img { max-width: 200px; height: auto; }
    </style>
    <script type="text/javascript">
        function confirmUpdateCheck() {
            return confirm("게시글을 수정하시겠습니까?");
        }
        function goListByCategory(){
            var cat = document.getElementById('b_category').value;
            if(cat === '공지' || cat === '이벤트'){
                window.location='${path}/notice_list';
            }else{
                window.location='${path}/notice_list';
            }
        }
    </script>
</head>
<body class="board-update">

	<div class="wrap">
		<!-- 헤더 부분 -->
		<%@ include file="/WEB-INF/views/setting/header.jsp" %>
		
		<section class="hero-section1">
		</section>
		
		<div class="container">
			<div id="contents">
				<center><img alt="" src="resources/img_main/수정중.png" height="100px"></center>
				<div>
					<div class="table_div">
						<form action="${path}/notice_updateAction" method="post"
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
										<select class="input" name="b_category" id="b_category" required>
											<option value=""> 카테고리선택 </option> 
											<option value="공지" ${board.b_category == '공지' ? 'selected' : ''}> 공지 </option>
											<option value="이벤트" ${board.b_category == '이벤트' ? 'selected' : ''}> 이벤트 </option>
										</select>
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 글제목 </th>
									<td style="text-align:center"> 
										<input style="width: 1000px" type="text" name="b_title" id="b_title" value="${board.b_title}" required>
									</td>
								</tr>
								<tr>
									<th style="width: 150px"> 글내용 </th>
									<td style="width: 150px; text-align:center">
										<textarea rows="5" cols="133" name="b_contents" id="b_contents" required>${board.b_contents}</textarea>
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
								<input type="button" class="inputButton" value="목록" onclick="goListByCategory()">
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
