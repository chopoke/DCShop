<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin - 주문 상세 | 독캣배송</title>

<!-- Tailwind -->
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<!-- Remix Icon -->
<link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet" />

<style>
.hero-section1{width:100%;background:white;padding:.5rem 0;padding-top:5rem}
.custom-scrollbar::-webkit-scrollbar{width:6px;height:6px}
.custom-scrollbar::-webkit-scrollbar-track{background:#f1f1f1;border-radius:3px}
.custom-scrollbar::-webkit-scrollbar-thumb{background:#c1c1c1;border-radius:3px}
.custom-scrollbar::-webkit-scrollbar-thumb:hover{background:#a8a8a8}
</style>

<script>
tailwind.config = {
  theme: {
    extend: {
      colors: { primary: "#0066FF", secondary: "#6B7280" },
      borderRadius: { none:"0px", sm:"4px", DEFAULT:"8px", md:"12px", lg:"0.5rem", xl:"20px", "2xl":"24px", "3xl":"32px", full:"9999px", button:"8px" }
    }
  }
};
</script>
</head>

<body class="bg-gray-100">
  <%@ include file="../setting/header.jsp"%>
  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <img src="${path}/resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <!-- <button class="px-4 py-2 bg-stone-950 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button> -->

        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded bg-gray-900 text-white">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout"        class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 -->
      <main class="max-w-7xl mx-auto p-6 flex-1">
        <div class="flex items-center justify-between mb-6">
          <h1 class="text-2xl font-bold text-gray-900">주문 상세 (관리자)</h1>
          <a href="${path}/admin_order" class="px-4 py-2 text-sm text-gray-600 hover:text-gray-900 flex items-center gap-2 !rounded-button">
            <i class="ri-arrow-left-line"></i> 목록으로
          </a>
        </div>

        <c:if test="${empty info}">
          <div class="p-6 mb-6 rounded-lg border bg-amber-50 text-amber-800">
            주문 정보를 찾을 수 없습니다. 목록에서 다시 선택해 주세요.
          </div>
        </c:if>

        <c:if test="${not empty info}">
          <!-- 주문 기본정보 -->
          <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
            <div class="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between mb-6">
              <div>
                <div class="text-sm text-gray-500">주문번호</div>
                <div class="text-lg font-medium" id="orderNo">${o_num}</div>
              </div>

              <div class="flex items-center gap-3">
                <!-- 주문상태 뱃지 -->
                <span id="statusBadge" class="px-3 py-1 rounded-full text-sm">
                  <c:out value="${info.o_status}" />
                </span>

                <!-- 주문상태 변경 -->
                <div class="relative">
                  <button id="statusBtn" type="button" class="px-3 py-2 text-sm bg-stone-500 text-white rounded-md hover:bg-stone-400">
                    주문상태 변경
                  </button>
                  <div id="statusMenu" class="hidden absolute right-0 mt-2 w-44 bg-white border border-gray-200 rounded-md shadow-lg z-20">
                    <button data-status="주문완료"  class="w-full text-left px-3 py-2 hover:bg-gray-50 text-sm">주문완료</button>
                    <button data-status="환불"      class="w-full text-left px-3 py-2 hover:bg-gray-50 text-sm">환불</button>
                    <button data-status="반품진행"  class="w-full text-left px-3 py-2 hover:bg-gray-50 text-sm">반품진행</button>
                    <button data-status="교환진행"  class="w-full text-left px-3 py-2 hover:bg-gray-50 text-sm">교환진행</button>
                  </div>
                </div>

                <!-- 주문상태 변경 폼 -->
                <form id="statusForm" method="post" action="${path}/admin_order_status" class="hidden">
                  <input type="hidden" name="o_num"      id="formOrderNum"  value="${o_num}">
                  <input type="hidden" name="new_status" id="formNewStatus" value="">
                  <c:if test="${not empty _csrf}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                  </c:if>
                </form>
              </div>
            </div>

            <!-- 배송상태 뱃지용 클래스 계산 -->
            <c:set var="deliveryClass" value="bg-gray-300 text-black"/>
            <c:if test="${info.o_delivery_state eq '배송중'}">
              <c:set var="deliveryClass" value="bg-blue-500 text-white"/>
            </c:if>
            <c:if test="${info.o_delivery_state eq '배송완료'}">
              <c:set var="deliveryClass" value="bg-green-600 text-white"/>
            </c:if>

            <!-- 주문자/배송정보 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <h3 class="text-sm font-medium text-gray-900 mb-4">주문자 정보</h3>
                <div class="space-y-3">
                  <div class="flex"><span class="w-28 text-sm text-gray-500">주문자</span><span class="text-sm"><c:out value="${info.o_name}" /></span></div>
                  <div class="flex"><span class="w-28 text-sm text-gray-500">회원번호</span><span class="text-sm"><c:out value="${info.u_member_id}" /></span></div>
                  <div class="flex"><span class="w-28 text-sm text-gray-500">연락처</span><span class="text-sm"><c:out value="${info.o_phone}" /></span></div>
                  <div class="flex"><span class="w-28 text-sm text-gray-500">주문일시</span>
                    <span class="text-sm"><fmt:formatDate value="${info.o_date}" pattern="yyyy-MM-dd HH:mm" /></span>
                  </div>
                </div>
              </div>

              <div>
                <h3 class="text-sm font-medium text-gray-900 mb-4">배송 정보</h3>
                <div class="space-y-3">
                  <div class="flex items-center gap-2">
                    <span class="w-28 text-sm text-gray-500">배송상태</span>
                    <span class="text-sm">
                      <span id="deliveryBadge" class="px-2 py-1 rounded-full text-xs ${deliveryClass}">
                        <c:out value="${info.o_delivery_state}" />
                      </span>
                    </span>

                    <!-- 배송상태 변경 드롭다운 (주문상태 버튼 아래 요구사항) -->
                    <div class="relative">
                      <button id="shipBtn" type="button" class="px-3 py-1.5 text-xs bg-gray-900 text-white rounded-md hover:bg-gray-800">
                        배송상태 변경
                      </button>
                      <div id="shipMenu" class="hidden absolute left-0 mt-2 w-36 bg-white border border-gray-200 rounded-md shadow-lg z-20">
                        <button data-ship="배송준비" class="w-full text-left px-3 py-2 hover:bg-gray-50 text-xs">배송준비</button>
                        <button data-ship="배송중"   class="w-full text-left px-3 py-2 hover:bg-gray-50 text-xs">배송중</button>
                        <button data-ship="배송완료" class="w-full text-left px-3 py-2 hover:bg-gray-50 text-xs">배송완료</button>
                      </div>
                    </div>

                    <!-- 배송상태 변경 폼 -->
                    <form id="shipForm" method="post" action="${path}/admin_order_delivery" class="hidden">
                      <input type="hidden" name="o_num"     id="shipOrderNum"     value="${o_num}">
                      <input type="hidden" name="new_state" id="formNewShipState" value="">
                      <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                      </c:if>
                    </form>
                    <!-- ▲ 배송상태 변경 -->
                  </div>

                  <div class="flex"><span class="w-28 text-sm text-gray-500">배송주소</span><span class="text-sm"><c:out value="${info.recv_addr}" /></span></div>
                  <div class="flex"><span class="w-28 text-sm text-gray-500">우편번호</span><span class="text-sm"><c:out value="${info.o_zip_code}" /></span></div>
                  <div class="flex">
                    <span class="w-28 text-sm text-gray-500">배송요청</span>
                    <span class="text-sm">
                      <c:choose>
                        <c:when test="${empty info.recv_request}">-</c:when>
                        <c:otherwise><c:out value="${info.recv_request}" /></c:otherwise>
                      </c:choose>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 상품 정보 -->
          <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
            <h3 class="text-sm font-medium text-gray-900 mb-4">상품 정보</h3>
            <div class="border rounded-lg overflow-hidden">
              <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                  <tr>
                    <th class="px-6 py-3 text-left  text-xs font-medium text-gray-500 uppercase">상품정보</th>
                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">수량</th>
                    <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">주문금액</th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                  <c:if test="${empty items}">
                    <tr>
                      <td colspan="3" class="px-6 py-8 text-center text-gray-500">상품 내역이 없습니다.</td>
                    </tr>
                  </c:if>

                  <c:forEach var="it" items="${items}">
                    <tr>
                      <td class="px-6 py-4">
                        <div class="flex items-center">
                          <div class="h-16 w-16 flex-shrink-0 rounded-lg bg-gray-100 overflow-hidden">
                            <c:if test="${not empty it.pd_image_url}">
                              <img alt="" src="${it.pd_image_url}" class="w-full h-full object-cover">
                            </c:if>
                          </div>
                          <div class="ml-4">
                            <div class="text-sm font-medium text-gray-900"><c:out value="${it.pd_name}" /></div>
                            <div class="text-xs text-gray-500">PD_ID: <c:out value="${it.pd_id}" /></div>
                          </div>
                        </div>
                      </td>
                      <td class="px-6 py-4 text-sm text-gray-700 text-center"><c:out value="${it.qty}" />개</td>
                      <td class="px-6 py-4 text-sm text-gray-900 text-right"><fmt:formatNumber value="${it.price}" type="number" />원</td>
                    </tr>
                  </c:forEach>
                </tbody>
                <tfoot class="bg-gray-50">
                  <tr>
                    <td colspan="2" class="px-6 py-4 text-sm text-gray-500 text-right">총 결제금액</td>
                    <td class="px-6 py-4 text-right">
                      <span class="text-lg font-bold text-black">
                        <fmt:formatNumber value="${info.o_price}" type="number" />원
                      </span>
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>

          <!-- 결제 정보 -->
          <div class="bg-white rounded-lg shadow-sm p-6">
            <h3 class="text-sm font-medium text-gray-900 mb-4">결제 정보</h3>
            <div class="space-y-3">
              <div class="flex justify-between"><span class="text-sm text-gray-500">결제방법</span><span class="text-sm"><c:out value="${info.o_payment}" /></span></div>
              <div class="flex justify-between">
                <span class="text-sm text-gray-500">결제일시</span>
                <span class="text-sm">
                  <c:choose>
                    <c:when test="${not empty info.o_date}">
                      <fmt:formatDate value="${info.o_date}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </span>
              </div>
              <div class="flex justify-between"><span class="text-sm text-gray-500">결제번호</span><span class="text-sm"><c:out value="${info.o_pay_no}" /></span></div>
            </div>
          </div>
        </c:if>
      </main>

    </div>
  </div>

  <%@ include file="../setting/footer.jsp"%>

  <script>
    const orderNoEl       = document.getElementById('orderNo');

    // 주문상태(주문완료/환불/반품진행/교환진행)
    const statusBadge     = document.getElementById('statusBadge');
    const statusBtn       = document.getElementById('statusBtn');
    const statusMenu      = document.getElementById('statusMenu');
    const statusForm      = document.getElementById('statusForm');
    const formOrderNum    = document.getElementById('formOrderNum');
    const formNewStatus   = document.getElementById('formNewStatus');

    // 배송상태(배송준비/배송중/배송완료)
    const deliveryBadge   = document.getElementById('deliveryBadge');
    const shipBtn         = document.getElementById('shipBtn');
    const shipMenu        = document.getElementById('shipMenu');
    const shipForm        = document.getElementById('shipForm');
    const shipOrderNum    = document.getElementById('shipOrderNum');
    const formNewShipState= document.getElementById('formNewShipState');

    function applyBadgeStyle(statusText){
      statusBadge.className = 'px-3 py-1 rounded-full text-sm';
      const map = {
        '주문완료':'bg-gray-800 text-white',
        '환불':'bg-rose-100 text-rose-700',
        '반품진행':'bg-amber-100 text-amber-700',
        '교환진행':'bg-slate-200 text-slate-700'
      };
      const cls = map[statusText] || 'bg-gray-300 text-black';
      statusBadge.className += ' ' + cls;
      statusBadge.textContent = statusText;
    }

    function applyDeliveryBadgeStyle(stateText){
      if(!deliveryBadge) return;
      deliveryBadge.className = 'px-2 py-1 rounded-full text-xs';
      const map = {
        '배송준비':'bg-gray-300 text-black',
        '배송중':'bg-blue-500 text-white',
        '배송완료':'bg-green-600 text-white'
      };
      const cls = map[stateText] || 'bg-gray-300 text-black';
      deliveryBadge.className += ' ' + cls;
      deliveryBadge.textContent = stateText;
    }

    // 주문상태 드롭다운
    if (statusBtn){
      statusBtn.addEventListener('click', e=>{
        e.stopPropagation();
        statusMenu.classList.toggle('hidden');
      });
      document.addEventListener('click', ()=>statusMenu.classList.add('hidden'));
      statusMenu.querySelectorAll('button[data-status]').forEach(btn=>{
        btn.addEventListener('click', e=>{
          e.stopPropagation();
          const newStatus = btn.getAttribute('data-status');
          applyBadgeStyle(newStatus);
          if(orderNoEl && formOrderNum){ formOrderNum.value = orderNoEl.textContent.trim(); }
          formNewStatus.value = newStatus;
          statusForm.submit();
          statusMenu.classList.add('hidden');
        });
      });
    }

    // 배송상태 드롭다운
    if (shipBtn){
      shipBtn.addEventListener('click', e=>{
        e.stopPropagation();
        shipMenu.classList.toggle('hidden');
      });
      document.addEventListener('click', ()=>shipMenu.classList.add('hidden'));
      shipMenu.querySelectorAll('button[data-ship]').forEach(btn=>{
        btn.addEventListener('click', e=>{
          e.stopPropagation();
          const newState = btn.getAttribute('data-ship');
          applyDeliveryBadgeStyle(newState);
          if(orderNoEl && shipOrderNum){ shipOrderNum.value = orderNoEl.textContent.trim(); }
          formNewShipState.value = newState;
          shipForm.submit();
          shipMenu.classList.add('hidden');
        });
      });
    }

    // 최초 진입 시 뱃지 스타일 정규화
    if(statusBadge){ applyBadgeStyle(statusBadge.textContent.trim()); }
    if(deliveryBadge){ applyDeliveryBadgeStyle(deliveryBadge.textContent.trim()); }
  </script>
</body>
</html>
