<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹 -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>QnA</title>

<style>
:where([class^="ri-"])::before {
	content: "\f3c2";
}
</style>
</head>
<body>
	<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<div class="bg-white rounded-lg shadow-sm border">
			<div class="mb-8">
				<h2 class="text-xl font-bold text-gray-900 mb-6">상품 문의</h2>
				<div class="overflow-x-auto">
					<table class="w-full border-collapse border border-gray-200">
						<thead>
							<tr class="bg-gray-50">
								<th class="border border-gray-200 px-4 py-3 text-left font-medium text-gray-700">
									번호
								</th>
								<th class="border border-gray-200 px-4 py-3 text-left font-medium text-gray-700">
									작성자
								</th>
								<th class="border border-gray-200 px-4 py-3 text-left font-medium text-gray-700">
									문의 제목
								</th>
								<th class="border border-gray-200 px-4 py-3 text-left font-medium text-gray-700">
									작성일
								</th>
								<th class="border border-gray-200 px-4 py-3 text-left font-medium text-gray-700">
									구분
								</th>
								<th class="border border-gray-200 px-4 py-3 text-left font-medium text-gray-700">
									답변
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">

								<tr class="hover:bg-gray-50"
									onclick="showQuestionDetail(${dto.q_num})">
									<!-- 번호 -->
									<td class="border border-gray-200 px-4 py-3 text-center">${dto.rn}</td>
									<!-- 작성자ID -->
									<td class="border border-gray-200 px-4 py-3">${dto.u_id}</td>
									<!-- 글제목 -->
									<td class="border border-gray-200 px-4 py-3">
										<!-- 비밀글 여부 체크 --> 
									<c:if test="${dto.q_secret eq 'Y'}">
										<!-- 등록한 사람본인이 맞는지 체크 -->
										<c:if test="${dto.u_member_id eq sessionScope.session_u_member_id}"> 
											${dto.q_title}
										</c:if>
											<c:if
												test="${not (dto.u_member_id eq sessionScope.session_u_member_id)}">
												<span style="color: gray; opacity: 0.6;">비밀글 입니다.</span>
											</c:if>
										</c:if> 
									<c:if test="${not (dto.q_secret eq 'Y')}"> 
										${dto.q_title} 
									</c:if> 
									<!-- 비밀글 여부 체크 완료-->
									</td>

									<td class="border border-gray-200 px-4 py-3 text-center">
										${dto.q_regDate}</td>

									<td class="border border-gray-200 px-4 py-3 text-center">
										<c:set var="category"
											value="${empty dto.q_category ? '기타' : fn:trim(dto.q_category)}" />
										<c:choose>
											<c:when test="${category eq '반품'}">
												<c:set var="bg" value="bg-yellow-100" />
											</c:when>
											<c:when test="${category eq '교환'}">
												<c:set var="bg" value="bg-orange-100" />
											</c:when>
											<c:when test="${category eq '환불'}">
												<c:set var="bg" value="bg-red-100" />
											</c:when>
											<c:when test="${category eq '배송'}">
												<c:set var="bg" value="bg-green-100" />
											</c:when>
											<c:when test="${category eq '가격'}">
												<c:set var="bg" value="bg-teal-100" />
											</c:when>
											<c:when test="${category eq '품절'}">
												<c:set var="bg" value="bg-purple-100" />
											</c:when>
											<c:when test="${category eq '입고'}">
												<c:set var="bg" value="bg-cyan-100" />
											</c:when>
											<c:otherwise>
												<c:set var="bg" value="bg-gray-100" />
											</c:otherwise>
										</c:choose> 
										<span class="${bg} text-blue-800 px-2 py-1 rounded text-sm">
											${category} 
										</span>
									</td>

									<c:if test="${not (dto.q_answer eq 'Y')}">
										<td class="border border-gray-200 px-4 py-3 text-center">
											<span class="bg-pink-100 text-red-800 px-2 py-1 rounded text-sm">
												답변대기 
											</span>
										</td>
									</c:if>
									<c:if test="${(dto.q_answer eq 'Y')}">
										<td class="border border-gray-200 px-4 py-3 text-center">
											<span class="bg-blue-100 text-blue-800 px-2 py-1 rounded text-sm">
												답변완료 
											</span>
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<!-- paging -->
							<tr>
								<td colspan="6" align="center">
									<ul class="pagination" style="display: flex; justify-content: center; list-style-type: none; padding: 0; text-align: center;">
										<!-- 페이징처리 -->
										<!-- 이전버튼 활성화 -->
										<c:if test="${paging.startPage > 10}">
											<li>
												<a onclick="question_list(${paging.prev})" class="prevPage"> [이전] </a>
											</li>
										</c:if>
										
										<c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
											<li>
												<c:if test="${num != 0}">
													<a onclick="question_list(${num})" class="<c:if test='${num == paging.currentPage}'>active</c:if>">${num}</a>
												</c:if>
											</li>
										</c:forEach>
										
										<!-- 페이지 번호 처리 -->
										<!-- 다음버튼 활성화 -->
										<c:if test="${paging.startPage < paging.pageCount}">
											<li>
												<a onclick="question_list(${paging.next})" class="nextPage"> [다음] </a>
											</li>
										</c:if>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>



		<!-- 문의 항목 클릭 시 -->

		<!-- 문의 상세 모달 -->
		<div id="questionDetailModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
			<div class="bg-white rounded-lg w-full max-w-3xl mx-4">
				<div class="border-b px-6 py-4 flex justify-between items-center">
					<h3 class="text-xl font-bold text-gray-900">문의 상세</h3>
					<button onclick="closeQuestionDetail()"
						class="!text-gray-500 hover:!text-gray-700">
						<i class="ri-close-line text-2xl"></i>
					</button>
				</div>
				<div class="p-6">
					<div class="space-y-6">
						<div class="flex justify-between items-start">
							<div>
								<h4 id="modalTitle"
									class="text-lg font-medium text-gray-900 mb-1"></h4>
								<div class="flex items-center space-x-4 text-sm text-gray-500">
									<input type="hidden" id="modalqNum" name="qNum">
									<!-- 작성자 번호 -->
									<span id="modalWriter"></span>

									<!-- 작성일 -->
									<span id="modalDate"></span>

									<!-- 카테고리 -->
									<span id="modalCategoryBadge"
										class="bg-blue-100 text-blue-800 px-2 py-1 rounded"></span>
								</div>
							</div>
							<div class="flex space-x-2">
								<button onclick="editQuestion()" class="px-3 py-1 border !border-gray-300 rounded text-sm hover:!bg-gray-50 whitespace-nowrap">
									수정
								</button>
								<button onclick="deleteQuestion()" class="px-3 py-1 border !border-gray-300 rounded text-sm hover:!bg-gray-50 whitespace-nowrap">
									삭제
								</button>
							</div>
						</div>
						<div class="bg-gray-50 rounded-lg p-4">
							<p id="modalContent" class="text-gray-700 whitespace-pre-line !break-all"></p>
						</div>
						<!-- Admin Reply - 관리자 답변 -->
						<div class="mt-8">
							<div class="flex items-center space-x-2 mb-4">
								<i class="ri-customer-service-2-line text-primary"></i> 
								<span class="font-medium text-gray-900 !break-all">관리자 답변</span>
							</div>
							<div id="adminReplyContent" class="bg-orange-50 rounded-lg p-4">
								<div class="flex justify-between items-start mb-2">
									<span class="text-sm text-gray-500" id="답변 등록시간"></span>
								</div>
								<p class="text-gray-700 whitespace-pre-line" id="답변 내용"></p>
							</div>
							<!-- Admin Reply Form -->
							<div id="adminReplyForm" class="mt-4">
								<div class="flex items-center space-x-2 mb-4">
									<i class="ri-edit-line text-primary"></i> <span
										class="font-medium text-gray-900">답변 작성</span>
								</div>
								<div class="space-y-4">
									<textarea id="adminReplyText" rows="4"
										class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent resize-none"
										placeholder="답변을 입력해주세요">
										</textarea>
									<div class="flex justify-end">
										<button onclick="submitAdminReply()"
											class="!bg-primary !text-white px-4 py-2 !rounded-button hover:!bg-orange-600 transition-colors">
											답변 등록
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="border-t px-6 py-4">
					<button onclick="closeQuestionDetail()"
						class="w-full bg-primary text-white py-2 rounded-button hover:bg-orange-600 transition-colors">
						닫기
					</button>
				</div>
			</div>
		</div>
	</main>

	<!-- modal -->
	<script>
    // 현재 로그인한 사용자의 역할이 'ADMIN'인지 확인하는 변수입니다.
    const isAdmin = '${sessionScope.session_u_role}' === 'ADMIN';

    // DOM 캐시
    const modal = document.getElementById("questionDetailModal");
    const elTitle = document.getElementById("modalTitle");
    const elWriter = document.getElementById("modalWriter");
    const elDate = document.getElementById("modalDate");
    const elCategoryBadge = document.getElementById("modalCategoryBadge");
    const elContent = document.getElementById("modalContent");
    const editButton = document.querySelector('button[onclick="editQuestion()"]');
    const deleteButton = document.querySelector('button[onclick="deleteQuestion()"]');
    const adminReplyContent = document.getElementById("adminReplyContent");
    const adminReplyForm = document.getElementById("adminReplyForm");
    const adminReplyText = document.getElementById("adminReplyText");
    
    const adminReplyDate = adminReplyContent.querySelector('span');
    const adminReplyMessage = adminReplyContent.querySelector('p');

    //모달 띄우기 함수
    window.showQuestionDetail = async function (qNum) {
        // UI 초기화
        elTitle.textContent = '불러오는 중...';
        elWriter.textContent = '';
        elDate.textContent = '';
        elCategoryBadge.textContent = '';
        elCategoryBadge.className = 'px-2 py-1 rounded text-sm';
        elContent.textContent = '';
        editButton.style.display = 'none';
        deleteButton.style.display = 'none';
        adminReplyContent.style.display = 'none';
        adminReplyForm.style.display = 'none';
        adminReplyText.value = '';

        modal.classList.remove("hidden");
        modal.classList.add("flex");
        document.body.style.overflow = "hidden";
        
        try {
            const res = await fetch("<c:url value='/api/qna/'/>" + qNum, {
                method: 'GET',
                headers: { 'Accept': 'application/json' }
            });
			/* Controller과 통신하여 상태코드에 따른 문구 호출 */
            if (res.status === 404) {
                alert('해당 문의를 찾을 수 없습니다.');
                return closeQuestionDetail();
            }
            if (res.status === 401) {
                alert('로그인이 필요합니다.');
                return closeQuestionDetail();
            }
            if (res.status === 403) {
                alert('비밀글은 작성자만 열람할 수 있습니다.');
                return closeQuestionDetail();
            }
            if (!res.ok) {
                alert('문의 상세를 불러오지 못했습니다.');
                return closeQuestionDetail();
            }

            const dto = await res.json();
            const sessionUserId = '${sessionScope.session_u_member_id}';
            const isAuthor = (dto.u_member_id == sessionUserId);
            
            // 작성자 또는 관리자만 수정/삭제 버튼 보이기
            if (isAuthor || isAdmin) {
                editButton.style.display = 'block';
                deleteButton.style.display = 'block';
            }
			
            // 답변 상태에 따라 관리자 답변 영역 표시
            if (dto.q_answer === 'Y') {
                adminReplyContent.style.display = 'block';
                if (dto.a_regdate) {
	                const date = new Date(dto.a_regdate);
	                const formatted = date.getFullYear() + '-' +
                    String(date.getMonth() + 1).padStart(2, '0') + '-' +
                    String(date.getDate()).padStart(2, '0');
	                adminReplyDate.textContent = formatted;
	            } else {
	            	adminReplyDate.textContent = '';
	            }
                
                adminReplyMessage.textContent = dto.a_answer;
                
            } else if (isAdmin) { // 답변이 없지만, 관리자일 경우
                adminReplyForm.style.display = 'block';
            }
			
            // 모달 데이터 채우기
            elTitle.textContent = dto.q_title || '(제목 없음)';
            elWriter.textContent = (dto.u_id != null) ? ('작성자:' + dto.u_id) : '';
            elContent.textContent = dto.q_content || '';
            const cat = (dto.q_category && dto.q_category.trim()) || '기타';
            elCategoryBadge.textContent = '분류 : ' + cat;
            document.getElementById("modalqNum").value = qNum;
            
            if (dto.q_regDate) {
                const date = new Date(dto.q_regDate);
                const formattedDate = date.getFullYear() + '-' +
                                     String(date.getMonth() + 1).padStart(2, '0') + '-' +
                                     String(date.getDate()).padStart(2, '0');
                elDate.textContent = formattedDate;
            } else {
                elDate.textContent = '';
            }
            
        } catch (e) {
            console.error(e);
            alert('오류가 발생했습니다.');
            closeQuestionDetail();
        }
    };

    window.closeQuestionDetail = function () {
        modal.classList.add("hidden");
        modal.classList.remove("flex");
        document.body.style.overflow = "";
    };

    window.editQuestion = function () {
        if (confirm("문의를 수정하시겠습니까?")) {
            window.location.href = '${path}/question_update.qa?q_num='+document.getElementById("modalqNum").value;
        }
    };

    window.deleteQuestion = function () {
        if (confirm("문의를 삭제하시겠습니까?")) {
        	let param = {
   	   		 "q_num": document.getElementById("modalqNum").value,
	   	      }
	   	      $.ajax({
	   	          url: '${path}/question_deleteAction.qa',
	   	          type: 'POST',
	   	          data: param,
	   	          success: function() {
	   	         	alert('문의가 삭제되었습니다.');
	   	         	window.location.reload();
	   	          },
	   	          error: function() {
	   	            alert('문의가 삭제되지않았니다.');
   	          }
   	       });
        }
    };

    window.submitAdminReply = function () {
        const replyText = adminReplyText.value.trim();
        if (!replyText) {
            alert("답변 내용을 입력해주세요.");
            return;
        }
        // TODO: POST /api/qna/{qNum}/answer
    };

    // 오버레이(바깥쪽) 클릭 시 닫기
    modal.addEventListener("click", function (e) {
        if (e.target === modal) closeQuestionDetail();
    });

    // ESC 키로 모달 닫기
    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
            closeQuestionDetail();
        }
    });
</script>
</body>
</html>