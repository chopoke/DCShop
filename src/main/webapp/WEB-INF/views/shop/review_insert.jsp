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
<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: {
          primary: "#ff6b35",
          secondary: "#ffa726",
        },
        borderRadius: {
          none: "0px",
          sm: "4px",
          DEFAULT: "8px",
          md: "12px",
          lg: "16px",
          xl: "20px",
          "2xl": "24px",
          "3xl": "32px",
          full: "9999px",
          button: "8px",
        },
      },
    },
  };
</script>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
  rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
  rel="stylesheet" />
<style>
:where([class^="ri-"])::before {
  content: "\f3c2";
}
</style>
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
          <div class="bg-white rounded-lg shadow-sm border p-6 max-w-3xl mx-auto">
  <form id="insertForm" class="space-y-6"
        method="post" enctype="multipart/form-data"
        action="<c:url value='/review_insertAction.bc?pd_id=${pdId}'/>"> 

    <input type="hidden" name="pd_id" id="pd_id" value="${pdId}"/>
    <input type="hidden" name="u_member_id" id="u_member_id" value="${memberId}"/>

    <!-- 상품 이미지 + 상품명 -->
    <div class="flex items-center space-x-6">
      <img src="${pd_image_url}" alt="${pd_name}"
           class="w-24 h-24 object-cover rounded-lg border" />
      <div>
        <h2 class="text-xl font-semibold text-gray-900">${pd_name}</h2>
        <p class="text-sm text-gray-500">상품명: ${pd_name}</p>
      </div>
    </div>

    <!-- 작성자 + 평점 -->
    <div class="grid grid-cols-2 gap-6">
      <!-- 작성자 -->
      <div>
        <label class="block text-sm font-medium text-gray-700">작성자</label>
        <p class="mt-1 text-gray-900">${sessionScope.session_u_nickname}</p>
      </div>

      <!-- 평점 -->
      <div>
        <label for="r_score" class="block text-sm font-medium text-gray-700">평점</label>
        <select id="r_score" name="r_score"
                class="mt-1 block w-full border border-gray-300 rounded-lg shadow-sm p-2 focus:ring-primary focus:border-primary">
          <option value="">-- 평점 선택 --</option>
          <option value="5">★★★★★ (5)</option>
          <option value="4">★★★★☆ (4)</option>
          <option value="3">★★★☆☆ (3)</option>
          <option value="2">★★☆☆☆ (2)</option>
          <option value="1">★☆☆☆☆ (1)</option>
        </select>
      </div>
    </div>

    <!-- 리뷰 내용 -->
    <div>
      <label for="r_content" class="block text-sm font-medium text-gray-700">리뷰 내용</label>
      <textarea id="r_content" name="r_content" rows="6"
        class="mt-1 block w-full border border-gray-300 rounded-lg shadow-sm p-3 focus:ring-primary focus:border-primary"
        placeholder="상품 사용 후기를 입력해주세요."></textarea>
    </div>

    <!-- 리뷰 이미지 업로드 -->
    <div>
      <label for="r_imgFile" class="block text-sm font-medium text-gray-700">이미지</label>
      <input type="file" id="r_imgFile" name="r_imgFile" accept="image/*"
        class="mt-1 block w-full text-sm text-gray-600 border border-gray-300 rounded-lg shadow-sm focus:ring-primary focus:border-primary"/>
    </div>

    <!-- 버튼 영역 -->
    <div class="flex justify-end space-x-3">
      <button type="button" id="btnSave"
        class="bg-primary text-white px-4 py-2 rounded-button hover:bg-orange-600 transition-colors">
        작성
      </button>
      <button type="button" id="btnReset"
        class="border border-gray-300 px-4 py-2 rounded-button hover:bg-gray-50">
        초기화
      </button>
    </div>
  </form>
</div>
        </div>
      </div>
    </div>
  </div>

  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
</div>
</body>
</html>