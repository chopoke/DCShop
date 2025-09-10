<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 상세</title>

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
  <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<%-- 상품명/이미지 경로 정리 --%>
<c:set var="pname"
       value="${not empty requestScope.pd_name
                 ? requestScope.pd_name
                 : (not empty param.pd_name ? param.pd_name : '(상품명 정보 없음)')}" />

<c:set var="imgRaw"
       value="${not empty requestScope.pd_image_url
                 ? requestScope.pd_image_url
                 : param.pd_image_url}" />

<c:set var="img" value="/resources/img/no-image.png"/>
<c:if test="${not empty imgRaw}">
  <c:choose>
    <c:when test="${fn:startsWith(imgRaw,'http://')
                or fn:startsWith(imgRaw,'https://')
                or fn:startsWith(imgRaw,'/resources/')}">
      <c:set var="img" value="${imgRaw}"/>
    </c:when>
    <c:otherwise>
      <c:set var="img" value="/resources/img_product/${imgRaw}"/>
    </c:otherwise>
  </c:choose>
</c:if>

<body class="bg-gray-50 min-h-screen">
  <%@ include file="/WEB-INF/views/setting/header.jsp" %>
  <div id="header-spacer" style="height: var(--header-height, 96px)"></div>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <c:set var="rv" value="${empty review ? dto : review}" />

    <!-- 하나의 카드 -->
    <div class="bg-white rounded-lg shadow-sm border p-8">
      <!-- 헤더 -->
      <div class="flex items-center space-x-4 mb-6">
        <div class="w-12 h-12 flex items-center justify-center bg-white rounded-lg">
          <i class="ri-star-smile-line text-2xl text-primary"></i>
        </div>
        <div>
          <h1 class="text-2xl font-bold text-gray-900">리뷰 상세</h1>
          <p class="text-gray-600"><c:out value="${pname}"/></p>
        </div>
      </div>

      <!-- 상단: 메타 + 상품 이미지 -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- 메타 -->
        <div class="space-y-3">
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">리뷰번호</span>
            <span class="font-medium"><c:out value="${rv.r_num}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">상품번호</span>
            <span class="font-medium"><c:out value="${rv.pd_id}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">작성자</span>
            <span class="font-medium"><c:out value="${rv.u_nickname}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">작성일</span>
            <span class="font-medium"><fmt:formatDate value="${rv.r_regDate}" pattern="yyyy-MM-dd"/></span>
          </div>
        </div>

        <!-- 상품 이미지-->
        <div class="w-full max-w-[560px] h-64 bg-gray-100 rounded-lg border overflow-hidden mx-auto self-start">
          <img src="<c:url value='${img}'/>" alt="상품이미지" class="w-full h-full object-contain">
        </div>
      </div>

      <hr class="my-6">

      <!-- 별점 -->
      <div class="mb-4">
        <span class="text-gray-600 mr-3">별점</span>
        <span class="align-middle" aria-label="별점 ${rv.r_score}점">
          <c:forEach var="i" begin="1" end="5">
            <i class="${i <= rv.r_score ? 'ri-star-fill text-primary' : 'ri-star-line text-gray-300'} text-xl"></i>
          </c:forEach>
        </span>
      </div>

      <!-- 내용 -->
      <div class="mb-6">
        <div class="text-gray-600 mb-2">내용</div>
        <div class="whitespace-pre-line leading-7 text-gray-800 bg-gray-50 border rounded-lg p-4">
          <c:out value="${rv.r_content}"/>
        </div>
      </div>

      <!-- 리뷰 이미지: 가로 전체 -->
      <c:if test="${not empty rv.r_img}">
        <div class="mb-6">
          <div class="text-gray-600 mb-2">이미지</div>
          <div class="w-full bg-gray-100 rounded-lg border overflow-hidden">
            <img src="<c:url value='${rv.r_img}'/>"
                 alt="리뷰 이미지"
                 class="w-full max-h-[520px] object-contain">
          </div>
        </div>
      </c:if>

      <!-- 오른쪽 아래 버튼 -->
		<div class="flex justify-end gap-2 mt-8">
		  <a href="${path}/review_list.bc?pd_id=${rv.pd_id}"
			   class="no-underline hover:no-underline focus:no-underline active:no-underline
			          min-w-[72px] h-10 px-4 text-center rounded-button font-medium
			          border border-gray-300 hover:bg-gray-50 transition-colors inline-flex items-center justify-center">
			  목록
			</a>
			
			<a href="${path}/review_editForm.bc?r_num=${rv.r_num}" id="btnEditLink"
			   class="no-underline hover:no-underline focus:no-underline active:no-underline
			          min-w-[72px] h-10 px-4 text-center rounded-button font-medium
			          bg-primary text-white hover:bg-blue-600 transition-colors inline-flex items-center justify-center">
			  수정
			</a>

		  <form id="deleteForm" method="post" action="<c:url value='/review_deleteAction.bc'/>" class="inline">
		    <input type="hidden" name="r_num" value="${rv.r_num}"/>
		    <button type="submit"
		            class="min-w-[72px] h-10 px-4 text-center rounded-button font-medium
		                   bg-primary text-white hover:bg-blue-600 transition-colors inline-flex items-center justify-center">
		      삭제
		    </button>
		  </form>
		</div>
    </div>
  </main>

  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>

  <!-- 권한/확인 -->
  <script>
    $(function () {
      var loggedIn = ${not empty sessionScope.session_u_member_id};

      $('#btnEditLink').on('click', function (e) {
        if (!loggedIn) {
          e.preventDefault();
          if (confirm('로그인이 필요합니다. 로그인 페이지로 이동할까요?')) {
            location.href='${path}/login_main.do';
          }
        }
      });

      $('#deleteForm').on('submit', function (e) {
        if (!loggedIn) {
          e.preventDefault();
          if (confirm('로그인이 필요합니다. 로그인 페이지로 이동할까요?')) {
            location.href='${path}/login_main.do';
          }
          return false;
        }
        if (!confirm('정말 삭제하시겠습니까?')) {
          e.preventDefault();
          return false;
        }
      });
    });
  </script>
</body>
</html>
