<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>notice_detail</title>
    <link rel="stylesheet" href="${path}/resources/css/board.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    function deleteConfirm(){
        if(confirm('정말 삭제하시겠습니까?')){
            location.href='${path}/notice_delete?b_num=${board.b_num}';
        }
    }
    $(function(){
        $('#recommendBtn').click(function(){
            if(${sessionScope.sessionid != null}) {
                var click = $('#recommendBtn').hasClass('active') ? 0 : 1;
                $.post('${path}/notice_recommend', {
                    b_num: '${board.b_num}', 
                    click: click
                }, function(res){
                    if(parseInt(res.success) === 1){
                        $('#recommendTotal').text(res.b_recommend);
                        $('#recommendBtn').toggleClass('active', click === 1);
                    }
                });
            } else {
                if(confirm('로그인이 필요합니다.')) {
                    location.href='${path}/login_main.do';
                }
            }
        });
    });

    </script>
</head>
<body>
    <div class="wrap">
        <!-- 헤더 부분 -->
        <%@ include file="/WEB-INF/views/setting/header.jsp" %>
        <section class="hero-section1"></section>
        <!-- 컨텐츠 부분 -->
        <div id="container">
            <div id="contents">
                <center><img alt="" src="resources/img_main/카테.png" height="100px"></center>
				<div class="text-overlay1">
                    <h4><b>${board.b_category}</b></h4>
                </div>
                <c:set var="user" value="${board.userDTO[0]}"/>
                <div>
                    <div class="table_div">
                        <table>
                            <tr>
                                <td align="left">
                                    <div style="font-size: 25px">[${board.b_category}] ${board.b_title}</div>
                                    <div style="font-size: 15px" align="right">작성자 : ${user.u_nickname}</div>
                                </td>
                            </tr>
                            <tr>
                                <th align="left">
                                    <div class="inline">
                                        <img src="/DCShop/resources/image/board/추천_total.png">
                                        <span id="recommendTotal"> ${board.b_recommend} </span>
                                    </div>
                                    <div class="inline"> 조회 ${board.b_views} </div>
                                </th>
                            </tr>
                            <tr>
                                <td>
                                    <div style="min-height: 700px; white-space: pre-line;" align="left">
                                        ${board.b_contents}
                                        <c:if test='${board.b_image != null}'>
                                            <img src='${pageContext.request.contextPath}/resources/board_upload/${board.b_image}' style='width:350px'>
                                        </c:if>
                                    </div>
                                    <div align="right" style="height: 20px">
                                        <div style="font-size: 15px"> 등록일 : <fmt:formatDate value='${board.b_dateposted}' pattern='yyyy-MM-dd HH:mm'/> </div>
                                    </div>
                                    <c:if test='${board.b_updateDate != null}'>
                                        <div align="right" style="height: 20px">
                                            <div style="font-size: 15px"> 수정일 : <fmt:formatDate value='${board.b_updateDate}' pattern='yyyy-MM-dd HH:mm'/> </div>
                                        </div>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:if test='${isRecommended == 0}'>
                                      추천하기 <input type="button" class="recommendButton" id="recommendBtn" data-bnum="${board.b_num}">
                                    </c:if>
                                    <c:if test='${isRecommended == 1}'>
                                       	추천하기 <input type="button" class="recommendButton active" id="recommendBtn" data-bnum="${board.b_num}">
                                    </c:if>
                                </td>
                            </tr>
                        </table>
                        <div align="right">
                            <br>
                            <c:if test='${sessionScope.sessionid == user.u_id}'>
                                <input type="button" class="inputButton" value="수정" onclick="window.location='${path}/notice_update?b_num=${board.b_num}'">
                                <input type="button" class="inputButton" value="삭제" onclick="deleteConfirm()">
                            </c:if>
                            <input type="button" class="inputButton" value="목록" onclick="window.location='${path}/notice_list'">
                        </div>
                    </div>
                </div>
                <!-- 댓글 파트(필요 시 통합 가능) -->
            </div>
        </div>
        <!-- footer 부분 -->
        <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
    </div>
</body>
</html>
