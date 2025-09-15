<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>유저 - 내 문의 | 독캣배송</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
<script>
	setInterval(function() {
	  if (sessionStorage.getItem('reloadCheck') === 'true') {
	    sessionStorage.removeItem('reloadCheck');
	    window.location.reload();
	  }
	}, 500);

   function question_delete(q_num){
      let param = {	//문의자는 session이므로 controller에서 request로 직접받음.
   		 "q_num": q_num,
      }
      $.ajax({
          url: '${path}/question_deleteAction.qa',  // 컨트롤러 이동(3)
          type: 'POST',
          data: param,
          success: function() {  // 콜백함수(6) => 문의삭제가 완료되면 서버에서 콜백함수 호출
         	alert('문의가 삭제되었습니다.');
         	window.location.reload();
          },
          error: function() {
            alert('문의가 삭제되지않았니다.');
          }
       });
   }
 </script>
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
        <form id="avatarForm" action="${path}/mypage_imgUpload.do" method="post" enctype="multipart/form-data">
			  	<input type="hidden" name="u_id" value="${sessionScope.sessionid}">
			  	<input type="file" id="u_image" name="u_image" accept="image/*" style="display:none;">
			</form>
			<c:choose>
				  <c:when test="${empty dto.u_image}">
				    <c:url var="imgUrl" value="/resources/img_main/mypage_default.png" />
				  </c:when>
				  <c:otherwise>
				    <c:url var="imgUrl" value="/resources/image/profile/${dto.u_image}" />
				  </c:otherwise>
			</c:choose>
			
			<img id="profileImg"
			     src="${imgUrl}"
			     alt="Profile"
			     class="rounded-full w-28 h-28 object-cover mb-4 cursor-pointer border" />

        <h2 class="text-lg font-semibold">${sessionScope.sessionid}</h2>
        <h2 class="text-lg font-semibold">${sessionScope.session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${sessionScope.session_u_email}</p>
        <button class="px-4 py-2 bg-black text-white rounded-lg mb-6 hover:bg-blue-600"
                onclick="window.location='<c:url value="/mypage_pwdcheck.do"/>'">정보수정</button>

        <!-- 네비게이션 -->
        <nav class="w-full space-y-2 text-sm">
           <a href="${pageContext.request.contextPath}/mypage_editPet.do" class="block py-2 px-3 rounded hover:bg-gray-100">내 반려동물</a> 
           <a href="./orderList" class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a> 
           <a href="./wishList.do" class="block py-2 px-3 rounded hover:bg-gray-100">관심상품</a> 
           <a href="./cartList" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
           <a href="./mypage_qna.do" class="block py-2 px-3 bg-gray-900 text-white rounded hover:bg-gray-100">Q&A</a> 
           <a href="./mypage/my_reviews.do" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a>
           <!-- <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a> -->
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">내 문의</h1>

        <!-- 검색/필터 -->
        <form action="${path}/mypage_qna.do" method="get" class="mb-4">
          <div class="bg-white border rounded-lg p-4 grid grid-cols-1 md:grid-cols-12 gap-3">
            <div class="md:col-span-3">
              <label class="block text-sm text-gray-600 mb-1">답변상태</label>
              <select name="q_answer" class="w-full border rounded px-3 py-2">
                <option value="">전체</option>
                <option value="Y"  <c:if test="${param.q_answer == 'Y'}">selected</c:if>>답변 완료</option>
                <option value="N"  <c:if test="${param.q_answer == 'N'}">selected</c:if>>답변 대기</option>
              </select>
            </div>
            <div class="md:col-span-3">
              <label class="block text-sm text-gray-600 mb-1">카테고리</label>
              <select name="q_category" class="w-full border rounded px-3 py-2">
                <option value="">전체</option>
                <option value="교환" <c:if test="${param.q_category == '교환'}">selected</c:if>>교환</option>
                <option value="환불" <c:if test="${param.q_category == '환불'}">selected</c:if>>환불</option>
                <option value="배송" <c:if test="${param.q_category == '배송'}">selected</c:if>>배송</option>
                <option value="가격" <c:if test="${param.q_category == '가격'}">selected</c:if>>가격</option>
                <option value="품절" <c:if test="${param.q_category == '품절'}">selected</c:if>>품절</option>
                <option value="입고" <c:if test="${param.q_category == '입고'}">selected</c:if>>입고</option>
                <option value="기타" <c:if test="${param.q_category == '기타'}">selected</c:if>>기타</option>
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
        <form id="bulkForm" action="${path}/mypage_qna.do/bulk" method="post" class="mb-3">
          <input type="hidden" name="action" id="bulkAction" value="">
          <!-- 목록 -->
          <div class="mt-3 bg-white border rounded-lg overflow-x-auto">
            <table class="min-w-full tbl-fixed">
              <colgroup>
                <col style="width:100px;">
                <col style="width:100px;">
                <col style="width:120px;">
                <col style="width:80px;">
                <col style="width:130px;">
                <col style="width:130px;">
                <col style="width:100px;">
                <col style="width:140px;">
              </colgroup>
              <thead class="bg-gray-100 text-sm">
                <tr>
                  <th class="py-2 px-3 text-center">문의번호</th>
                  <th class="py-2 px-3 text-center">카테고리</th>
                  <th class="py-2 px-3 text-center">제목</th>
                  <th class="py-2 px-3 text-center">작성자</th>
                  <th class="py-2 px-3 text-center">등록일</th>
                  <th class="py-2 px-3 text-center">처리일</th>
                  <th class="py-2 px-3 text-center">답변상태</th>
                  <th class="py-2 px-3 text-center">처리</th>
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
                    <td class="py-2 px-3 align-center">#${q.q_num}</td>
                    <td class="py-2 px-3 align-center">
                      <span class="text-gray-700">
                        <c:choose>
                          <c:when test="${q.q_category == '교환'}">교환</c:when>
                          <c:when test="${q.q_category == '환불'}">환불</c:when>
                          <c:when test="${q.q_category == '배송'}">배송</c:when>
                          <c:when test="${q.q_category == '가격'}">가격</c:when>
                          <c:when test="${q.q_category == '품절'}">품절</c:when>
                          <c:when test="${q.q_category == '입고'}">입고</c:when>
                          <c:when test="${q.q_category == '기타'}">기타</c:when>
                          <c:otherwise>기타</c:otherwise>
                        </c:choose>
                      </span>
                    </td>
                    <td class="py-2 px-3 align-center">
                      <div class="ellipsis" title="${q.q_title}">
                        <a href="javascript:void(0)" class="text-blue-600 hover:underline"
                           onclick="window.location='${path}/question_detailAction.qa?q_num=${q.q_num}'">${q.q_title}</a>
                      </div>
                      <%-- <div class="text-gray-400 text-xs ellipsis" title="${q.preview}">${q.preview}</div> --%>
                    </td>
                    <td class="py-2 px-3 align-center ellipsis" title="${q.u_id}">${q.u_id}</td>
                    <td class="py-2 px-3 align-center"><fmt:formatDate value="${q.q_regDate}" pattern="yyyy-MM-dd" /></td>
                    <td class="py-2 px-3 align-center">
                      <c:choose>
                        <c:when test="${not empty q.a_regdate}">
                          ${q.a_regdate}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                      </c:choose>
                    </td>
                    <c:if test="${not (q.q_answer eq 'Y')}">
						<td class="text-center">
							<span class="bg-pink-100 text-red-500 px-1 py-1 rounded text-xs">
								답변대기 
							</span>
						</td>
					</c:if>
					<c:if test="${(q.q_answer eq 'Y')}">
						<td class="text-center">
							<span class="bg-blue-100 text-blue-500 px-1 py-1 rounded text-xs">
								답변완료 
							</span>
						</td>
					</c:if>
                    <td class="py-2 px-3 align-center">
                      <div class="flex flex-wrap gap-1">
                        <button type="button" class="px-2 py-1 border rounded hover:bg-gray-50"
                                onclick="window.location.href='${path}/question_update.qa?q_num=${q.q_num}'">수정</button>
                        <a class="px-2 py-1 bg-red-600 text-white rounded hover:bg-red-700"
                           onclick="question_delete(${q.q_num})">삭제</a>
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
            <c:if test="${paging.startPage > 10}">
              <a href="${path}/mypage_qna.do?pageNum=${paging.prev}" class="px-3 py-2 text-sm hover:bg-gray-50 border-r">Prev</a>
            </c:if>
            <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
	            <c:if test="${num != 0}">
	              <a href="${path}/mypage_qna.do?pageNum=${i}"
	                 class="px-3 py-2 text-sm border-r <c:if test='${paging.currentPage==i}'>bg-blue-600 text-white</c:if>">
	                ${i}
	              </a>
	             </c:if>
            </c:forEach>
            <c:if test="${paging.startPage < paging.pageCount}">
              <a href="${path}/mypage_qna.do?pageNum=${paging.next}" class="px-3 py-2 text-sm hover:bg-gray-50">Next</a>
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
          <dt class="text-gray-500">답변상태</dt><dd id="m_status" class="col-span-3">-</dd>
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
        <form action="${path}/mypage_qna.do/replyQuick" method="post" class="mt-2">
          <input type="hidden" name="q_num" id="m_qid_input" value="">
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
