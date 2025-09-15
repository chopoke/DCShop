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
      rel="stylesheet"
    />
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
      $('#UpdateQuestion').click(function() {
    	  question_update();
      });
   
      $('#DeleteQuestion').click(function() {
    	  question_delete();
   	  });
   });
   
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
         	sessionStorage.setItem('reloadCheck', 'true'); // 문자열로 새로고침용 세션 저장
         	history.back();
          },
          error: function() {
            alert('문의가 삭제되지않았니다.');
          }
       });
   }
   
   
   // [작성 버튼 클릭 시 호출]
   function question_update() {
	// 문의 내용을 파라미터로 넘김 
	let q_secret_val = $('#q_secret').is(':checked') ? 'Y' : 'N';
      let param = {	//문의자는 session이므로 controller에서 request로 직접받음.
   		 "q_num": $('#q_num').val(),
         "q_title" : $('#q_title').val(),		//문의 제목
         "q_content" : $('#q_content').val(),	//문의 내용
         "q_secret" : q_secret_val,
         "q_category" : $('#q_category').val(),
      }
      $.ajax({
         url: '${path}/question_updateAction.qa',  // 컨트롤러 이동(3)
         type: 'POST',
         data: param,
         success: function() {  // 콜백함수(6) => 문의작성이 완료되면 서버에서 콜백함수 호출
        	alert('문의가 수정되었습니다.');
        	sessionStorage.setItem('reloadCheck', 'true'); // 문자열로 새로고침용 세션 저장
        	history.back();
         },
         error: function() {
            alert('문의가 수정되지 않았습니다.');
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
		          <a href="#"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
		          <a href="#"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
		          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
		          <a href="./mypage_qna.do"     class="block py-2 px-3 rounded hover:bg-gray-100 bg-gray-50 font-semibold">문의관리</a>
		          <a href="#"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
		          <a href="#"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
		          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
		        </nav>
		      </aside>
		      
	      <!-- 메인 콘텐츠 -->
	      <main class="flex-1 p-8 bg-gray-50">
	      <form action="#">
		    <div class="max-w-4xl mx-auto p-6">
		      <div class="bg-white rounded-lg shadow-sm p-6 min-h-screen">
		        <h1 class="text-2xl font-semibold text-gray-900 mb-6">문의사항 수정</h1>
		        
		        <div class="space-y-6">
		          <div class="grid grid-cols-1 gap-6">
		            <div class="flex items-start space-x-4">
		              <label class="w-24 pt-2 text-sm font-medium text-gray-700">제목</label>
		              <div class="flex-1">
		              
		              <input type="hidden" id="q_num" name="q_num" value="${dto.q_num}">
		              
		                <input name="q_title" id="q_title" type="text" class="w-full px-3 h-10 bg-white border border-gray-300 rounded focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary text-sm"
		                  placeholder="${dto.q_title}" value="${dto.q_title}"/>
		              </div>
		            </div>
		            <div class="flex items-start space-x-4">
		              <label class="w-24 pt-2 text-sm font-medium text-gray-700">문의유형</label>
		              <div class="flex items-center space-x-4">
		                <div class="relative">
		                  <select name="q_category" id="q_category"
		                    class="appearance-none w-32 px-3 h-10 bg-white border border-gray-300 rounded focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary text-sm pr-8">
		                    <option value="${dto.q_category}">${dto.q_category}(기존) </option>
	                        <option value="교환">교환</option>
	                        <option value="환불">환불</option>
	                        <option value="배송">배송</option>
	                        <option value="가격">가격</option>
	                        <option value="품절">품절</option>
	                        <option value="입고">입고</option>
	                        <option value="기타">기타</option>
	                      </select>
		                </div>
		                <label class="inline-flex items-center cursor-pointer">
		                  <div class="relative">
		                    <input type="checkbox" class="sr-only peer" name="q_secret" id="q_secret" <c:if test="${dto.q_secret == 'Y'}">checked</c:if>/>
		                    <div class="w-11 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-full 
		                    			rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white 
		                    			after:content-[''] after:absolute after:top-[2px] after:start-[2px] 
		                    			after:bg-white after:border-gray-300 after:border after:rounded-full 
		                    			after:h-5 after:w-5 after:transition-all peer-checked:bg-primary">
		                    </div>
		                  </div>
		                  <span class="ml-2 text-sm font-medium text-gray-700">비밀글 여부</span>
		                </label>
		              </div>
		            </div>
		            <div class="flex items-start space-x-4">
		              <label class="w-24 pt-2 text-sm font-medium text-gray-700">내용</label>
		              <div class="flex-1">
		                <textarea
		                  class="w-full px-3 py-2 bg-white border border-gray-300 rounded focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary text-sm"
		                  rows="10" name="q_content" id="q_content"
		                  placeholder="${dto.q_content}">${dto.q_content}</textarea>
		              </div>
		            </div>
		          </div>
		          <div class="flex justify-end pt-4">
		            <button onclick="history.back()" class="px-6 h-10 !bg-black text-white !rounded-button hover:!bg-blue-200 transition-colors !whitespace-nowrap !mr-3">
		              뒤로가기
		            </button>
		            <button type="reset" class="px-6 h-10 !bg-gray-100 !text-gray-600 !rounded-button hover:!bg-gray-200 !transition-colors !whitespace-nowrap !mr-3">
		              취소
		            </button>
		            <button id="UpdateQuestion" class="px-6 h-10 !bg-blue-200 text-white !rounded-button hover:!bg-blue-600 !transition-colors !whitespace-nowrap !mr-3">
		              수정
		            </button>
		            <button id="DeleteQuestion" class="px-6 h-10 !bg-red-500 text-white !rounded-button hover:!bg-red-200 !transition-colors !whitespace-nowrap">
		              삭제
		            </button>
		          </div>
		        </div>
		      </div>
	      	</div>
      	  </form>
		</main>
     </div>
   </div>
	<br><br><br>
    <div class="wrap">
	  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>
	</div>
  </body>
</html>
