<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - 리뷰관리 | 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style type="text/css">
    .hero-section1{width:100%;background:white;padding:.5rem 0;padding-top:5rem;}
    /* 말줄임 공통 */
    .td-ellipsis{ @apply whitespace-nowrap overflow-hidden text-ellipsis; }
    /* 테이블 행 높이 균일 + 줄바꿈 방지 */
    .row-nowrap td{ @apply whitespace-nowrap align-middle; height: 56px; }
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
      
      <!-- 사이드바 (네비게이션 건들지 않음) -->
      <aside class="w-72 shrink-0 bg-white border-r p-6 flex flex-col items-center">
        <!-- 프로필 -->
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>
        <!-- 네비게이션 -->
        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded bg-gray-900 text-white">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">리뷰관리</h1>

        <form id="searchForm" action="${path}/admin_review" method="get" class="mb-4">
		  <div class="bg-white border rounded-lg p-4 space-y-3">
		
		    <!-- 1줄: 카테고리 / 상태 / 평점 -->
		    <div class="flex flex-wrap items-center gap-3">
		      <label class="text-sm text-gray-600">카테고리</label>
		      <select name="category" class="border rounded-lg h-10 px-3">
		        <option value="">전체</option>
		        <option value="dog" ${param.category=='dog'?'selected':''}>강아지</option>
		        <option value="cat" ${param.category=='cat'?'selected':''}>고양이</option>
		      </select>
		
		      <label class="text-sm text-gray-600 ml-3">상태</label>
		      <select name="status" class="border rounded-lg h-10 px-3">
		        <option value="">전체</option>
		        <option value="VIS" ${param.status=='VIS'?'selected':''}>공개</option>
		        <option value="HID" ${param.status=='HID'?'selected':''}>비공개</option>
		        <option value="RPT" ${param.status=='RPT'?'selected':''}>신고됨</option>
		      </select>
		
		      <label class="text-sm text-gray-600 ml-3">평점</label>
		      <select name="rate" class="border rounded-lg h-10 px-3">
		        <option value="">전체</option>
		        <c:forEach var="i" begin="1" end="5" step="1">
		          <c:set var="rev" value="${6 - i}" />
		          <option value="${rev}" ${param.rate == rev ? 'selected' : ''}>${rev}점</option>
		        </c:forEach>
		      </select>
		    </div>
		
		    <!-- 2줄: 기간 -->
		    <div class="flex flex-wrap items-center gap-3">
		      <label class="text-sm text-gray-600">기간</label>
		      <input type="date" name="from" value="${param.from}" class="border rounded-lg h-10 px-3">
		      <span class="text-gray-400">~</span>
		      <input type="date" name="to" value="${param.to}" class="border rounded-lg h-10 px-3">
		    </div>
		
		    <!-- 3줄: 검색어 + 버튼 -->
		    <div class="flex flex-wrap items-center gap-3">
		      <input type="text" name="q" value="${fn:escapeXml(param.q)}"
		             placeholder="상품명 / 작성자 / 내용 검색"
		             class="border rounded-lg h-10 px-4 flex-1 min-w-[260px]" />
		      <!-- 초기화 버튼 없음 -->
		      <button class="h-10 px-4 bg-gray-900 text-white rounded-lg hover:bg-black">검색</button>
		    </div>
		
		  </div>
		</form>

        <!-- 상단 액션바 -->
        <div class="mb-3 flex flex-wrap items-center gap-2">
          <form id="bulkForm" action="${path}/admin_review/bulk" method="post" class="flex gap-2">
            <input type="hidden" name="ids" id="bulkIds" value="">
            <button type="button" id="bulkShow"   class="px-3 py-2 bg-emerald-500 text-white rounded-lg hover:bg-emerald-600">공개</button>
            <button type="button" id="bulkHide"   class="px-3 py-2 bg-amber-500  text-white rounded-lg hover:bg-amber-600">비공개</button>
            <button type="button" id="bulkDelete" class="px-3 py-2 bg-rose-500    text-white rounded-lg hover:bg-rose-600">삭제</button>
          </form>
          <div class="ml-auto text-sm text-gray-500">
            총 <span class="font-semibold"><c:out value="${paging.totalCount}" /></span>건
          </div>
        </div>

        <!-- 리뷰 목록 -->
        <div class="bg-white border rounded-lg overflow-hidden">
          <table class="w-full table-fixed">
            <colgroup>
              <col style="width:48px;">
              <col style="width:100px;">
              <col style="width:120px;">
              <col style="width:80px;">
              <col style="width:100px;">
              <col style="width:100px;">
              <col style="width:100px;">
              <col style="width:140px;">
              <col style="width:90px;">
            </colgroup>
            <thead class="bg-gray-50 border-b text-xs text-gray-600">
              <tr>
                <th class="py-3 text-center"><input type="checkbox" id="checkAll"></th>
                <th class="py-3 text-center">리뷰번호</th>
                <th class="py-3 text-center">상품번호</th>
                <th class="py-3 text-center">평점</th>
                <th class="py-3 text-left">내용</th>
                <th class="py-3 text-center">작성자</th>
                <th class="py-3 text-center">상태</th>
                <th class="py-3 text-center">작성일</th>
                <th class="py-3 text-center">신고</th>
              </tr>
            </thead>
            <tbody class="text-sm">
              <c:forEach var="r" items="${reviewList}">
                <tr class="border-b row-nowrap hover:bg-gray-50">
                  <td class="text-center">
                    <input type="checkbox" class="rowCheck" value="${r.r_num}">
                  </td>
                  <td class="text-center td-ellipsis">
                    <a href="${path}/admin_review/detail/${r.r_num}" class="text-blue-600 hover:underline">${r.r_num}</a>
                  </td>
                  <td class="text-center td-ellipsis">
                    <a href="${path}/admin_product/detail/${r.pd_id}" class="hover:underline">${r.pd_id}</a>
                  </td>
                  <td class="text-center">${r.r_rate}</td>
                  <td class="td-ellipsis">
                    <a href="${path}/admin_review/detail/${r.r_num}" class="hover:underline block max-w-[100%]">
                      <c:out value="${r.r_content}" />
                    </a>
                  </td>
                  <td class="text-center td-ellipsis"><c:out value="${r.u_id}" /></td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${r.r_status == 'VIS'}"><span class="px-2 py-1 text-xs rounded bg-emerald-100 text-emerald-700">공개</span></c:when>
                      <c:when test="${r.r_status == 'HID'}"><span class="px-2 py-1 text-xs rounded bg-amber-100  text-amber-700">비공개</span></c:when>
                      <c:otherwise><span class="px-2 py-1 text-xs rounded bg-gray-100 text-gray-700">-</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <fmt:formatDate value="${r.r_regdate}" pattern="yyyy-MM-dd" />
                  </td>
                  <td class="text-center">
                    <c:if test="${r.r_report_cnt > 0}">
                      <span class="px-2 py-1 text-xs rounded bg-rose-100 text-rose-700">신고 ${r.r_report_cnt}</span>
                    </c:if>
                    <c:if test="${r.r_report_cnt == 0 || r.r_report_cnt == null}">
                      <span class="text-gray-400 text-xs">없음</span>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty reviewList}">
                <tr>
                  <td colspan="9" class="py-10 text-center text-gray-400">조회된 리뷰가 없습니다.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="mt-6 flex justify-center">
          <nav class="inline-flex items-center gap-1 text-sm">
            <c:if test="${paging.prev}">
              <a class="px-3 py-2 border rounded-lg hover:bg-gray-50" href="${path}/admin_review?pageNum=${paging.startPage-1}&${paging.queryString}">&laquo;</a>
            </c:if>

            <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
              <c:choose>
                <c:when test="${i == paging.pageNum}">
                  <span class="px-3 py-2 border rounded-lg bg-gray-900 text-white">${i}</span>
                </c:when>
                <c:otherwise>
                  <a class="px-3 py-2 border rounded-lg hover:bg-gray-50" href="${path}/admin_review?pageNum=${i}&${paging.queryString}">${i}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>

            <c:if test="${paging.next}">
              <a class="px-3 py-2 border rounded-lg hover:bg-gray-50" href="${path}/admin_review?pageNum=${paging.endPage+1}&${paging.queryString}">&raquo;</a>
            </c:if>
          </nav>
        </div>
      </main>
    </div>
  </div>

  <!-- 푸터 시작 -->
  <%@ include file="../setting/footer.jsp" %>
  <!-- 푸터 끝 -->

  <script>
    // 전체선택
    document.getElementById('checkAll')?.addEventListener('change', (e)=>{
      document.querySelectorAll('.rowCheck').forEach(chk => chk.checked = e.target.checked);
    });

    // 선택된 id 수집
    function collectSelectedIds(){
      const ids = Array.from(document.querySelectorAll('.rowCheck:checked')).map(el=>el.value);
      document.getElementById('bulkIds').value = ids.join(',');
      return ids.length;
    }

    // 일괄 처리 버튼
    const bulkForm = document.getElementById('bulkForm');
    document.getElementById('bulkShow')?.addEventListener('click', ()=>{
      if(collectSelectedIds()===0){ alert('항목을 선택하세요.'); return; }
      bulkForm.action = '${path}/admin_review/bulkShow';
      bulkForm.submit();
    });
    document.getElementById('bulkHide')?.addEventListener('click', ()=>{
      if(collectSelectedIds()===0){ alert('항목을 선택하세요.'); return; }
      bulkForm.action = '${path}/admin_review/bulkHide';
      bulkForm.submit();
    });
    document.getElementById('bulkDelete')?.addEventListener('click', ()=>{
      if(collectSelectedIds()===0){ alert('항목을 선택하세요.'); return; }
      if(confirm('선택한 리뷰를 삭제하시겠습니까?')) {
        bulkForm.action = '${path}/admin_review/bulkDelete';
        bulkForm.submit();
      }
    });
  </script>
</body>
</html>
