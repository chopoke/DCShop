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

      <!-- 사이드바 -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <!-- 프로필 -->
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>

        <!-- 네비게이션 (수정 금지) -->
        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded bg-gray-900 text-white">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">주문관리</h1>

        <!-- 검색/필터 바 (3줄) -->
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
            <!-- 주문상태 -->
            <div class="md:col-span-6">
              <label class="block text-sm text-gray-600 mb-1">주문상태</label>
              <select name="status" class="w-full border rounded-lg h-10 px-3">
                <option value="">전체</option>
                <option value="PAID"      <c:if test="${param.status=='PAID'}">selected</c:if>>결제완료</option>
                <option value="READY"     <c:if test="${param.status=='READY'}">selected</c:if>>상품준비중</option>
                <option value="SHIPPED"   <c:if test="${param.status=='SHIPPED'}">selected</c:if>>배송중</option>
                <option value="DELIVERED" <c:if test="${param.status=='DELIVERED'}">selected</c:if>>배송완료</option>
                <option value="CANCEL"    <c:if test="${param.status=='CANCEL'}">selected</c:if>>취소</option>
                <option value="REFUND"    <c:if test="${param.status=='REFUND'}">selected</c:if>>환불</option>
              </select>
            </div>

            <!-- 결제수단 -->
            <div class="md:col-span-6">
              <label class="block text-sm text-gray-600 mb-1">결제수단</label>
              <select name="pay_method" class="w-full border rounded-lg h-10 px-3">
                <option value="">전체</option>
                <option value="CARD"     <c:if test="${param.pay_method=='CARD'}">selected</c:if>>카드</option>
                <option value="VIRTUAL"  <c:if test="${param.pay_method=='VIRTUAL'}">selected</c:if>>가상계좌</option>
                <option value="TRANSFER" <c:if test="${param.pay_method=='TRANSFER'}">selected</c:if>>계좌이체</option>
                <option value="KAKAOPAY" <c:if test="${param.pay_method=='KAKAOPAY'}">selected</c:if>>카카오페이</option>
                <option value="NAVERPAY" <c:if test="${param.pay_method=='NAVERPAY'}">selected</c:if>>네이버페이</option>
              </select>
            </div>
          </div>

          <!-- 3번째 줄: 검색 + 버튼 -->
          <div class="grid grid-cols-1 md:grid-cols-12 gap-3">
            <div class="md:col-span-9 flex gap-2">
              <select name="field" class="w-36 border rounded-lg h-10 px-3">
                <option value="order_no" <c:if test="${param.field=='order_no'}">selected</c:if>>주문번호</option>
                <option value="buyer"    <c:if test="${param.field=='buyer'}">selected</c:if>>주문자</option>
                <option value="item"     <c:if test="${param.field=='item'}">selected</c:if>>상품명</option>
              </select>
              <input type="text" name="keyword" value="${fn:escapeXml(param.keyword)}"
                     class="flex-1 border rounded-lg h-10 px-3" placeholder="검색어 입력">
            </div>

            <div class="md:col-span-3 flex gap-2">
              <button type="submit" class="w-full h-10 rounded-lg bg-blue-600 text-white hover:bg-blue-700">검색</button>
            </div>
          </div>
        </form>

        <!-- 상단 액션 바 (엑셀버튼 제거됨) -->
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3 mb-3">
          <div class="text-sm text-gray-500">
            총 <span class="font-semibold text-gray-700">${paging.totalCount}</span>건
          </div>
          <div class="flex gap-2">
            <!-- 일괄 상태 변경 -->
            <form id="bulkStatusForm" action="${path}/admin_order/bulkStatus" method="post" class="flex gap-2">
              <select name="to" class="border rounded-lg h-10 px-3">
                <option value="">상태 일괄변경</option>
                <option value="READY">상품준비중</option>
                <option value="SHIPPED">배송중</option>
                <option value="DELIVERED">배송완료</option>
                <option value="CANCEL">취소</option>
                <option value="REFUND">환불</option>
              </select>
              <input type="hidden" name="order_nos" id="bulkOrderNos">
              <button type="button" id="bulkApplyBtn" class="px-4 h-10 rounded-lg border hover:bg-gray-50">적용</button>
            </form>
          </div>
        </div>

        <!-- 주문 목록 -->
        <div class="bg-white border rounded-xl overflow-hidden">
          <div class="overflow-x-auto">
            <table class="min-w-full table-fixed">
              <colgroup>
                <col style="width:48px;">
                <col style="width:160px;">
                <col style="width:140px;">
                <col style="width:160px;">
                <col style="width:120px;">
                <col style="width:120px;">
                <col style="width:140px;">
                <col style="width:120px;">
              </colgroup>
              <thead class="bg-gray-50 text-sm text-gray-600">
                <tr>
                  <th class="py-3 px-3 text-left">
                    <input type="checkbox" id="checkAll" class="w-4 h-4">
                  </th>
                  <th class="py-3 px-3 text-left">주문번호</th>
                  <th class="py-3 px-3 text-left">주문일시</th>
                  <th class="py-3 px-3 text-left">주문자(ID)</th>
                  <th class="py-3 px-3 text-left">결제수단</th>
                  <th class="py-3 px-3 text-right">결제금액</th>
                  <th class="py-3 px-3 text-left">주문상태</th>
                  <th class="py-3 px-3 text-center">관리</th>
                </tr>
              </thead>
              <tbody class="text-sm divide-y">
                <c:if test="${empty list}">
                  <tr>
                    <td colspan="8" class="py-10 text-center text-gray-500">조회된 주문이 없습니다.</td>
                  </tr>
                </c:if>

                <c:forEach var="o" items="${list}">
                  <tr class="hover:bg-gray-50">
                    <td class="py-3 px-3 align-middle">
                      <input type="checkbox" name="rowCheck" value="${o.order_no}" class="w-4 h-4">
                    </td>

                    <!-- 주문번호 -->
                    <td class="py-3 px-3 align-middle whitespace-nowrap">
                      <a href="${path}/admin_order/detail?order_no=${o.order_no}"
                         class="text-blue-600 hover:underline font-medium truncate inline-block max-w-[150px]">
                        ${o.order_no}
                      </a>
                    </td>

                    <!-- 주문일시 -->
                    <td class="py-3 px-3 align-middle whitespace-nowrap">
                      ${o.order_dt}
                    </td>

                    <!-- 주문자(ID) -->
                    <td class="py-3 px-3 align-middle whitespace-nowrap">
                      <span class="truncate inline-block max-w-[150px]">${o.buyer_name}</span>
                      <span class="text-gray-400 ml-1">(${o.u_id})</span>
                    </td>

                    <!-- 결제수단 -->
                    <td class="py-3 px-3 align-middle whitespace-nowrap">
                      <c:choose>
                        <c:when test="${o.pay_method=='CARD'}">카드</c:when>
                        <c:when test="${o.pay_method=='VIRTUAL'}">가상계좌</c:when>
                        <c:when test="${o.pay_method=='TRANSFER'}">계좌이체</c:when>
                        <c:when test="${o.pay_method=='KAKAOPAY'}">카카오페이</c:when>
                        <c:when test="${o.pay_method=='NAVERPAY'}">네이버페이</c:when>
                        <c:otherwise>-</c:otherwise>
                      </c:choose>
                    </td>

                    <!-- 결제금액 -->
                    <td class="py-3 px-3 align-middle text-right whitespace-nowrap">
                      <fmt:formatNumber value="${o.total_amount}" type="number"/>원
                    </td>

                    <!-- 상태 배지 -->
                    <td class="py-3 px-3 align-middle whitespace-nowrap">
                      <c:set var="badge" value="bg-gray-100 text-gray-700"/>
                      <c:choose>
                        <c:when test="${o.status=='PAID'}"><c:set var="badge" value="bg-blue-100 text-blue-700"/></c:when>
                        <c:when test="${o.status=='READY'}"><c:set var="badge" value="bg-amber-100 text-amber-700"/></c:when>
                        <c:when test="${o.status=='SHIPPED'}"><c:set var="badge" value="bg-violet-100 text-violet-700"/></c:when>
                        <c:when test="${o.status=='DELIVERED'}"><c:set var="badge" value="bg-emerald-100 text-emerald-700"/></c:when>
                        <c:when test="${o.status=='CANCEL'}"><c:set var="badge" value="bg-rose-100 text-rose-700"/></c:when>
                        <c:when test="${o.status=='REFUND'}"><c:set var="badge" value="bg-slate-200 text-slate-700"/></c:when>
                      </c:choose>
                      <span class="px-2 py-1 text-xs rounded-full ${badge}">
                        <c:out value="${o.status_name != null ? o.status_name : o.status}"/>
                      </span>
                    </td>

                    <!-- 관리 -->
                    <td class="py-3 px-3 align-middle text-center">
                      <a href="${path}/admin_order/detail?order_no=${o.order_no}"
                         class="inline-block px-3 py-1 rounded-lg border hover:bg-gray-50">상세</a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 페이징 -->
        <div class="mt-6 flex items-center justify-center gap-1">
          <c:if test="${paging.prev}">
            <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
               href="${path}/admin_order?pageNum=${paging.startPage-1}&${pageQuery}">&laquo;</a>
          </c:if>

          <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
            <c:choose>
              <c:when test="${i==paging.pageNum}">
                <span class="px-3 py-2 rounded-lg bg-blue-600 text-white">${i}</span>
              </c:when>
              <c:otherwise>
                <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
                   href="${path}/admin_order?pageNum=${i}&${pageQuery}">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>

          <c:if test="${paging.next}">
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

  <!-- 스크립트 (체크박스 전체선택 + 일괄변경) -->
  <script>
    // 전체 선택 토글
    const checkAll = document.getElementById('checkAll');
    const rowChecks = () => Array.from(document.querySelectorAll('input[name="rowCheck"]'));
    if (checkAll) {
      checkAll.addEventListener('change', (e) => {
        rowChecks().forEach(cb => cb.checked = e.target.checked);
      });
    }

    // 일괄 상태 변경
    const bulkBtn  = document.getElementById('bulkApplyBtn');
    const bulkNos  = document.getElementById('bulkOrderNos');
    const bulkForm = document.getElementById('bulkStatusForm');

    if (bulkBtn && bulkNos && bulkForm) {
      bulkBtn.addEventListener('click', () => {
        const selected = rowChecks().filter(cb => cb.checked).map(cb => cb.value);
        if (selected.length === 0) {
          alert('선택된 주문이 없습니다.');
          return;
        }
        const to = bulkForm.querySelector('select[name="to"]').value;
        if (!to) {
          alert('변경할 상태를 선택하세요.');
          return;
        }
        bulkNos.value = selected.join(',');
        bulkForm.submit();
      });
    }
  </script>
</body>
</html>
