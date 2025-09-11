<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>상품관리 - 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style>
    .hero-section1{width:100%;background:white;padding:.5rem 0;padding-top:5rem}
    .table-scroll { max-height: 60vh; overflow: auto; }
    @media (min-height: 900px) { .table-scroll { max-height: 70vh; } }
  </style>
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>

  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <img src="${path}/resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <a href="${path}/mypage/profile" class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</a>

        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded bg-gray-900 text-white">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-2">상품관리</h1><br>
        

        <section class="bg-white border rounded-xl shadow-sm">
          <div class="p-4">
			<p class="text-gray-500 mb-6">상품을 검색하고 상태를 일괄 변경하거나 등록/수정/삭제할 수 있습니다.</p>
            <!-- 검색줄 -->
            <form action="${path}/admin_product" method="get" class="flex gap-2 w-full mb-3 flex-wrap">
              <!-- 상태 필터 -->
              <select name="status" class="w-36 border rounded-lg px-3 py-2">
                <option value="">상태 전체</option>
                <option value="ON"   ${param_status == 'ON'   ? 'selected' : ''}>판매중</option>
                <option value="OFF"  ${param_status == 'OFF'  ? 'selected' : ''}>품절</option>
                <option value="WAIT" ${param_status == 'WAIT' ? 'selected' : ''}>재입고대기</option>
              </select>

              <!-- 카테고리 필터 -->
              <select name="category" class="w-72 border rounded-lg px-3 py-2">
                <option value="">카테고리 전체</option>
                <optgroup label="강아지">
                  <option value="1100" ${param_category=='1100'?'selected':''}>의류</option>
                  <option value="1200" ${param_category=='1200'?'selected':''}>미용/위생</option>
                  <option value="1300" ${param_category=='1300'?'selected':''}>화장실</option>
                  <option value="1400" ${param_category=='1400'?'selected':''}>장난감</option>
                  <option value="1500" ${param_category=='1500'?'selected':''}>목줄/리드줄</option>
                </optgroup>
                <optgroup label="고양이">
                  <option value="2100" ${param_category=='2100'?'selected':''}>의류</option>
                  <option value="2200" ${param_category=='2200'?'selected':''}>미용/위생</option>
                  <option value="2300" ${param_category=='2300'?'selected':''}>모래</option>
                  <option value="2400" ${param_category=='2400'?'selected':''}>장난감</option>
                  <option value="2500" ${param_category=='2500'?'selected':''}>스크래쳐</option>
                </optgroup>
              </select>

              <!-- 검색창 -->
              <input type="text" name="q" value="${fn:escapeXml(param_q)}" placeholder="상품명/브랜드 검색" class="flex-1 md:w-72 border rounded-lg px-3 py-2" />
              <button type="submit" class="px-4 py-2 bg-gray-800 text-white rounded-lg hover:bg-black">검색</button>
            </form>

            <!-- 버튼 줄 -->
            <div class="flex flex-wrap gap-2 mb-3">
              <form id="bulkOffForm"  action="${path}/admin_product_status" method="post">
                <input type="hidden" name="to" value="OFF" />
                <button type="button" id="bulkOffBtn" class="px-3 py-2 border rounded-lg hover:bg-gray-50">품절</button>
              </form>

              <form id="bulkOnForm"   action="${path}/admin_product_status" method="post">
                <input type="hidden" name="to" value="ON" />
                <button type="button" id="bulkOnBtn" class="px-3 py-2 border rounded-lg hover:bg-gray-50">판매중</button>
              </form>

              <form id="bulkWaitForm" action="${path}/admin_product_status" method="post">
                <input type="hidden" name="to" value="WAIT" />
                <button type="button" id="bulkWaitBtn" class="px-3 py-2 border rounded-lg hover:bg-gray-50">재입고대기</button>
              </form>

              <!-- 선택 삭제 -->
              <form id="bulkDelForm"  action="${path}/admin_product_delete" method="post">
                <button type="button" id="bulkDelBtn" class="px-3 py-2 border rounded-lg text-red-600 hover:bg-red-50">삭제</button>
              </form>

              <!-- 상품등록 버튼 -->
              <a href="${path}/admin_product_insert" class="inline-flex items-center justify-center h-10 px-4 py-0 rounded-lg border bg-blue-600 text-white hover:bg-blue-700 no-underline align-middle">상품등록</a>

              <!-- 상품수정 버튼 (체크된 1건 수정) -->
              <button type="button" id="bulkEditBtn" class="inline-flex items-center justify-center h-10 px-4 py-0 rounded-lg border bg-yellow-600 text-white hover:bg-yellow-700 align-middle">상품수정</button>
            </div>
          </div>
        </section>

        <!-- 리스트 -->
        <section class="mt-4 bg-white border rounded-xl shadow-sm">
          <div class="table-scroll">
            <table class="min-w-full text-sm">
              <thead class="bg-gray-50 sticky top-0 z-10">
                <tr class="text-left text-gray-600">
                  <th class="px-4 py-3 w-10"><input id="checkAll" type="checkbox" class="accent-gray-800" /></th>
                  <th class="px-4 py-3 w-28">썸네일</th>
                  <th class="px-4 py-3 w-36 whitespace-nowrap">상품번호</th>
                  <th class="px-4 py-3 text-center whitespace-nowrap">상품명</th>
                  <th class="px-4 py-3 w-28 text-right whitespace-nowrap">가격</th>
                  <th class="px-4 py-3 w-24 text-right whitespace-nowrap">재고</th>
                  <th class="px-4 py-3 w-28 text-center whitespace-nowrap">상태</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${empty list}">
                    <tr>
                      <td colspan="7" class="px-4 py-10 text-center text-gray-400">등록된 상품이 없습니다.</td>
                    </tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="p" items="${list}">
                      <tr class="border-t hover:bg-gray-50">
                        <td class="px-4 py-3">
                          <input name="rowCheck" value="${p.pd_id}" type="checkbox" class="rowCheck accent-gray-800" />
                        </td>

                        <!-- 썸네일: 내부/외부 URL 모두 안전 처리 -->
                        <td class="px-4 py-3">
                          <c:choose>
                            <c:when test="${not empty p.pd_image_url}">
                              <c:set var="__raw" value="${p.pd_image_url}" />
                              <c:choose>
                                <c:when test="${fn:startsWith(__raw,'http://') or fn:startsWith(__raw,'https://') or fn:startsWith(__raw,'//')}">
                                  <c:set var="__img" value="${__raw}" />
                                </c:when>
                                <c:otherwise>
                                  <c:choose>
                                    <c:when test="${fn:startsWith(__raw,'/')}">
                                      <c:url var="__img" value="${__raw}" />
                                    </c:when>
                                    <c:otherwise>
                                      <c:url var="__img" value="/${__raw}" />
                                    </c:otherwise>
                                  </c:choose>
                                </c:otherwise>
                              </c:choose>
                              <img src="${__img}" alt="thumb" class="w-14 h-14 object-cover rounded"
                                   onerror="this.src='${path}/resources/img_main/mypage_default.png'"/>
                            </c:when>
                            <c:otherwise>
                              <div class="w-14 h-14 bg-gray-100 border rounded grid place-items-center">-</div>
                            </c:otherwise>
                          </c:choose>
                        </td>

                        <!-- 상품번호 -->
                        <td class="px-4 py-3 text-gray-600 whitespace-nowrap">${p.pd_id}</td>

                        <!-- 상품명 + 보조정보: 브랜드 -->
                        <td class="px-4 py-3 text-center whitespace-nowrap">
                          <a href="${path}/ad_shop_detailAction.pd?pdId=${p.pd_id}" class="text-gray-900 hover:underline font-medium">${p.pd_name}</a>
                          <div class="text-xs text-gray-400">${p.pd_brand}</div>
                        </td>

                        <!-- 가격 -->
                        <td class="px-4 py-3 text-right whitespace-nowrap">
                          <fmt:formatNumber value="${p.pd_price}" type="currency" currencySymbol="₩" />
                        </td>

                        <!-- 재고 -->
                        <td class="px-4 py-3 text-right whitespace-nowrap">${p.pd_stock}</td>

                        <!-- 상태 (ON/OFF/WAIT) -->
                        <td class="px-4 py-3 text-center whitespace-nowrap">
                          <c:set var="__st" value="${p.pd_status}" />
                          <c:choose>
                            <c:when test="${__st == 'ON'}">
                              <span class="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs bg-green-50 text-green-700 border border-green-200">판매중</span>
                            </c:when>
                            <c:when test="${__st == 'WAIT'}">
                              <span class="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs bg-yellow-50 text-yellow-700 border border-yellow-200">재입고대기</span>
                            </c:when>
                            <c:otherwise>
                              <span class="inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs bg-gray-100 text-gray-500 border border-gray-200">품절</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>

          <!-- 페이징 -->
          <c:if test="${paging.pageCount > 1}">
            <div class="p-4 border-t bg-white">
              <div class="flex items-center justify-between gap-4 flex-wrap">
                <!-- 좌측: 현재/전체 페이지 -->
                <div class="text-sm text-gray-500">
                  페이지 ${paging.currentPage} / ${paging.pageCount}
                </div>

                <!-- 우측: 페이지 버튼 -->
                <ul class="inline-flex items-center gap-1">
                  <!-- 이전 블록 -->
                  <c:if test="${paging.startPage > 10}">
                    <c:url var="prevUrl" value="/admin_product">
                      <c:param name="pageNum" value="${paging.prev}" />
                      <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}" /></c:if>
                      <c:if test="${not empty param_category}"><c:param name="category" value="${param_category}" /></c:if>
                      <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}" /></c:if>
                    </c:url>
                    <li><a href="${prevUrl}" class="px-3 py-2 rounded-lg border hover:bg-gray-50 text-gray-700">이전</a></li>
                  </c:if>

                  <!-- 번호들 -->
                  <c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
                    <c:url var="numUrl" value="/admin_product">
                      <c:param name="pageNum" value="${num}" />
                      <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}" /></c:if>
                      <c:if test="${not empty param_category}"><c:param name="category" value="${param_category}" /></c:if>
                      <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}" /></c:if>
                    </c:url>
                    <li>
                      <a href="${numUrl}"
                         class="px-3 py-2 rounded-lg border
                         ${num == paging.currentPage ? 'bg-gray-900 text-white border-gray-900' : 'hover:bg-gray-50 text-gray-700'}">
                        ${num}
                      </a>
                    </li>
                  </c:forEach>

                  <!-- 다음 블록 -->
                  <c:if test="${paging.endPage < paging.pageCount}">
                    <c:url var="nextUrl" value="/admin_product">
                      <c:param name="pageNum" value="${paging.next}" />
                      <c:if test="${not empty param_status}"><c:param name="status" value="${param_status}" /></c:if>
                      <c:if test="${not empty param_category}"><c:param name="category" value="${param_category}" /></c:if>
                      <c:if test="${not empty param_q}"><c:param name="q" value="${param_q}" /></c:if>
                    </c:url>
                    <li><a href="${nextUrl}" class="px-3 py-2 rounded-lg border hover:bg-gray-50 text-gray-700">다음</a></li>
                  </c:if>
                </ul>
              </div>
            </div>
          </c:if>
        </section>
      </main>
    </div>
  </div>

  <%@ include file="../setting/footer.jsp" %>

  <script>
    const checkAll = document.getElementById('checkAll');
    const rowChecks = () => Array.from(document.querySelectorAll('.rowCheck'));
    if (checkAll) {
      checkAll.addEventListener('change', () => {
        rowChecks().forEach(chk => chk.checked = checkAll.checked);
      });
    }
    function collectIds() {
      return rowChecks().filter(chk => chk.checked).map(chk => chk.value);
    }
    function submitBulk(formId) {
      const ids = collectIds();
      if (ids.length === 0) { alert('선택된 상품이 없습니다.'); return; }
      const form = document.getElementById(formId);
      const hidden = document.createElement('input');
      hidden.type = 'hidden';
      hidden.name = 'ids';
      hidden.value = ids.join(',');
      form.appendChild(hidden);
      form.submit();
    }
    document.getElementById('bulkOffBtn')?.addEventListener('click', () => submitBulk('bulkOffForm'));
    document.getElementById('bulkOnBtn')?.addEventListener('click', () => submitBulk('bulkOnForm'));
    document.getElementById('bulkWaitBtn')?.addEventListener('click', () => submitBulk('bulkWaitForm'));
    document.getElementById('bulkDelBtn')?.addEventListener('click', () => {
      if (confirm('선택한 상품을 삭제하시겠습니까?')) submitBulk('bulkDelForm');
    });

    // 선택 1건 수정 이동
    document.getElementById('bulkEditBtn')?.addEventListener('click', () => {
      const ids = collectIds();
      if (ids.length === 0) { alert('수정할 상품을 선택하세요.'); return; }
      if (ids.length > 1)   { alert('수정은 한 건만 가능합니다. 하나만 선택하세요.'); return; }
      location.href = '${path}/admin_product_update?pd_id=' + ids[0];
    });
  </script>

</body>
</html>
