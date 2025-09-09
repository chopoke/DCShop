<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 - 문의관리 | 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style type="text/css">
    .hero-section1 { width:100%; background:white; padding:.5rem 0; padding-top:5rem; }
    /* 테이블 고정 레이아웃 + 말줄임 */
    .tbl-fixed { table-layout: fixed; }
    .ellipsis { overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
    /* 상태 배지 */
    .badge { @apply inline-flex items-center px-2 py-0.5 rounded text-xs font-medium; }
    .badge-wait { @apply bg-yellow-100 text-yellow-700; }
    .badge-done { @apply bg-green-100 text-green-700; }
    .badge-hold { @apply bg-gray-100 text-gray-700; }
    /* 모달 오버레이 */
    .modal { display:none; }
    .modal.show { display:flex; }
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
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <!-- 프로필 -->
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>

        <!-- 네비게이션 -->
        <nav class="w-full space-y-2 text-sm">
          <a href="./admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="./admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="./admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="./admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100 bg-gray-50 font-semibold">문의관리</a>
          <a href="./admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="./admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">문의관리</h1>

        <!-- 검색/필터 -->
        <form action="${path}/admin_qna" method="get" class="mb-4">
          <div class="bg-white border rounded-lg p-4 grid grid-cols-1 md:grid-cols-12 gap-3">
            <div class="md:col-span-3">
              <label class="block text-sm text-gray-600 mb-1">처리상태</label>
              <select name="status" class="w-full border rounded px-3 py-2">
                <option value="">전체</option>
                <option value="WAIT"  <c:if test="${param.status == 'WAIT'}">selected</c:if>>대기</option>
                <option value="DONE"  <c:if test="${param.status == 'DONE'}">selected</c:if>>완료</option>
                <option value="HOLD"  <c:if test="${param.status == 'HOLD'}">selected</c:if>>보류</option>
              </select>
            </div>
            <div class="md:col-span-3">
              <label class="block text-sm text-gray-600 mb-1">카테고리</label>
              <select name="category" class="w-full border rounded px-3 py-2">
                <option value="">전체</option>
                <option value="ORDER"   <c:if test="${param.category == 'ORDER'}">selected</c:if>>주문</option>
                <option value="PRODUCT" <c:if test="${param.category == 'PRODUCT'}">selected</c:if>>상품</option>
                <option value="PAY"     <c:if test="${param.category == 'PAY'}">selected</c:if>>결제</option>
                <option value="DELIV"   <c:if test="${param.category == 'DELIV'}">selected</c:if>>배송</option>
                <option value="ETC"     <c:if test="${param.category == 'ETC'}">selected</c:if>>기타</option>
              </select>
            </div>
            <div class="md:col-span-3">
              <label class="block text-sm text-gray-600 mb-1">기간(시작)</label>
              <input type="date" name="from" value="${param.from}" class="w-full border rounded px-3 py-2" />
            </div>
            <div class="md:col-span-3">
              <label class="block text-sm text-gray-600 mb-1">기간(끝)</label>
              <input type="date" name="to" value="${param.to}" class="w-full border rounded px-3 py-2" />
            </div>
            <div class="md:col-span-9">
              <label class="block text-sm text-gray-600 mb-1">키워드</label>
              <input type="text" name="keyword" value="${fn:escapeXml(param.keyword)}" placeholder="제목/내용/작성자 검색"
                     class="w-full border rounded px-3 py-2" />
            </div>
            <div class="md:col-span-3 flex items-end gap-2">
              <button type="submit" class="w-full px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">검색</button>
            </div>
          </div>
        </form>

        <!-- 일괄 처리 버튼 -->
        <form id="bulkForm" action="${path}/admin_qna/bulk" method="post" class="mb-3">
          <input type="hidden" name="action" id="bulkAction" value="">
          <div class="flex flex-wrap items-center gap-2">
            <button type="button" onclick="setBulk('DONE')" class="px-3 py-2 bg-green-600 text-white rounded hover:bg-green-700">선택 완료처리</button>
            <button type="button" onclick="setBulk('WAIT')" class="px-3 py-2 bg-amber-500 text-white rounded hover:bg-amber-600">선택 대기로</button>
            <button type="button" onclick="setBulk('HOLD')" class="px-3 py-2 bg-gray-600 text-white rounded hover:bg-gray-700">선택 보류</button>
            <button type="button" onclick="setBulk('DELETE')" class="px-3 py-2 bg-red-600 text-white rounded hover:bg-red-700">선택 삭제</button>
            <span class="text-sm text-gray-500 ml-1">체크 후 일괄 처리하세요.</span>
          </div>

          <!-- 목록 -->
          <div class="mt-3 bg-white border rounded-lg overflow-x-auto">
            <table class="min-w-full tbl-fixed">
              <colgroup>
                <col style="width:44px;">
                <col style="width:100px;">
                <col style="width:120px;">
                <col style="width:120px;">
                <col style="width:90px;">
                <col style="width:110px;">
                <col style="width:110px;">
                <col style="width:90px;">
                <col style="width:160px;">
              </colgroup>
              <thead class="bg-gray-100 text-sm">
                <tr>
                  <th class="py-2 px-3 text-left"><input type="checkbox" id="chkAll" /></th>
                  <th class="py-2 px-3 text-left">문의번호</th>
                  <th class="py-2 px-3 text-left">카테고리</th>
                  <th class="py-2 px-3 text-left">제목</th>
                  <th class="py-2 px-3 text-left">작성자</th>
                  <th class="py-2 px-3 text-left">등록일</th>
                  <th class="py-2 px-3 text-left">처리일</th>
                  <th class="py-2 px-3 text-left">상태</th>
                  <th class="py-2 px-3 text-left">관리</th>
                </tr>
              </thead>
              <tbody class="text-sm">
                <c:if test="${empty list}">
                  <tr>
                    <td colspan="9" class="py-8 text-center text-gray-500">조회된 문의가 없습니다.</td>
                  </tr>
                </c:if>

                <c:forEach var="q" items="${list}">
                  <tr class="border-t">
                    <td class="py-2 px-3 align-top">
                      <input type="checkbox" name="q_ids" value="${q.q_id}" class="rowChk"/>
                    </td>
                    <td class="py-2 px-3 align-top">#${q.q_id}</td>
                    <td class="py-2 px-3 align-top">
                      <span class="text-gray-700">
                        <c:choose>
                          <c:when test="${q.category=='ORDER'}">주문</c:when>
                          <c:when test="${q.category=='PRODUCT'}">상품</c:when>
                          <c:when test="${q.category=='PAY'}">결제</c:when>
                          <c:when test="${q.category=='DELIV'}">배송</c:when>
                          <c:otherwise>기타</c:otherwise>
                        </c:choose>
                      </span>
                    </td>
                    <td class="py-2 px-3 align-top">
                      <div class="ellipsis" title="${q.title}">
                        <a href="javascript:void(0)" class="text-blue-600 hover:underline"
                           onclick="openModal(${q.q_id})">${q.title}</a>
                      </div>
                      <div class="text-gray-400 text-xs ellipsis" title="${q.preview}">${q.preview}</div>
                    </td>
                    <td class="py-2 px-3 align-top ellipsis" title="${q.writer_nick}">${q.writer_nick}</td>
                    <td class="py-2 px-3 align-top"><fmt:formatDate value="${q.created_at}" pattern="yyyy-MM-dd" /></td>
                    <td class="py-2 px-3 align-top">
                      <c:choose>
                        <c:when test="${not empty q.completed_at}">
                          <fmt:formatDate value="${q.completed_at}" pattern="yyyy-MM-dd" />
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                      </c:choose>
                    </td>
                    <td class="py-2 px-3 align-top">
                      <c:choose>
                        <c:when test="${q.status=='WAIT'}"><span class="badge badge-wait">대기</span></c:when>
                        <c:when test="${q.status=='DONE'}"><span class="badge badge-done">완료</span></c:when>
                        <c:otherwise><span class="badge badge-hold">보류</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td class="py-2 px-3 align-top">
                      <div class="flex flex-wrap gap-1">
                        <button type="button" class="px-2 py-1 border rounded hover:bg-gray-50"
                                onclick="openModal(${q.q_id})">보기</button>
                        <a href="${path}/admin_qna/replyForm?q_id=${q.q_id}"
                           class="px-2 py-1 bg-blue-600 text-white rounded hover:bg-blue-700">답변</a>
                        <a href="${path}/admin_qna/mark?q_id=${q.q_id}&status=DONE"
                           class="px-2 py-1 bg-green-600 text-white rounded hover:bg-green-700">완료</a>
                        <a href="${path}/admin_qna/mark?q_id=${q.q_id}&status=HOLD"
                           class="px-2 py-1 bg-gray-600 text-white rounded hover:bg-gray-700">보류</a>
                        <a href="${path}/admin_qna/delete?q_id=${q.q_id}"
                           class="px-2 py-1 bg-red-600 text-white rounded hover:bg-red-700"
                           onclick="return confirm('삭제하시겠습니까?');">삭제</a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </form>

        <!-- 페이지네이션 -->
        <div class="mt-4 flex justify-center">
          <nav class="inline-flex -space-x-px overflow-hidden rounded-md border bg-white">
            <c:if test="${page.prev}">
              <a href="${path}/admin_qna?pageNum=${page.startPage-1}" class="px-3 py-2 text-sm hover:bg-gray-50 border-r">Prev</a>
            </c:if>
            <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
              <a href="${path}/admin_qna?pageNum=${i}"
                 class="px-3 py-2 text-sm border-r <c:if test='${page.currentPage==i}'>bg-blue-600 text-white</c:if>">
                ${i}
              </a>
            </c:forEach>
            <c:if test="${page.next}">
              <a href="${path}/admin_qna?pageNum=${page.endPage+1}" class="px-3 py-2 text-sm hover:bg-gray-50">Next</a>
            </c:if>
          </nav>
        </div>

      </main>
    </div>
  </div>

  <!-- 상세/답변 모달 -->
  <div id="qnaModal" class="modal fixed inset-0 z-50 items-center justify-center bg-black/40 p-4">
    <div class="w-full max-w-2xl bg-white rounded-xl shadow-lg">
      <div class="flex items-center justify-between px-5 py-3 border-b">
        <h3 class="text-lg font-semibold">문의 상세</h3>
        <button onclick="closeModal()" class="p-2 hover:bg-gray-100 rounded">✕</button>
      </div>
      <div class="p-5 space-y-3">
        <dl class="grid grid-cols-4 gap-2 text-sm">
          <dt class="text-gray-500">문의번호</dt><dd id="m_qid" class="col-span-3">-</dd>
          <dt class="text-gray-500">카테고리</dt><dd id="m_cat" class="col-span-3">-</dd>
          <dt class="text-gray-500">작성자</dt><dd id="m_writer" class="col-span-3">-</dd>
          <dt class="text-gray-500">등록일</dt><dd id="m_created" class="col-span-3">-</dd>
          <dt class="text-gray-500">상태</dt><dd id="m_status" class="col-span-3">-</dd>
        </dl>
        <div>
          <div class="text-gray-500 text-sm mb-1">제목</div>
          <div id="m_title" class="font-medium"></div>
        </div>
        <div>
          <div class="text-gray-500 text-sm mb-1">내용</div>
          <div id="m_content" class="whitespace-pre-line"></div>
        </div>

        <!-- 간단 답변 등록 -->
        <form action="${path}/admin_qna/replyQuick" method="post" class="mt-2">
          <input type="hidden" name="q_id" id="m_qid_input" value="">
          <textarea name="reply" rows="4" class="w-full border rounded px-3 py-2" placeholder="간단한 답변을 입력하세요."></textarea>
          <div class="mt-3 flex justify-end gap-2">
            <button type="button" onclick="closeModal()" class="px-4 py-2 border rounded hover:bg-gray-50">닫기</button>
            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">답변등록</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- 푸터 시작 -->
  <%@ include file="../setting/footer.jsp" %>
  <!-- 푸터 끝 -->

  <script>
    // 전체선택
    const chkAll = document.getElementById('chkAll');
    if (chkAll) {
      chkAll.addEventListener('change', function() {
        document.querySelectorAll('.rowChk').forEach(c => c.checked = chkAll.checked);
      });
    }
    // 일괄처리
    function setBulk(action) {
      const anyChecked = Array.from(document.querySelectorAll('.rowChk')).some(c => c.checked);
      if (!anyChecked) { alert('선택된 항목이 없습니다.'); return; }
      if (action === 'DELETE' && !confirm('선택 항목을 삭제하시겠습니까?')) return;
      document.getElementById('bulkAction').value = action;
      document.getElementById('bulkForm').submit();
    }

    // 모달: 실제 서비스에서는 AJAX로 상세를 가져오면 됨.
    function openModal(qid) {
      // 예시: 행에서 데이터 읽어오기 (실서비스에서는 fetch로 상세 API 호출 권장)
      // 여기서는 간단히 셋업만
      document.getElementById('m_qid').textContent = '#' + qid;
      document.getElementById('m_qid_input').value = qid;
      // 필요 시 추가 필드 세팅
      document.getElementById('qnaModal').classList.add('show');
    }
    function closeModal() {
      document.getElementById('qnaModal').classList.remove('show');
    }
  </script>
</body>
</html>
