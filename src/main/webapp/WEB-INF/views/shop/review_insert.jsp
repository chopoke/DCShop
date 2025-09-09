<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>리뷰 작성</title>

<!-- css -->
<link rel="stylesheet" href="${path}/resources/css/product/reviewList.css">

<!-- js -->
<script src="https://kit.fontawesome.com/7e22bb38b7.js" crossorigin="anonymous"></script>
<script src="${path}/resources/js/common/main.js" defer></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<%-- pd_id: param 우선, 없으면 requestScope --%>
<c:set var="pdId" value="${not empty param.pd_id ? param.pd_id : requestScope.pd_id}" />
<%-- 로그인 아이디: 프로젝트에서 실제 쓰는 세션 키로 통일하세요 (예: sessionid 또는 loginMemberId) --%>
<c:set var="memberId" value="${not empty sessionScope.loginMemberId ? sessionScope.loginMemberId : sessionScope.sessionID}" />

<script>
$(function(){
  $('#btnSave').on('click', function(e){
    e.preventDefault();

    const pdId = $('#pd_id').val();
    if(!pdId){
      alert('상품 정보가 없습니다. (pd_id)');
      return false;
    }
    const score = $('#r_score').val();
    if(!score){
      alert('평점을 선택해주세요.');
      $('#r_score').focus();
      return false;
    }
    const content = $('#r_content').val().trim();
    if(!content){
      alert('리뷰 내용을 입력해주세요.');
      $('#r_content').focus();
      return false;
    }

    $('#insertForm')[0].submit(); // action은 폼에 이미 지정
  });

  $('#btnReset').on('click', function(){
    $('#insertForm')[0].reset();
  });
});
</script>
</head>

<body class="page-shop">
<div class="wrap">
  <%@ include file="/WEB-INF/views/setting/header.jsp" %>

	<section class="hero-section1">
	</section>

  <div id="container">
    <div id="contents">
      <div><h1 class="page-title">리뷰 작성</h1></div>

      <div id="section2">
        <div id="right">
          <div class="table_div">
            <form id="insertForm" name="insertForm"
                  method="post"
                  enctype="multipart/form-data"
                  action="<c:url value='/review_insertAction.bc?pd_id=${pdId}'/>"> 

              <input type="hidden" name="pd_id" id="pd_id" value="${pdId}"/>
              <input type="hidden" name="u_member_id" id="u_member_id" value="${memberId}"/>

              <table>
                <tr>
                  <th style="width:200px">작성자</th>
                  <td style="width:200px; text-align:center">
                    <c:out value="${sessionScope.session_u_nickname}"/>
                  </td>

                  <th style="width:200px">상품번호</th>
                  <td style="width:200px; text-align:center">
                    <c:out value="${pdId}"/>
                  </td>
                </tr>

                <tr>
                  <th>평점</th>
                  <td colspan="3" style="text-align:center">
                    <select name="r_score" id="r_score">
                      <option value="">-- 평점 선택 --</option>
                      <option value="5">★★★★★ (5)</option>
                      <option value="4">★★★★☆ (4)</option>
                      <option value="3">★★★☆☆ (3)</option>
                      <option value="2">★★☆☆☆ (2)</option>
                      <option value="1">★☆☆☆☆ (1)</option>
                    </select>
                  </td>
                </tr>

                <tr>
                  <th>리뷰 내용</th>
                  <td colspan="3" style="text-align:center">
                    <textarea rows="6" cols="80" name="r_content" id="r_content"
                              placeholder="상품 사용 후기를 입력해주세요."></textarea>
                  </td>
                </tr>

                <tr>
                  <th>이미지</th>
                  <td colspan="3" style="text-align:center">
                    <input type="file" name="r_imgFile" id="r_imgFile" accept="image/*" />
                  </td>
                </tr>

                <tr>
                  <td colspan="4" style="text-align:center">
                    <br>
                    <input type="button" class="btn btn-dark" value="작성" id="btnSave">
                    <input type="button" class="btn btn-dark" value="초기화" id="btnReset">
                  </td>
                </tr>
              </table>
            </form>
            <!-- /form -->
          </div>
        </div>
      </div>
    </div>
  </div>

  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
</div>
</body>
</html>