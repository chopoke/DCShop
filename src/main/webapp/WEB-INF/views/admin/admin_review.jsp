<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - 리뷰관리 | 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  
  <style>
  .hero-section1{width:100%;background:#fff;padding:.5rem 0;padding-top:5rem;}
  .tbl-fixed{table-layout:fixed;}
  .ellipsis{overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
  .row-nowrap td{white-space:nowrap;vertical-align:middle;height:52px;}

  /* === 폼 공통 === */
  .label      { font-size:16px; color:#374151; margin-bottom:6px; display:block; }
  .form-ctl   {
    width:100%; height:46px;      
    font-size:16px; border-radius:10px;
    padding:0 .75rem; border:1px solid #d1d5db; background:#fff;
  }
  .btn-primary{
    width:100%; height:44px;           
    font-size:16px; border-radius:10px;
    padding:0 1rem; color:#fff; background:#2563eb;
  }
  .btn-primary:hover{ background:#1e4fd7; }
 </style>
  
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>
  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 -->
      <aside class="w-72 shrink-0 bg-white border-r p-6 flex flex-col items-center">
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <!-- <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button> -->
        
        <!-- 네비게이션(수정금지) -->
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

      <!-- 메인 -->
      <main class="flex-1 p-8 bg-gray-50 text-[16px] leading-6">
        <h1 class="text-2xl font-bold mb-6">리뷰관리</h1>

        <!-- 검색/필터 -->
		<form id="searchForm" action="${path}/admin_review" method="get" class="mb-4">
		  <div class="bg-white border rounded-lg p-4 grid grid-cols-1 md:grid-cols-12 gap-3">
		
		    <!-- 1줄: 각 1/4 -->
		    <div class="md:col-span-3">
		      <label class="label">카테고리</label>
		      <select name="category" class="form-ctl">
		        <option value="">전체</option>
		        <option value="dog" ${param.category=='dog'?'selected':''}>강아지</option>
		        <option value="cat" ${param.category=='cat'?'selected':''}>고양이</option>
		      </select>
		    </div>
		
		    <div class="md:col-span-3">
		      <label class="label">평점</label>
		      <select name="rate" class="form-ctl">
		        <option value="">전체</option>
		        <c:forEach var="i" begin="1" end="5">
		          <c:set var="rev" value="${6 - i}" />
		          <option value="${rev}" ${param.rate == rev ? 'selected' : ''}>${rev}점</option>
		        </c:forEach>
		      </select>
		    </div>
		
		    <div class="md:col-span-3">
		      <label class="label">기간(시작)</label>
		      <input type="date" name="from" value="${param.from}" class="form-ctl">
		    </div>
		
		    <div class="md:col-span-3">
		      <label class="label">기간(끝)</label>
		      <input type="date" name="to" value="${param.to}" class="form-ctl">
		    </div>
		
		    <!-- 2줄: 검색어 3/4 + 버튼 1/4 -->
		    <div class="md:col-span-9">
		      <label class="label">검색어</label>
		      <input type="text" name="q" value="${fn:escapeXml(param.q)}"
		             placeholder="상품명 / 작성자 / 내용 검색" class="form-ctl">
		    </div>
		    <div class="md:col-span-3 flex items-end">
		      <button type="submit" class="w-full h-12 px-4 py-2 bg-black text-white rounded hover:bg-blue-700 !rounded-button">검색</button>
		    </div>
		
		  </div>
		</form>

        <!-- 상단 액션: 삭제만 -->
        <div class="mb-3 flex flex-wrap items-center gap-2 text-[15px]">
          <form id="bulkForm" action="${path}/admin_review_delete" method="post" class="flex gap-2">
            <input type="hidden" name="ids" id="bulkIds" value="">
            <button type="button" id="bulkDelete"
                    class="px-3 py-2 bg-rose-500 text-white rounded-lg hover:bg-rose-600">삭제</button>
          </form>
          <div class="ml-auto text-sm text-gray-500">
            총 <span class="font-semibold"><c:out value="${paging.count}" /></span>건
          </div>
        </div>

        <!-- 목록 -->
        <div class="bg-white border rounded-lg overflow-hidden">
          <table class="w-full tbl-fixed text-[15px]">
            <colgroup>
              <col style="width:44px;"><!-- 체크 -->
              <col style="width:16.66%;">
              <col style="width:16.66%;">
              <col style="width:12%;">
              <col><!-- 내용 -->
              <col style="width:16.66%;">
              <col style="width:16.66%;">
            </colgroup>
            <thead class="bg-gray-50 border-b text-[14px] text-gray-700">
              <tr>
                <th class="py-3 text-center"><input type="checkbox" id="checkAll"></th>
                <th class="py-3 text-center">리뷰번호</th>
                <th class="py-3 text-center">상품번호</th>
                <th class="py-3 text-center">평점</th>
                <th class="py-3 text-left">내용</th>
                <th class="py-3 text-center">작성자</th>
                <th class="py-3 text-center">작성일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${reviewList}">
                <tr class="border-b row-nowrap hover:bg-gray-50">
                  <td class="text-center">
                    <input type="checkbox" class="rowCheck" value="${r.r_num}">
                  </td>
                  <td class="text-center ellipsis">
                    <a href="${path}/admin_review_detail?r_num=${r.r_num}" class="text-blue-600 hover:underline">${r.r_num}</a>
                  </td>
                  <td class="text-center ellipsis">
                    <span class="text-gray-700">${r.pd_id}</span>
                  </td>
                  <td class="text-center">${r.r_rate}</td>
                  <td class="ellipsis">
                    <a href="${path}/admin_review_detail?r_num=${r.r_num}" class="hover:underline block w-full">
                      <c:out value="${r.r_content}" />
                    </a>
                  </td>
                  <td class="text-center ellipsis"><c:out value="${r.u_nickname}" /></td>
                  <td class="text-center">
                    <fmt:formatDate value="${r.r_regdate}" pattern="yyyy-MM-dd" />
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty reviewList && paging.currentPage == 1}">
				  <tr>
				    <td colspan="7" class="py-10 text-center text-gray-400">조회된 리뷰가 없습니다.</td>
				  </tr>
				</c:if>
            </tbody>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <c:set var="qs" value="category=${param.category}&rate=${param.rate}&from=${param.from}&to=${param.to}&q=${fn:escapeXml(param.q)}" />

        <div class="mt-6 flex justify-center">
            <nav class="inline-flex items-center gap-1 text-sm">

		  <!-- « : 이전 블록은 startPage가 1보다 클 때만 -->
		  <c:if test="${paging.startPage > 1}">
		    <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
		       href="${path}/admin_review?pageNum=${paging.startPage-1}&${qs}">&laquo;</a>
		  </c:if>
		
		  <!-- 번호 -->
		  <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
		    <c:choose>
		      <c:when test="${i == paging.currentPage}">
		        <span class="px-3 py-2 border rounded-lg bg-gray-900 text-white">${i}</span>
		      </c:when>
		      <c:otherwise>
		        <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
		           href="${path}/admin_review?pageNum=${i}&${qs}">${i}</a>
		      </c:otherwise>
		    </c:choose>
		  </c:forEach>
		
		  <!-- » : 다음 블록은 endPage가 pageCount보다 작을 때만 -->
		  <c:if test="${paging.endPage < paging.pageCount}">
		    <a class="px-3 py-2 border rounded-lg hover:bg-gray-50"
		       href="${path}/admin_review?pageNum=${paging.endPage+1}&${qs}">&raquo;</a>
		  </c:if>
		</nav>

        </div>
      </main>
    </div>
  </div>

  <%@ include file="../setting/footer.jsp" %>

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

    // 일괄 삭제
    const bulkForm = document.getElementById('bulkForm');
    document.getElementById('bulkDelete')?.addEventListener('click', ()=>{
      if(collectSelectedIds()===0){ alert('항목을 선택하세요.'); return; }
      if(confirm('선택한 리뷰를 삭제하시겠습니까?')) {
        bulkForm.submit();
      }
    });
  </script>
</body>
</html>
