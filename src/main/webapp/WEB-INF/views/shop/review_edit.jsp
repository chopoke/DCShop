<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 수정</title>

  <!-- Tailwind (상세/목록과 동일 톤) -->
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

  <style>
    .no-underline,.no-underline:hover,.no-underline:focus,.no-underline:active{ text-decoration:none; }
  </style>
</head>

<%-- 상품명: 상세 페이지와 동일한 우선순위 (requestScope → param) --%>
<c:set var="pname"
       value="${not empty requestScope.pd_name
                 ? requestScope.pd_name
                 : (not empty param.pd_name ? param.pd_name : '')}" />

<body class="bg-gray-50 min-h-screen">
  <%@ include file="/WEB-INF/views/setting/header.jsp" %>
  <div id="header-spacer" style="height: var(--header-height, 96px)"></div>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- 하나의 카드 -->
    <div class="bg-white rounded-lg shadow-sm border p-8">
      <!-- 상단 헤더 -->
      <div class="flex items-center space-x-4 mb-6">
        <div class="w-12 h-12 flex items-center justify-center bg-white rounded-lg">
          <i class="ri-edit-2-line text-2xl text-primary"></i>
        </div>
        <div>
          <h1 class="text-2xl font-bold text-gray-900">리뷰 수정</h1>
          <p class="text-gray-600"><c:out value="${pname}"/></p>
        </div>
      </div>

      <!-- 상단 메타 (좌: 리뷰번호/작성자, 우: 상품번호/작성일) -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-6">
        <div class="space-y-3">
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">리뷰번호</span>
            <span class="font-medium"><c:out value="${dto.r_num}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">작성자</span>
            <span class="font-medium">
              <c:choose>
                <c:when test="${not empty dto.u_nickname}"><c:out value="${dto.u_nickname}"/></c:when>
                <c:otherwise><c:out value="${sessionScope.session_u_nickname}"/></c:otherwise>
              </c:choose>
            </span>
          </div>
        </div>

        <div class="space-y-3">
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">상품번호</span>
            <span class="font-medium"><c:out value="${dto.pd_id}"/></span>
          </div>
          <div class="flex justify-between py-2 border-b border-gray-100">
            <span class="text-gray-600">작성일</span>
            <span class="font-medium"><fmt:formatDate value="${dto.r_regDate}" pattern="yyyy-MM-dd"/></span>
          </div>
        </div>
      </div>

      <!-- 폼 -->
      <form name="editForm" method="post" enctype="multipart/form-data" class="space-y-6">
        <!-- 키값 hidden -->
        <input type="hidden" name="r_num"        id="r_num"        value="${dto.r_num}">
        <input type="hidden" name="pd_id"        id="pd_id"        value="${dto.pd_id}">
        <input type="hidden" name="u_member_id"  id="u_member_id"  value="${dto.u_member_id}">
        <input type="hidden" name="origin_r_img" id="origin_r_img" value="${dto.r_img}">

        <!-- 평점 -->
        <div>
          <label for="r_score" class="block text-gray-700 mb-2">평점</label>
          <select id="r_score" name="r_score"
                  class="w-52 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            <option value="">-- 평점 선택 --</option>
            <option value="5" <c:if test="${dto.r_score == 5}">selected</c:if>>★★★★★ (5)</option>
            <option value="4" <c:if test="${dto.r_score == 4}">selected</c:if>>★★★★☆ (4)</option>
            <option value="3" <c:if test="${dto.r_score == 3}">selected</c:if>>★★★☆☆ (3)</option>
            <option value="2" <c:if test="${dto.r_score == 2}">selected</c:if>>★★☆☆☆ (2)</option>
            <option value="1" <c:if test="${dto.r_score == 1}">selected</c:if>>★☆☆☆☆ (1)</option>
          </select>
        </div>

        <!-- 리뷰 내용 -->
        <div>
          <label for="r_content" class="block text-gray-700 mb-2">리뷰 내용</label>
          <textarea id="r_content" name="r_content" rows="6"
                    class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                    placeholder="리뷰 내용을 입력해주세요."><c:out value="${dto.r_content}"/></textarea>
        </div>

        <!-- 현재 이미지 -->
        <div>
          <div class="text-gray-700 mb-2">현재 이미지</div>
          <c:choose>
            <c:when test="${not empty dto.r_img}">
              <div class="w-full bg-gray-100 rounded-lg border overflow-hidden">
                <img src="<c:url value='${dto.r_img}'/>" alt="리뷰 이미지" class="w-full max-h-[520px] object-contain">
              </div>
            </c:when>
            <c:otherwise>
              <div class="w-full h-24 flex items-center justify-center text-gray-400 rounded-lg border">등록된 이미지가 없습니다.</div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 이미지 교체 -->
        <div>
          <label for="r_imgFile" class="block text-gray-700 mb-2">이미지 교체</label>
          <input type="file" id="r_imgFile" name="r_imgFile" accept="image/*"
                 class="block w-full text-sm text-gray-700
                        file:mr-4 file:py-2 file:px-4
                        file:rounded-button file:border-0
                        file:text-sm file:font-medium
                        file:bg-primary file:text-white
                        hover:file:bg-blue-600">
          <p class="text-xs text-gray-500 mt-2">* 새 이미지를 선택하지 않으면 기존 이미지를 유지합니다.</p>
        </div>

        <!-- 버튼: 오른쪽 아래 정렬 (목록/수정/삭제 동일 너비) -->
        <div class="flex justify-end gap-2 pt-2">
          <a href="${path}/review_list.bc?pd_id=${dto.pd_id}"
             id="btnList"
             class="no-underline min-w-[72px] h-10 px-4 inline-flex items-center justify-center
                    rounded-button font-medium border border-gray-300 hover:bg-gray-50">
            목록
          </a>

          <button type="button" id="btnEdit"
                  class="min-w-[72px] h-10 px-4 inline-flex items-center justify-center
                         rounded-button font-medium bg-primary text-white hover:bg-blue-600">
            수정
          </button>

          <button type="button" id="btndelete"
                  class="min-w-[72px] h-10 px-4 inline-flex items-center justify-center
                         rounded-button font-medium bg-primary text-white hover:bg-blue-600">
            삭제
          </button>
        </div>
      </form>
    </div>
  </main>

  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>

  <!-- 권한/검증/전송 -->
  <script>
    $(function() {
      var loggedIn = ${not empty sessionScope.session_u_member_id};

      $('#btnEdit').on('click', function() {
        if (!loggedIn) {
          if (confirm('로그인이 필요합니다. 로그인 페이지로 이동할까요?')) {
            location.href='${path}/login_main.do';
          }
          return;
        }
        const score = $('#r_score').val();
        const content = $('#r_content').val().trim();
        if(!score){ alert('평점을 선택해주세요.'); $('#r_score').focus(); return; }
        if(!content){ alert('리뷰 내용을 입력해주세요.'); $('#r_content').focus(); return; }
        document.editForm.action = '${path}/review_updateAction.bc';
        document.editForm.submit();
      });

      $('#btndelete').on('click', function() {
        if (!loggedIn) {
          if (confirm('로그인이 필요합니다. 로그인 페이지로 이동할까요?')) {
            location.href='${path}/login_main.do';
          }
          return;
        }
        if(!confirm('정말 삭제하시겠습니까?')) return;
        document.editForm.action = '${path}/review_deleteAction.bc';
        document.editForm.submit();
      });
    });
  </script>
</body>
</html>
