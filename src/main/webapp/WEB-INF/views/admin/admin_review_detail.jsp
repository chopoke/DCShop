<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 상세 | 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
</head>
<body class="bg-gray-100 text-[16px] leading-7">
<%@ include file="../setting/header.jsp" %>
<section class="pt-20"></section>

<div class="max-w-5xl mx-auto p-6">
  <div class="bg-white rounded-xl shadow border p-6">
    <div class="flex items-center justify-between mb-4">
      <h1 class="text-3xl font-bold">리뷰 상세</h1>
      <a href="${path}/admin_review" class="px-3 py-2 border rounded-lg hover:bg-gray-50">목록으로</a>
    </div>

    <div class="grid grid-cols-2 gap-4 text-base">
      <div class="p-3 bg-gray-50 rounded">
        <div class="mb-1 text-gray-500">리뷰번호</div>
        <div class="font-semibold"><c:out value="${detail.r_num}"/></div>
      </div>
      <div class="p-3 bg-gray-50 rounded">
        <div class="mb-1 text-gray-500">상품번호</div>
        <div class="font-semibold"><c:out value="${detail.pd_id}"/></div>
      </div>
      <div class="p-3 bg-gray-50 rounded">
        <div class="mb-1 text-gray-500">상품명</div>
        <div class="font-semibold"><c:out value="${detail.pd_name}"/></div>
      </div>
      <div class="p-3 bg-gray-50 rounded">
        <div class="mb-1 text-gray-500">작성자(ID)</div>
        <div class="font-semibold">
          <c:out value="${detail.u_id}"/> (<c:out value="${detail.u_nickname}"/>)
        </div>
      </div>
      <div class="p-3 bg-gray-50 rounded">
        <div class="mb-1 text-gray-500">평점</div>
        <div class="font-semibold"><c:out value="${detail.r_rate}"/> 점</div>
      </div>
      <div class="p-3 bg-gray-50 rounded">
        <div class="mb-1 text-gray-500">작성일</div>
        <div class="font-semibold">
          <fmt:formatDate value="${detail.r_regdate}" pattern="yyyy-MM-dd"/>
        </div>
      </div>
    </div>

    <div class="mt-6">
      <div class="mb-2 font-semibold">내용</div>
      <div class="p-4 border rounded bg-white whitespace-pre-wrap">
        <c:out value="${detail.r_content}"/>
      </div>
    </div>

    <c:if test="${not empty detail.r_img}">
      <div class="mt-6">
        <div class="mb-2 font-semibold">이미지</div>
        <img src="${pageContext.request.contextPath}${detail.r_img}" alt="리뷰 이미지" class="mx-auto max-w-full h-auto rounded-lg shadow">
      </div>
    </c:if>
  </div>
</div>

<%@ include file="../setting/footer.jsp" %>
</body>
</html>
