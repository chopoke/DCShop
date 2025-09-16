<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="zh">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>문의사항</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
      rel="stylesheet"/>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              primary: "#f97316",
              secondary: "#64748b",
            },
            borderRadius: {
              none: "0px",
              sm: "4px",
              DEFAULT: "8px",
              md: "12px",
              lg: "16px",
              xl: "20px",
              "2xl": "24px",
              "3xl": "32px",
              full: "9999px",
              button: "8px",
            },
          },
        },
      };
    </script>
    <style>
      :where([class^="ri-"])::before { content: "\f3c2"; }
      input[type="number"]::-webkit-inner-spin-button,
      input[type="number"]::-webkit-outer-spin-button {
      -webkit-appearance: none;
      margin: 0;
      }
      select {
      -webkit-appearance: none;
      -moz-appearance: none;
      appearance: none;
      background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
      background-repeat: no-repeat;
      background-position: right 0.5rem center;
      background-size: 1em;
      }
    </style>
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
<script>
   $(function() {  // 상세페이지가 로딩되면
      // 수정 버튼 클릭시 question_update함수 호출
      $('#DeleteQuestion').click(function() {
    	  question_delete();
   	  });
      
      $('#answerSubmitBtn').click(function(){
    	  answer_submitAction();
      })
   });
   
   function answer_submitAction(){
	      let param = {	//문의자는 session이므로 controller에서 request로 직접받음.
	   		 "q_num": $('#q_num').val(),
	   		 "a_answer" : $('#a_answer').val(),
	      }
	      $.ajax({
	          url: '${path}/qna_answerSubmitAction',  // 컨트롤러 이동(3)
	          type: 'POST',
	          data: param,
	          success: function() {  // 콜백함수(6) => 문의삭제가 완료되면 서버에서 콜백함수 호출
	         	alert('답변이 등록되었습니다.');
	         	window.location.href='${path}/admin_qna';
	          },
	          error: function() {
	            alert('답변이 등록되지 않았습니다.');
	          }
	       });
	   }
   
   
   function question_delete(){
      let param = {	//문의자는 session이므로 controller에서 request로 직접받음.
   		 "q_num": $('#q_num').val(),
      }
      $.ajax({
          url: '${path}/question_deleteAction.qa',  // 컨트롤러 이동(3)
          type: 'POST',
          data: param,
          success: function() {  // 콜백함수(6) => 문의삭제가 완료되면 서버에서 콜백함수 호출
         	alert('문의가 삭제되었습니다.');
         	window.location.href='${path}/mypage_qna.do';
          },
          error: function() {
            alert('문의가 삭제되지않았니다.');
          }
       });
   }
</script>
  </head>
  	<body class="bg-gray-100">
  	
		<!-- 헤더 시작 -->
		<%@ include file="../setting/header.jsp" %>
		<!-- 헤더 끝 -->
	
		<section class="hero-section1"></section>
  	
  		<!-- 전체 컨테이너 -->
		  <div class="min-h-screen flex justify-center py-8">
		    <!-- 메인 래퍼 -->
		    <div class="w-full h-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">
		      <!-- 사이드바 (네비게이션 건들지 않음) -->
      		
	      		<aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
	      			<c:if test="${sessionScope.session_u_role eq 'USER'}">
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
				           <a href="${path}/logout.do" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
				        </nav>
		      		</c:if>
		   			<c:if test="${sessionScope.session_u_role eq 'ADMIN'}">
				        <!-- 프로필 -->
				        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
				        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
				        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
				        <!-- <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button> -->
				
				        <!-- 네비게이션 -->
				        <nav class="w-full space-y-2 text-sm">
				          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
				          <a href="${path}/admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
				          <a href="${path}/admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
				          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded bg-gray-900 text-white">문의관리</a>
				          <a href="${path}/admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
				          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
				          <a href="${path}/logout.do" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
				        </nav>
				   	</c:if>
		       	</aside>
	      
	      <!-- 메인 콘텐츠 -->
	      <main class="flex-1 p-8 bg-gray-50">
			<div class="max-w-4xl mx-auto p-6">
				<div class="bg-white rounded-lg shadow-sm p-6 min-h-screen">
					<h1 class="text-2xl font-semibold text-gray-900 mb-6">상세 페이지</h1>
		
					<div class="space-y-6">
						<div class="flex items-start space-x-4">
							<label class="w-24 pt-2 text-sm font-medium text-gray-700">문의 제목</label>
							<div class="flex-1">
								<div class="px-3 py-2 bg-gray-100 rounded-md text-gray-800">
									${qna.q_title}
								</div>
								<input type="hidden" id="q_num" name="q_num" value="${qna.q_num}">
							</div>
						</div>
						<div class="flex items-start space-x-4">
							<label class="w-24 pt-2 text-sm font-medium text-gray-700">문의유형</label>
							<div class="flex items-center space-x-4">
								<c:set var="category"
									value="${empty qna.q_category ? '기타' : fn:trim(qna.q_category)}" />
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
							</div>
						</div>
						<div class="flex items-start space-x-4">
							<label class="w-24 pt-2 text-sm font-medium text-gray-700">내용</label>
							<div class="flex-1">
								<textarea disabled class="w-full px-3 py-2 bg-gray-100 
														border border-gray-300 rounded 
														focus:outline-none text-xm min-h-[150px]"
								>${qna.q_content}</textarea>
							</div>
						</div>
						
						<hr class="my-6 border-gray-200">
		
						<div class="flex items-start space-x-4">
							<label for="a_answer" class="w-24 pt-2 text-sm font-medium text-gray-700">답변 내용</label>
							<div class="flex-1">
							
								<textarea disabled class="w-full px-3 py-2 bg-gray-100 
														border border-gray-300 rounded 
														focus:outline-none text-xm min-h-[150px]"
								><c:if test="${empty qna.a_answer}">답변이 존재하지않습니다.</c:if
								><c:if test="${not empty qna.a_answer}">${qna.a_answer}</c:if
								></textarea>
							
							</div>
						</div>
					</div>
					
					<div class="flex justify-end pt-8">
						<button type="button" onclick="history.back()"
							class="px-6 h-10 !bg-gray-500 text-white !rounded-button hover:!bg-gray-600 transition-colors !whitespace-nowrap !mr-3">
							뒤로가기
						</button>
						<c:if test="${sessionScope.session_u_role == 'ADMIN'}">
							<button onclick="window.location.href='${path}/qna_answer?q_num=${qna.q_num}'"
								class="px-6 h-10 !bg-blue-500 text-white !rounded-button hover:!bg-blue-600 transition-colors !whitespace-nowrap !mr-3">
								답변 달기
							</button>
						</c:if>
						<c:if test="${sessionScope.session_u_member_id == qna.u_member_id}">
							<button onclick="window.location.href='${path}/question_update.qa?q_num=${qna.q_num}'"
								class="px-6 h-10 !bg-blue-500 text-white !rounded-button hover:!bg-blue-600 transition-colors !whitespace-nowrap">
								수정하기
							</button>
						</c:if>
					</div>
				</div>
			</div>
		</main>
     </div>
   </div>
	<br><br><br>
    <div class="wrap">
	  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
	</div>
  </body>
</html>
