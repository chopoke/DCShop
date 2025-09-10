<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>리뷰 목록</title>

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

  <!-- jQuery (행 클릭용) -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <style>
    .no-underline, .no-underline:hover, .no-underline:focus { text-decoration: none; }
  </style>

  <!-- 파라미터 정리 (상세/작성 이동에 같이 넘길 값) -->
  <c:set var="pdId"  value="${not empty param.pd_id ? param.pd_id : requestScope.pd_id}" />
  <c:set var="pname" value="${not empty param.pd_name ? param.pd_name : (not empty requestScope.product ? requestScope.product.pd_name : '')}" />
  <c:set var="pimg"  value="${not empty param.pd_image_url ? param.pd_image_url : (not empty requestScope.product ? requestScope.product.pd_image_url : '')}" />

  <!-- 리뷰 작성 링크 -->
  <c:url var="reviewWriteUrl" value="/review_insert.bc">
    <c:if test="${not empty pdId}"><c:param name="pd_id" value="${pdId}"/></c:if>
    <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}"/></c:if>
    <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}"/></c:if>
  </c:url>

  <!-- 행 전체 클릭: 내부 버튼/링크 클릭 시에는 기본동작 유지 -->
  <script>
    document.addEventListener('click', function(e){
      const card = e.target.closest('[data-href]');
      if(!card) return;
      if (e.target.closest('a,button,input,select,textarea,label')) return;
      location.href = card.dataset.href;
    });
  </script>
</head>
<body class="bg-gray-50 min-h-screen">
  <%@ include file="/WEB-INF/views/setting/header.jsp" %>
  <div id="header-spacer" style="height: var(--header-height, 96px)"></div>

  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

    <!-- 상단 헤더 -->
    <div class="bg-white rounded-lg shadow-sm border p-6 mb-6">
      <div class="flex items-center space-x-4">
        <div class="w-10 h-10 flex items-center justify-center bg-white rounded-lg">
          <i class="ri-star-smile-line text-xl text-primary"></i>
        </div>
        <div>
          <h1 class="text-2xl font-bold text-gray-900">리뷰 목록</h1>
          <p class="text-gray-600">
            <c:out value="${pname}"/>
          </p>
        </div>
        <div class="ml-auto">
          <a href="${reviewWriteUrl}"
             class="no-underline inline-flex items-center justify-center
                    bg-primary text-white px-4 h-10 rounded-button font-medium hover:bg-blue-600">
            리뷰 작성
          </a>
        </div>
      </div>
    </div>

    <!-- 리스트: 카드 그리드 -->
    <div class="bg-white rounded-lg shadow-sm border p-6">
      <c:choose>
        <c:when test="${not empty list}">
          <ul class="grid gap-4 md:gap-6 grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
            <c:forEach var="dto" items="${list}">
              <!-- 상세 링크 만들기 -->
              <c:url var="rvDetail" value="/review_detailAction.bc">
                <c:param name="r_num" value="${dto.r_num}" />
                <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}" /></c:if>
                <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}" /></c:if>
              </c:url>

              <li data-href="${rvDetail}"
                  class="cursor-pointer group rounded-lg border hover:border-primary/40 hover:shadow transition
                         bg-white overflow-hidden">
                <!-- 상단 썸네일 -->
                <div class="w-full h-40 bg-gray-100">
                  <c:choose>
                    <c:when test="${not empty dto.r_img}">
                      <img src="<c:url value='${dto.r_img}'/>" alt="리뷰 이미지"
                           class="w-full h-full object-cover">
                    </c:when>
                    <c:otherwise>
                      <div class="w-full h-full flex items-center justify-center text-gray-400">이미지 없음</div>
                    </c:otherwise>
                  </c:choose>
                </div>

                <!-- 본문 -->
                <div class="p-4 space-y-2">
                  <!-- 별점 -->
                  <div class="text-primary">
                    <c:forEach var="i" begin="1" end="5">
                      <i class="${i <= dto.r_score ? 'ri-star-fill' : 'ri-star-line'}"></i>
                    </c:forEach>
                  </div>

                  <!-- 내용 요약 -->
                  <div class="text-gray-900 font-medium line-clamp-2">
                    <c:out value="${fn:length(dto.r_content) > 80
                                     ? fn:substring(dto.r_content,0,80)
                                     : dto.r_content}"/>
                    <c:if test="${fn:length(dto.r_content) > 80}">…</c:if>
                  </div>

                  <!-- 메타: 작성자/날짜/번호 -->
                  <div class="text-sm text-gray-500 flex items-center justify-between">
                    <span>
                      <c:choose>
                        <c:when test="${not empty dto.u_nickname}">
                          <c:out value="${dto.u_nickname}"/>
                        </c:when>
                        <c:otherwise>
                          회원번호: <c:out value="${dto.u_member_id}"/>
                        </c:otherwise>
                      </c:choose>
                    </span>
                    <span><fmt:formatDate value="${dto.r_regDate}" pattern="yyyy-MM-dd"/></span>
                  </div>
                </div>

                <!-- 하단 바: 번호/상품번호 + 바로보기 -->
                <div class="px-4 pb-4 flex items-center justify-between text-xs text-gray-500">
                  <span>리뷰번호 ${dto.r_num} · 상품번호 ${dto.pd_id}</span>
                  <a href="${rvDetail}" class="no-underline text-primary hover:underline">바로보기</a>
                </div>
              </li>
            </c:forEach>
          </ul>
        </c:when>
        <c:otherwise>
          <div class="text-center text-gray-500 py-16">등록된 리뷰가 없습니다.</div>
        </c:otherwise>
      </c:choose>

      <!-- 페이징 -->
      <c:if test="${paging.pageCount > 1}">
        <div class="mt-8 flex items-center justify-center">
          <ul class="flex items-center gap-2">
            <!-- 처음/이전 -->
            <c:if test="${paging.startPage > 10}">
              <c:url var="pageFirst" value="/review_list.bc">
                <c:param name="pageNum" value="1"/>
                <c:param name="pd_id"   value="${pdId}"/>
                <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}"/></c:if>
                <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}"/></c:if>
              </c:url>
              <li><a href="${pageFirst}" class="no-underline px-3 h-9 inline-flex items-center rounded border hover:bg-gray-50">처음</a></li>

              <c:url var="pagePrev" value="/review_list.bc">
                <c:param name="pageNum" value="${paging.prev}"/>
                <c:param name="pd_id"   value="${pdId}"/>
                <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}"/></c:if>
                <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}"/></c:if>
              </c:url>
              <li><a href="${pagePrev}" class="no-underline px-3 h-9 inline-flex items-center rounded border hover:bg-gray-50">이전</a></li>
            </c:if>

            <!-- 번호들 -->
            <c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
              <c:url var="pageNumUrl" value="/review_list.bc">
                <c:param name="pageNum" value="${num}"/>
                <c:param name="pd_id"   value="${pdId}"/>
                <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}"/></c:if>
                <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}"/></c:if>
              </c:url>
              <li>
                <a href="${pageNumUrl}"
                   class="no-underline px-3 h-9 inline-flex items-center rounded border hover:bg-gray-50
                          <c:if test='${num == paging.currentPage}'> !border-primary text-primary</c:if>">
                  ${num}
                </a>
              </li>
            </c:forEach>

            <!-- 다음/끝 -->
            <c:if test="${paging.endPage < paging.pageCount}">
              <c:url var="pageNext" value="/review_list.bc">
                <c:param name="pageNum" value="${paging.next}"/>
                <c:param name="pd_id"   value="${pdId}"/>
                <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}"/></c:if>
                <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}"/></c:if>
              </c:url>
              <li><a href="${pageNext}" class="no-underline px-3 h-9 inline-flex items-center rounded border hover:bg-gray-50">다음</a></li>

              <c:url var="pageLast" value="/review_list.bc">
                <c:param name="pageNum" value="${paging.pageCount}"/>
                <c:param name="pd_id"   value="${pdId}"/>
                <c:if test="${not empty pname}"><c:param name="pd_name" value="${pname}"/></c:if>
                <c:if test="${not empty pimg}"><c:param name="pd_image_url" value="${pimg}"/></c:if>
              </c:url>
              <li><a href="${pageLast}" class="no-underline px-3 h-9 inline-flex items-center rounded border hover:bg-gray-50">끝</a></li>
            </c:if>
          </ul>
        </div>
      </c:if>
    </div>
  </main>

  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
</body>
</html>
