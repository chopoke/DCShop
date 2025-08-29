<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
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

        <!-- 네비게이션 -->
        <nav class="w-full space-y-2 text-sm">
          <a href="./mypage_admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="./mypage_admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="./mypage_admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="./mypage_admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="./mypage_admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="./mypage_admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">${sessionid}님의 마이페이지입니다.</h1>
        <h2 class="text-xl font-semibold mb-4">게시판관리</h2>

        <!-- 검색/필터 바 (상태 제거, 카테고리 값: 자유/팁/리뷰/질문) -->
        <form method="get" action="${path}/mypage_admin_board" class="mb-4 grid grid-cols-12 gap-2">
          <select name="category" class="col-span-2 border rounded px-2 py-2">
            <option value="">전체 카테고리</option>
            <option value="자유"  ${param.category=='자유'  ? 'selected' : ''}>자유</option>
            <option value="팁"    ${param.category=='팁'    ? 'selected' : ''}>팁</option>
            <option value="리뷰"  ${param.category=='리뷰'  ? 'selected' : ''}>리뷰</option>
            <option value="질문"  ${param.category=='질문'  ? 'selected' : ''}>질문</option>
          </select>

          <input type="date" name="from" value="${param.from}" class="col-span-2 border rounded px-2 py-2"/>
          <input type="date" name="to"   value="${param.to}"   class="col-span-2 border rounded px-2 py-2"/>

          <input type="text" name="q" placeholder="제목/내용/작성자" value="${fn:escapeXml(param.q)}"
                 class="col-span-5 border rounded px-3 py-2"/>

          <button class="col-span-1 bg-blue-600 text-white rounded px-3">검색</button>
        </form>

        <!-- 일괄 액션 바 (삭제만 남김) -->
        <form id="bulkForm" method="post" action="${path}/admin/board/bulk" class="mb-2 flex items-center gap-2">
          <input type="hidden" name="op" id="bulkOp" value=""/>
          <button type="button" data-op="delete" class="px-3 py-1 border rounded text-red-600">삭제</button>
          <span id="selCount" class="text-sm text-gray-500 ml-2">선택 0건</span>
        </form>

        <!-- 리스트 테이블 -->
        <div class="border rounded-xl overflow-hidden bg-white">
          <table class="w-full table-fixed">
            <colgroup>
              <col style="width:44px"/><!-- 체크박스 -->
              <col style="width:80px"/><!-- 번호 -->
              <col /><!-- 제목 -->
              <col style="width:120px"/><!-- 카테고리 -->
              <col style="width:120px"/><!-- 작성자 -->
              <col style="width:90px"/><!-- 조회 -->
              <col style="width:90px"/><!-- 추천 -->
              <col style="width:140px"/><!-- 등록일 -->
            </colgroup>

            <thead class="bg-gray-50 sticky top-0 z-10">
              <tr class="text-sm text-gray-600">
                <th class="p-2 text-center"><input type="checkbox" id="chkAll"></th>
                <th class="p-2 text-center">번호</th>
                <th class="p-2 text-left">제목</th>
                <th class="p-2 text-center">카테고리</th>
                <th class="p-2 text-center">작성자</th>
                <th class="p-2 text-center">조회</th>
                <th class="p-2 text-center">추천</th>
                <th class="p-2 text-center">등록일</th>
              </tr>
            </thead>

            <tbody class="text-sm">
              <c:forEach var="b" items="${boardList}">
                <tr class="border-t hover:bg-gray-50">
                  <td class="p-2 text-center">
                    <input type="checkbox" name="ids" form="bulkForm" value="${b.b_num}" class="rowChk">
                  </td>
                  <td class="p-2 text-center">${b.b_num}</td>
                  <td class="p-2">
                    <a href="${path}/admin/board/${b.b_num}" class="block truncate" title="${b.b_title}">
                      <c:out value="${b.b_title}"/>
                    </a>
                  </td>
                  <td class="p-2 text-center">${b.b_category}</td>
                  <td class="p-2 text-center">${b.writerNickname}</td>
                  <td class="p-2 text-center"><c:out value="${b.b_views}" default="0"/></td>
                  <td class="p-2 text-center"><c:out value="${b.b_recommend}" default="0"/></td>
                  <td class="p-2 text-center">${b.b_dateposted}</td>
                </tr>
              </c:forEach>

              <c:if test="${empty boardList}">
                <tr>
                  <td colspan="8" class="p-6 text-center text-gray-400">검색 결과가 없습니다.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <!-- 페이지네이션 (paging 객체 사용) -->
        <div class="flex justify-center items-center gap-1 mt-4">
          <c:if test="${paging.prev > 0}">
            <a href="?pageNum=${paging.prev}&q=${fn:escapeXml(param.q)}&category=${param.category}&from=${param.from}&to=${param.to}"
               class="px-3 py-1 border rounded hover:bg-gray-100">이전</a>
          </c:if>

          <c:forEach var="p" begin="${paging.startPage}" end="${paging.endPage}">
            <a href="?pageNum=${p}&q=${fn:escapeXml(param.q)}&category=${param.category}&from=${param.from}&to=${param.to}"
               class="px-3 py-1 border rounded ${p == paging.currentPage ? 'bg-gray-900 text-white' : 'hover:bg-gray-100'}">
              ${p}
            </a>
          </c:forEach>

          <c:if test="${paging.next > 0 && paging.next <= paging.pageCount}">
            <a href="?pageNum=${paging.next}&q=${fn:escapeXml(param.q)}&category=${param.category}&from=${param.from}&to=${param.to}"
               class="px-3 py-1 border rounded hover:bg-gray-100">다음</a>
          </c:if>
        </div>

      </main>
    </div>
  </div>

  <!-- 푸터 시작 -->
  <%@ include file="../setting/footer.jsp" %>
  <!-- 푸터 끝 -->

  <!-- 스크립트: DOM 로드 후 실행 -->
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      const chkAll   = document.getElementById('chkAll');
      const selCount = document.getElementById('selCount');
      const bulkForm = document.getElementById('bulkForm');
      const bulkOp   = document.getElementById('bulkOp');

      const rowChks = () => Array.from(document.querySelectorAll('.rowChk'));
      function updateCount() {
        selCount.textContent = '선택 ' + rowChks().filter(c => c.checked).length + '건';
      }

      if (chkAll) {
        chkAll.addEventListener('change', () => {
          rowChks().forEach(c => c.checked = chkAll.checked);
          updateCount();
        });
      }
      document.addEventListener('change', (e) => {
        if (e.target.classList.contains('rowChk')) {
          const all = rowChks();
          if (chkAll) chkAll.checked = all.length > 0 && all.every(c => c.checked);
          updateCount();
        }
      });

      // 삭제만 동작
      document.querySelectorAll('#bulkForm [data-op]').forEach(btn => {
        btn.addEventListener('click', () => {
          const selected = rowChks().filter(c => c.checked);
          if (selected.length === 0) { alert('항목을 선택하세요.'); return; }
          const op = btn.getAttribute('data-op');
          if (op === 'delete' && !confirm('선택 항목을 삭제할까요?')) return;
          bulkOp.value = op;
          bulkForm.submit();
        });
      });

      updateCount();
    });
  </script>

</body>
</html>
