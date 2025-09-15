<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Page - 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style type="text/css">
    .hero-section1 {
      width: 100%;
      background: white;
      padding: .5rem 0;
      padding-top: 5rem;
    }
    /* 셀 가로 스크롤 + 테이블 고정 레이아웃 */
    .fixed-table {
      width: 1000px;
      table-layout: fixed;
      border-collapse: collapse;
      white-space: nowrap;
    }
    .fixed-table td, .fixed-table th {
      border: 1px solid #eee;
      padding: 8px;
      vertical-align: middle;
    }
    .cell-scroll {
      max-width: 100%;
      white-space: nowrap;
      overflow-x: auto;
      overflow-y: hidden;
      -webkit-overflow-scrolling: touch;
    }
    .cell-scroll::-webkit-scrollbar { height: 6px; }
  </style>
</head>
<body class="bg-gray-100">

  <!-- 헤더 시작 -->
  <%@ include file="../setting/header.jsp" %>
  <!-- 헤더 끝 -->

  <section class="hero-section1"></section>

  <!-- 전체 컨테이너 -->
  <div class="min-h-screen flex justify-center py-8">
    <!-- 메인 래퍼 -->
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 (수정 금지) -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>

        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded bg-gray-900 text-white">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout.do" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 (★ min-w-0 유지) -->
      <main class="flex-1 min-w-0 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">주문관리</h1>

        <!-- 검색/필터 바 -->
        <form id="searchForm" action="${path}/admin_order" method="get" class="bg-white border rounded-xl p-4 mb-6">
          <!-- 1번째 줄: 주문기간 -->
          <div class="grid grid-cols-1 md:grid-cols-12 gap-3 mb-4">
            <div class="md:col-span-6">
              <label class="block text-sm text-gray-600 mb-1">주문기간</label>
              <div class="flex gap-2">
                <input type="date" name="from" value="${param.from}" class="w-full border rounded-lg h-10 px-3">
                <span class="self-center text-gray-400">~</span>
                <input type="date" name="to" value="${param.to}" class="w-full border rounded-lg h-10 px-3">
              </div>
            </div>
          </div>

          <!-- 2번째 줄: 주문상태 + 결제수단 -->
          <div class="grid grid-cols-1 md:grid-cols-12 gap-3 mb-4">
            <div class="md:col-span-6">
              <label class="block text-sm text-gray-600 mb-1">주문상태</label>
              <select name="o_status" class="w-full border rounded-lg h-10 px-3">
                <option value="">전체</option>
                <option value="주문완료"  <c:if test="${param.o_status=='주문완료'}">selected</c:if>>주문완료</option>
                <option value="환불"      <c:if test="${param.o_status=='환불'}">selected</c:if>>환불</option>
                <option value="반품진행"  <c:if test="${param.o_status=='반품진행'}">selected</c:if>>반품진행</option>
                <option value="교환진행"  <c:if test="${param.o_status=='교환진행'}">selected</c:if>>교환진행</option>
              </select>
            </div>

            <div class="md:col-span-6">
              <label class="block text-sm text-gray-600 mb-1">결제수단</label>
              <select name="o_payment" class="w-full border rounded-lg h-10 px-3">
                <option value="">전체</option>
                <option value="카드"       <c:if test="${param.o_payment=='카드'}">selected</c:if>>카드</option>
                <option value="네이버페이" <c:if test="${param.o_payment=='네이버페이'}">selected</c:if>>네이버페이</option>
                <option value="카카오페이" <c:if test="${param.o_payment=='카카오페이'}">selected</c:if>>카카오페이</option>
              </select>
            </div>
          </div>

          <!-- 3번째 줄: 검색필드 + 검색어 -->
          <div class="grid grid-cols-1 md:grid-cols-12 gap-3">
            <div class="md:col-span-9 flex gap-2">
              <select name="field" class="w-36 border rounded-lg h-10 px-3">
                <option value="o_num"  <c:if test="${param.field=='o_num'}">selected</c:if>>주문번호(o_num)</option>
                <option value="o_name" <c:if test="${param.field=='o_name'}">selected</c:if>>주문자명(o_name)</option>
                <option value="pd_id"  <c:if test="${param.field=='pd_id'}">selected</c:if>>상품ID(pd_id)</option>
              </select>
              <input type="text" name="keyword" value="${fn:escapeXml(param.keyword)}"
                     class="flex-1 border rounded-lg h-10 px-3" placeholder="값 입력">
            </div>

            <div class="md:col-span-3 flex gap-2">
              <button type="submit" class="w-full h-10 rounded-lg bg-black text-white hover:bg-blue-700">검색</button>
            </div>
          </div>
        </form>

        <!-- 상단 정보 바 -->
        <div class="flex items-center justify-between gap-3 mb-3">
          <div class="text-sm text-gray-500">
            총 <span class="font-semibold text-gray-700">${paging.totalCount}</span>건
          </div>
          <div></div>
        </div>

        <!-- 주문 목록 -->
        <div class="bg-white border rounded-xl overflow-hidden">
          <div class="overflow-x-auto">
            <table class="fixed-table">
              <colgroup>
                <col style="width:100px;">  <!-- 배송상태 -->
                <col style="width:100px;">  <!-- 주문상태 -->
                <col style="width:200px;">  <!-- 주문번호(링크) -->
                <col style="width:140px;">  <!-- 주문일시 -->
                <col style="width:160px;">  <!-- 주문자(회원번호) -->
                <col style="width:120px;">  <!-- 결제수단 -->
                <col style="width:120px;">  <!-- 결제금액 -->
              </colgroup>
              <thead class="bg-gray-50 text-sm text-gray-600">
                <tr>
                  <th class="py-3 px-3 text-left">배송상태</th>
                  <th class="py-3 px-3 text-left">주문상태</th>
                  <th class="py-3 px-3 text-left">주문번호</th>
                  <th class="py-3 px-3 text-left">주문일시</th>
                  <th class="py-3 px-3 text-left">주문자(회원번호)</th>
                  <th class="py-3 px-3 text-left">결제수단</th>
                  <th class="py-3 px-3 text-right">결제금액</th>
                </tr>
              </thead>
              <tbody class="text-sm divide-y">
                <c:if test="${empty list}">
                  <tr>
                    <td colspan="7" class="py-10 text-center text-gray-500">조회된 주문이 없습니다.</td>
                  </tr>
                </c:if>

                <c:forEach var="o" items="${list}">
                  <tr class="hover:bg-gray-50">
                    <!-- 배송상태 -->
                    <td class="py-3 px-3 align-middle">
                      <c:set var="shipBadge" value="bg-gray-100 text-gray-700"/>
                      <c:choose>
                        <c:when test="${o.o_delivery_state=='배송중'}"><c:set var="shipBadge" value="bg-violet-100 text-violet-700"/></c:when>
                        <c:when test="${o.o_delivery_state=='배송완료'}"><c:set var="shipBadge" value="bg-emerald-100 text-emerald-700"/></c:when>
                      </c:choose>
                      <span class="px-2 py-1 text-xs rounded-full ${shipBadge}">
                        ${o.o_delivery_state}
                      </span>
                    </td>

                    <!-- 주문상태 -->
                    <td class="py-3 px-3 align-middle">
                      <c:set var="ordBadge" value="bg-gray-100 text-gray-700"/>
                      <c:choose>
                        <c:when test="${o.o_status=='주문완료'}"><c:set var="ordBadge" value="bg-blue-100 text-blue-700"/></c:when>
                        <c:when test="${o.o_status=='환불'}"><c:set var="ordBadge" value="bg-rose-100 text-rose-700"/></c:when>
                        <c:when test="${o.o_status=='반품진행'}"><c:set var="ordBadge" value="bg-amber-100 text-amber-700"/></c:when>
                        <c:when test="${o.o_status=='교환진행'}"><c:set var="ordBadge" value="bg-slate-200 text-slate-700"/></c:when>
                      </c:choose>
                      <span class="px-2 py-1 text-xs rounded-full ${ordBadge}">
                        ${o.o_status}
                      </span>
                    </td>

                    <!-- 주문번호(링크) — 표시: o_num만 / 전송: o_num + pd_id -->
                    <td class="py-3 px-3 align-middle">
                      <div class="cell-scroll">
                        <a href="${path}/admin_order_detail?o_num=${o.o_num}<c:if test='${not empty o.pd_id}'>&amp;pd_id=${o.pd_id}</c:if>" class="text-blue-600 hover:underline font-medium">
						  #${o.o_num}
						</a>
                      </div>
                    </td>

                    <!-- 주문일시 -->
                    <td class="py-3 px-3 align-middle">
                      <div class="cell-scroll">
                        <fmt:formatDate value="${o.o_date}" pattern="yyyy-MM-dd"/>
                      </div>
                    </td>

                    <!-- 주문자(회원번호) -->
                    <td class="py-3 px-3 align-middle">
                      <div class="cell-scroll">
                        ${o.o_name} <span class="text-gray-400">(${o.u_member_id})</span>
                      </div>
                    </td>

                    <!-- 결제수단 -->
                    <td class="py-3 px-3 align-middle">
                      <div class="cell-scroll">
                        <c:out value="${o.o_payment}"/>
                      </div>
                    </td>

                    <!-- 결제금액 -->
                    <td class="py-3 px-3 align-middle text-right">
                      <div class="cell-scroll">
                        <fmt:formatNumber value="${o.o_price}" type="number"/>원
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 페이징 -->
        <div class="mt-6 flex items-center justify-center gap-1">
          <c:if test="${paging.prev gt 0}">
            <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
               href="${path}/admin_order?pageNum=${paging.startPage-1}&${pageQuery}">&laquo;</a>
          </c:if>

          <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
            <c:choose>
              <c:when test="${i eq paging.currentPage}">
                <span class="px-3 py-2 rounded-lg bg-blue-600 text-white">${i}</span>
              </c:when>
              <c:otherwise>
                <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
                   href="${path}/admin_order?pageNum=${i}&${pageQuery}">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>

          <c:if test="${paging.next gt 0}">
            <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
               href="${path}/admin_order?pageNum=${paging.endPage+1}&${pageQuery}">&raquo;</a>
          </c:if>
        </div>
      </main>
    </div>
  </div>

  <!-- 푸터 시작 -->
  <%@ include file="../setting/footer.jsp" %>
  <!-- 푸터 끝 -->

</body>
</html>
