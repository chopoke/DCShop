<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>댓글목록</title>

<link rel="stylesheet" href="${path}/resources/css/board.css">
<!-- <script src="https://cdn.tailwindcss.com"></script> -->
</head>
<body>
	<div id="right">
		<div class="table_div">
			<form name="boardList">
				<table border="1" width="1000px">		
					<!-- 게시글이 있으면 -->
					<c:forEach var="dto" items="${list}">
					<tr>
						<td align="left" style="background: rgba(255, 224, 178, 0.3);">${dto.c_writer}</td>
						<td align="right" style="width:120px;" rowspan="3">
							<c:if test="${sessionScope.session_u_member_id == dto.u_member_id}">
							<button type="button" class="inputButton btnCommentEdit" data-cnum="${dto.c_num}" id="btnCommentEdit">수정</button>
							<br><br>
							<button type="button" class="inputButton btnCommentDelete" data-cnum="${dto.c_num}" id="btnCommentDelete">삭제</button>
							</c:if>
						</td>
					</tr>
					<tr>
						<td align="left" class="c-content" data-cnum="${dto.c_num}">${dto.c_content}</td>
					</tr>
					<tr>
						<td align="right">${dto.c_regDate}</td>
					</tr>
					</c:forEach>
				</table>
			</form>
		</div>
	</div>
	<%-- <div id="right">
	  <div class="comment-list">
	    <c:forEach var="dto" items="${list}">
	      <div class="comment-row">
	        
	        <!-- 작성자 -->
	        <div class="writer">${dto.c_writer}</div>
	        
	        <!-- 내용 -->
	        <div class="content c-content" data-cnum="${dto.c_num}">
	          ${dto.c_content}
	        </div>
	        
	        <!-- 등록일 -->
	        <div class="date">${dto.c_regDate}</div>
	        
	        <!-- 수정/삭제 -->
	        <c:if test="${sessionScope.session_u_member_id == dto.u_member_id}">
	          <div class="actions">
	            <button type="button" class="btnCommentEdit" data-cnum="${dto.c_num}" id="btnCommentEdit">수정</button>
	            <button type="button" class="btnCommentDelete" data-cnum="${dto.c_num}" id="btnCommentDelete">삭제</button>
	          </div>
	        </c:if>
	      </div>
	    </c:forEach>
	  </div>
	</div> --%>
</body>
</html>