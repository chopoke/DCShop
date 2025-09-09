<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>리뷰 작성</title>

  <!-- Tailwind -->
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: { primary: "#2563eb", secondary: "#3b82f6" },
          borderRadius: { button: "8px" }
        }
      }
    }
  </script>

  <!-- 아이콘 / 공통 JS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <!-- (선택) 프로젝트 CSS -->
  <link rel="stylesheet" href="${path}/resources/css/product/reviewList.css"/>

  <!-- 서버로부터 값 준비 -->
  <c:set var="pdId" value="${not empty param.pd_id ? param.pd_id : requestScope.pd_id}" />
  <c:set var="memberId" value="${not empty sessionScope.loginMemberId ? sessionScope.loginMemberId : sessionScope.sessionID}" />
  <c:set var="pdName" value="${not empty param.pd_name ? param.pd_name : requestScope.pd_name}" />
  <c:set var="imgSrcRaw" value="${not empty param.pd_image_url ? param.pd_image_url : requestScope.pd_image_url}" />

  <!-- 최종 이미지 경로(필요시 사용). 이미지가 계속 문제면 표시만 숨길 수도 있음 -->
  <c:set var="img" value="/resources/img/no-image.png"/>
  <c:if test="${not empty imgSrcRaw}">
    <c:choose>
      <c:when test="${fn:startsWith(imgSrcRaw,'http://') or fn:startsWith(imgSrcRaw,'https://') or fn:startsWith(imgSrcRaw,'/resources/')}">
        <c:set var="img" value="${imgSrcRaw}"/>
      </c:when>
      <c:otherwise>
        <c:set var="img" value="/resources/img_product/${imgSrcRaw}"/>
      </c:otherwise>
    </c:choose>
  </c:if>

  <style>
    textarea { resize: vertical; }
  </style>
</head>
<body class="bg-gray-50 min-h-screen">
  <%@ include file="/WEB-INF/views/setting/header.jsp" %>
  <!-- 헤더 겹침 방지: 헤더 높이만큼 여백 -->
  <div id="header-spacer" style="height: var(--header-height, 96px)"></div>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- 상단 카드 -->
    <div class="bg-white rounded-lg shadow-sm border p-8 mb-8">
      <div class="flex items-center space-x-4 mb-6">
        <div class="w-12 h-12 flex items-center justify-center bg-white rounded-lg">
          <i class="ri-star-smile-line text-2xl text-primary"></i>
        </div>
        <div>
          <h1 class="text-2xl font-bold text-gray-900">리뷰 작성</h1>
          <p class="text-gray-600"><c:out value="${pdName}"/></p>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- 상품 메타 -->
        <div class="space-y-3">
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">상품번호</span>
            <span class="font-medium"><c:out value="${pdId}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">작성자</span>
            <span class="font-medium"><c:out value="${sessionScope.session_u_nickname}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">상품명</span>
            <span class="font-medium truncate max-w-[260px]"><c:out value="${pdName}"/></span>
          </div>
        </div>

        <!-- 상품 이미지 (이미지 이슈 있으면 이 블록 자체를 주석 처리해도 됨) -->
        <div class="w-full max-w-[560px] aspect-[4/3] bg-gray-100 rounded-lg border overflow-hidden mx-auto">
          <img src="<c:url value='${img}'/>" alt="상품이미지" class="w-full h-full object-contain">
        </div>
      </div>
    </div>

    <!-- 작성 폼 -->
    <div class="bg-white rounded-lg shadow-sm border p-8">
      <h3 class="text-lg font-bold text-gray-900 mb-6">리뷰 작성</h3>

      <form id="insertForm" name="insertForm" method="post" enctype="multipart/form-data"
            action="<c:url value='/review_insertAction.bc?pd_id=${pdId}'/>">

        <input type="hidden" name="pd_id" id="pd_id" value="${pdId}">
        <input type="hidden" name="u_member_id" id="u_member_id" value="${memberId}">

        <table class="w-full border-collapse">
          <tbody>
            <tr>
              <th class="bg-gray-100 px-4 py-3 text-left font-medium text-gray-700 w-32 border border-gray-200">평점</th>
              <td class="px-4 py-3 border border-gray-200" colspan="2">
                <select name="r_score" id="r_score"
                        class="w-48 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
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
              <th class="bg-gray-100 px-4 py-3 text-left font-medium text-gray-700 w-32 border border-gray-200 align-top">리뷰 내용</th>
              <td class="px-4 py-3 border border-gray-200" colspan="2">
                <textarea rows="6" name="r_content" id="r_content"
                          placeholder="상품 사용 후기를 입력해주세요."
                          class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"></textarea>
              </td>
            </tr>

            <tr>
              <th class="bg-gray-100 px-4 py-3 text-left font-medium text-gray-700 w-32 border border-gray-200">이미지</th>
              <td class="px-4 py-3 border border-gray-200">
                <input type="file" name="r_imgFile" id="r_imgFile" accept="image/*"
                       class="block w-full text-sm text-gray-700
                              file:mr-4 file:py-2 file:px-4
                              file:rounded-button file:border-0
                              file:text-sm file:font-medium
                              file:bg-primary file:text-white
                              hover:file:bg-blue-600">
              </td>
              <td class="px-4 py-3 border border-gray-200 text-center align-middle w-40">
                <button type="button" id="btnSave"
                        class="bg-primary text-white px-6 py-2 rounded-button font-medium hover:bg-blue-600 transition-colors">
                  작성
                </button>
              </td>
            </tr>
          </tbody>
        </table>

        <div class="flex justify-end mt-4">
          <button type="button" id="btnReset"
                  class="px-4 py-2 border border-gray-300 rounded-button font-medium hover:bg-gray-50 transition-colors">
            초기화
          </button>
        </div>
      </form>
    </div>
  </main>

  <script>
    $(function(){
      $('#btnSave').on('click', function(e){
        e.preventDefault();
        const pdId = $('#pd_id').val();
        if(!pdId){ alert('상품 정보가 없습니다. (pd_id)'); return; }
        const score = $('#r_score').val();
        if(!score){ alert('평점을 선택해주세요.'); $('#r_score').focus(); return; }
        const content = $('#r_content').val().trim();
        if(!content){ alert('리뷰 내용을 입력해주세요.'); $('#r_content').focus(); return; }
        $('#insertForm')[0].submit();
      });
      $('#btnReset').on('click', function(){
        $('#insertForm')[0].reset();
      });
    });
  </script>
</body>
</html>
