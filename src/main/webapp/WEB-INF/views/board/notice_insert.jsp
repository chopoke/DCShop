<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지/이벤트 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">
    <script type="text/javascript">
    $(function(){
        $('#btnSave').click(function(){
            if($('#b_category').val() === ''){
                alert('카테고리를 선택해주세요.');
                $('#b_category').focus();
                return false;
            }
            if($('#b_title').val() === ''){
                alert('글제목을 입력해주세요.');
                $('#b_title').focus();
                return false;
            }
            if($.trim($('#b_contents').val()) === ''){
                alert('글내용을 입력해주세요.');
                $('#b_contents').focus();
                return false;
            }
            document.insertForm.action='${path}/notice_insertAction';
            document.insertForm.submit();
        });
    });
    </script>
</head>
<body class="page-comm">
    <!-- 헤더부분 -->
    <%@ include file="/WEB-INF/views/setting/header.jsp" %>
    <section class="hero-section1"></section>

    <div class="wrap">
        <div id="container">
            <div id="contents">
                <center><img alt="" src="resources/img_main/작성중.png" height="100px"></center>
                <div>
                    <div class="table_div">
                        <!-- 글쓰기 폼 시작 -->
                        <form name="insertForm" method="post" enctype="multipart/form-data">
                            <table>
                                <tr>
                                    <th style="width:150px"> 작성자 </th>
                                    <td style="width:150px; text-align:left"> ${u_nickname} </td>
                                </tr>
                                <tr>
                                    <th style="width:150px"> 카테고리 </th>
                                    <td style="width:150px; text-align:left">
                                        <select class="input" name="b_category" id="b_category">
                                            <option value=""> 카테고리 선택 </option>
                                            <option value="공지"> 공지 </option>
                                            <option value="이벤트"> 이벤트 </option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="width:150px"> 글제목 </th>
                                    <td style="text-align:center">
                                        <input style="width: 1000px" type="text" class="input" name="b_title" id="b_title" size="50" placeholder="글제목 입력">
                                    </td>
                                </tr>
                                <tr>
                                    <th style="width:150px"> 글내용 </th>
                                    <td style="width:150px; text-align:center">
                                        <textarea rows="5" cols="133" name="b_contents" id="b_contents"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="width:150px"> 이미지 </th>
                                    <td style="width:150px; text-align:left">
                                        <input type="file" class="input" name="b_image" id="b_image" accept="image/*">
                                    </td>
                                </tr>
                            </table>
                            <div align="right">
                                <br>
                                <input type="button" class="inputButton" value="등록" id="btnSave">
                                <input type="reset" class="inputButton" value="초기화">
                                <input type="button" class="inputButton" value="목록" onclick="window.location='${path}/notice_list'">
                            </div>
                        </form>
                        <!-- 글쓰기 폼 끝 -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- footer부분 -->
    <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
</body>
</html>
