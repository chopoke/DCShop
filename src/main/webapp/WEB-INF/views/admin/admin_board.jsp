<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Page - 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style type="text/css">
    .hero-section1 { width:100%; background:white; padding:.5rem 0; padding-top:5rem; }
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
        <img src="${path}/resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold"><c:out value="${session_u_nickname}"/></h2>
        <p class="text-gray-500 text-sm mb-4"><c:out value="${session_u_email}"/></p>
        <a href="${path}/mypage/profile" class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600 inline-block">정보수정</a>

        <!-- 네비게이션 -->
        <nav class="w-full space-y-2 text-sm">
          <a href="./admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100 bg-gray-50 font-medium">게시판관리</a>
          <a href="./admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="./admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="./admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="./admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="./admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h2 class="text-xl font-semibold mb-4">게시판관리</h2>

        <!-- 검색/필터 바 -->
        <form method="get" action="${path}/admin_board" class="mb-4 grid grid-cols-12 gap-2">
          <select name="category" class="col-span-2 border rounded px-2 py-2">
            <option value="">전체 카테고리</option>
            <option value="자유"  ${param.category=='자유'  ? 'selected' : ''}>자유</option>
            <option value="팁"    ${param.category=='팁'    ? 'selected' : ''}>팁</option>
            <option value="리뷰"  ${param.category=='리뷰'  ? 'selected' : ''}>리뷰</option>
            <option value="질문"  ${param.category=='질문'  ? 'selected' : ''}>질문</option>
          </select>

          <input type="date" name="from" value="${param.from}" class="col-span-2 border rounded px-2 py-2"/>
          <input type="date" name="to"   value="${param.to}"   class="col-span-2 border rounded px-2 py-2"/>

          <input type="text" name="q" placeholder="제목/내용/작성자"
                 value="${fn:escapeXml(param.q)}"
                 class="col-span-5 border rounded px-3 py-2"/>

          <button class="col-span-1 bg-blue-600 text-white rounded px-3">검색</button>
        </form>

        <!-- 선택 액션 바 -->
        <div class="mb-2 flex items-center gap-2">
          <button id="btnDeleteSelected"
                  type="submit"
                  form="bulkForm"
                  class="px-3 py-2 rounded bg-red-600 text-white disabled:bg-red-300"
                  disabled>
            선택 삭제
          </button>
          <span class="text-sm text-gray-500">체크한 게시글이 삭제됩니다.</span>
        </div>

        <!-- 리스트 테이블: 폼 시작 -->
        <form id="bulkForm" method="post" action="${path}/admin_board_delete">
          <!-- (선택) Spring Security CSRF 사용 시 -->
          <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          </c:if>

          <!-- 현재 검색 파라미터 유지 -->
          <input type="hidden" name="q"        value="${fn:escapeXml(param.q)}"/>
          <input type="hidden" name="category" value="${param.category}"/>
          <input type="hidden" name="from"     value="${param.from}"/>
          <input type="hidden" name="to"       value="${param.to}"/>

          <div class="border rounded-xl overflow-hidden bg-white">
            <table class="w-full table-fixed">
              <colgroup>
                <col style="width:56px"/><!-- 선택 -->
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
                  <th class="p-2 text-center">
                    <input id="checkAll" type="checkbox" class="w-4 h-4">
                  </th>
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
                      <input type="checkbox" name="b_nums"
                             value="${b.b_num}"
                             class="rowCheck w-4 h-4">
                    </td>
                    <td class="p-2 text-center"><c:out value="${b.b_num}"/></td>

                    <td class="p-2">
                      <a href="${path}/board_detail?b_num=${b.b_num}&listClick=1" class="block truncate" title="${fn:escapeXml(b.b_title)}">
                        <c:out value="${b.b_title}"/>
                      </a>
                    </td>

                    <td class="p-2 text-center"><c:out value="${b.b_category}"/></td>

                    <!-- 작성자: userDTO[0].u_nickname 우선, 없으면 writer_nickname 폴백 -->
                    <td class="p-2 text-center">
                      <c:choose>
                        <c:when test="${not empty b.userDTO}">
                          <c:forEach var="u" items="${b.userDTO}" begin="0" end="0">
                            <c:out value="${u.u_nickname}"/>
                          </c:forEach>
                        </c:when>
                        <c:otherwise>
                          <c:out value="${b.writer_nickname}"/>
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <td class="p-2 text-center"><c:out value="${b.b_views}" default="0"/></td>
                    <td class="p-2 text-center"><c:out value="${b.b_recommend}" default="0"/></td>
                    <td class="p-2 text-center">
                      <fmt:formatDate value="${b.b_dateposted}" pattern="yyyy-MM-dd"/>
                    </td>
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
        </form>
        <!-- 폼 끝 -->

        <!-- 페이지네이션 -->
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

          <c:if test="${paging.next gt 0 and paging.next le paging.pageCount}">
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
<script>
    (function(){
      const checkAll  = document.getElementById('checkAll');
      const btnDelete = document.getElementById('btnDeleteSelected');

      function getRowChecks(){ return Array.from(document.querySelectorAll('.rowCheck')); }

      function updateUI(){
        const rows = getRowChecks();
        const checked = rows.filter(ch => ch.checked);
        // 전체선택 상태/부분선택 상태
        if (checkAll){
          checkAll.checked = rows.length > 0 && checked.length === rows.length;
          checkAll.indeterminate = checked.length > 0 && checked.length < rows.length;
        }
        // 버튼 활성/비활성
        if (btnDelete){
          btnDelete.disabled = checked.length === 0;
        }
      }

      // 전체선택 토글
      if (checkAll){
        checkAll.addEventListener('change', () => {
          getRowChecks().forEach(ch => ch.checked = checkAll.checked);
          updateUI();
        });
      }

      // 행 체크 변경 감지
      document.addEventListener('change', (e) => {
        if (e.target.classList.contains('rowCheck')) updateUI();
      });

      // 삭제 전 확인
      if (btnDelete){
        btnDelete.addEventListener('click', (e) => {
          const count = getRowChecks().filter(ch => ch.checked).length;
          if (count === 0){
            e.preventDefault();
            return;
          }
          if (!confirm(count + '건을 삭제할까요? 삭제 후 되돌릴 수 없습니다.')){
            e.preventDefault();
          }
        });
      }

      // 초기 상태
      updateUI();
    })();
</script>
</body>
</html>
