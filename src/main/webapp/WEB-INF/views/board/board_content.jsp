<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/setting/setting.jsp"%>

    <div>
	    <c:if test="${list != null}">
		    <c:forEach var="board" items="${list}">
				<c:forEach var="user" items="${board.userDTO}">
				<tr>
				   <td class="num">${board.b_num}</td>
				   <td>${board.b_category}</td>
				   <td class="title">
				      <a href="${path}/board_detail?b_num=${board.b_num}&listClick=1"> 
				         ${board.b_title} 
				         <c:if test="${board.b_comments != 0}">
				            <%-- [${board.b_comments}] --%>
				            <span class="comment-count"> ${board.b_comments}</span>
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
		</c:if>
		<c:if test="${list = null or list.size() == 0}">
			<tr>
				<td colspan="10">게시글이 없습니다.</td>
			</tr>
		</c:if>
    </div>