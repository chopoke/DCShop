<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - 독캣배송</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.hero-section1 {
   width: 100%;
   background: white;
   padding: .5rem 0;
   padding-top: 5rem;
}
</style>
<script>
	$(function(){
		const $pwd = $('#u_password');
		const $pwdchk = $('#u_password_check');
		const $msg = $('#check');
		
		$msg.hide();
		function validate(){
			const pw = $pwd.val();
			const pwchk = $pwdchk.val();
			
			if(pwchk.length === 0 ){
				$msg.hide();
				return;
			}
			if(pw == pwchk){
				$msg.hide();
				return;
			}
			else {
				$msg.show();
				return;
			}
		}
		// 실시간 검사
		$pwdchk.on('input', validate);
		
	});
</script>
<script> /* 사용X - 주소 변경 API */
/* function changeAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            var detailAddr = '';	// 상세주소

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("u_address").value = extraAddr;
            
            } else {
                document.getElementById("u_address").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('u_zip_code').value = data.zonecode;
            document.getElementById("u_address").value = addr;
            document.get
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("u_detailaddress").focus();
        }
    }).open();
} */
</script>
</head>
<body class="bg-gray-100">
   <!-- 헤더 시작 -->
   <%@ include file="../setting/header.jsp"%>
   <!-- 헤더 끝 -->

   <section class="hero-section1"></section>

   <!-- 전체 컨테이너 -->
   <div class="min-h-screen flex justify-center py-8">
      <!-- 메인 래퍼 -->
      <div
         class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

         <!-- 사이드바 -->
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
         </aside>

         <!-- 메인 콘텐츠 -->
         <main class="flex-1 p-8 bg-gray-50">
            <section>
               <form action="${pageContext.request.contextPath}/mypage_editinfoAction.do" method="post"
			      class="bg-white rounded-2xl shadow-md border border-gray-100">
			
			  <!-- 헤더 -->
			  <div class="px-6 sm:px-8 py-5 border-b border-gray-100">
			    <h2 class="text-xl font-bold text-gray-900">회원정보 조회/수정</h2>
			    <p class="text-sm text-red-500 mt-1">* 표시는 필수 입력 항목입니다.</p>
			  </div>
			
			<div class="divide-y divide-gray-100">
			  	<!-- 아이딩 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700 flex items-center">
			        	<span class="text-red-500 mr-1"></span>아이디
			      	</label>
			      	<input type="text" name="u_id" value="${sessionScope.sessionid}" readonly
			             class="flex-1 bg-gray-50 border border-gray-200 rounded-lg px-3 py-2 text-gray-600 cursor-not-allowed focus:outline-none">
			    </div>
			
			    <!-- 비밀번호 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700 flex items-center">
			        	<span class="text-red-500 mr-1">*</span>비밀번호
			      	</label>
			      <input type="password" name="u_password" id="u_password" required
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
			    </div>
			
			    <!-- 비밀번호 확인 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700 flex items-center">
			        	<span class="text-red-500 mr-1">*</span>비밀번호 확인
			      	</label>
			      	<div class="flex-1 flex-col items-center gap-6">
				      <input type="password" name="u_password_check" id="u_password_check"  required
				             class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
				      <div id="check" class="invalid-feedback mb-1 m-1" >PASSWORD 가 동일하지 않습니다</div>
			      </div>
			    </div>
			    
			    <!-- 이름 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700 flex items-center">
			        	<span class="text-red-500 mr-1">*</span>이름
			      	</label>
			      <input type="text" name="u_name" value="${dto.u_name}"
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
			    </div>
			
			    <!-- 이메일 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700 flex items-center">
			        	<span class="text-red-500 mr-1">*</span>이메일
			      	</label>
			      <input type="email" name="u_email" value="${dto.u_email}" 
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
			    </div>
			
			    <!-- 닉네임 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700">닉네임</label>
			      	<input type="text" name="u_nickname" value="${dto.u_nickname}"
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
			    </div>
			
			    <!-- 생년월일 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700">생년월일</label>
			      	<input type="date" name="u_birth" value="${dto.u_birthday}"
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
			    </div>
			
			    <!-- 주소 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700">주소 </label>
			      	<input type="text" name="u_address" value="${dto.u_address}" id="u_address"
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
           		</div>
			    <!-- 우편번호 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700">우편번호</label>
			      	<input type="text" name="u_zip_code" value="${dto.u_zip_code}" id="u_zip_code"
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
           		</div>
			    <%-- <div class="px-6 sm:px-8 py-4 flex flex-wrap items-center gap-6 relative">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700">주소 | 우편번호</label>
			      	<div class="flex-1 space-y-2 min-w-0">
				      	<input type="text" name="u_address" value="${dto.u_address}" id="u_address"
				             class="flex-3/5 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
				             
				        <input type="text"  id="u_detailaddress" placeholder="상세주소" name ="u_detailaddress"
				             class="flex-1/5 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
				             
				      	<input type="text" name="u_zip_code" value="${dto.u_zip_code}" id="u_zip_code" readonly
				             class="flex-1/5 border border-gray-300 rounded-lg px-3 py-2  focus:outline-none">
				        <input type="button" onclick="changeAddress()" value="주소변경"
				        class="flex-1/5 px-3 py-2 border border-1 rounded-lg text-sm p-4 bg-white-100 hover:border-blue-500 hover:bg-gray-100 active:scale-[.99] transition">
			        </div>
			    </div> --%>
			
			    <!-- 전화번호 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700">전화번호</label>
			      	<input type="tel" name="u_phone" value="${dto.u_phone }"
			             class="flex-1 border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
			    </div>
			
			  <!-- 푸터 버튼 -->
			  <div class="flex flex-wrap px-6 sm:px-8 py-5 bg-gray-50 rounded-b-2xl p-5 gap-3">
			  		 <button type="button" onclick="location.href='${pageContext.request.contextPath}/mypage_main.do'"
			            class="flex-1 h-12 border border-gray-500 rounded-xl bg-white-600 text-blue font-semiboldshadow-sm hover:bg-gray-100 active:scale-[.99] transition">
			            취소 </button>
			    	<button type="submit"
			            class="flex-1 h-12 rounded-xl bg-blue-600 text-white font-semiboldshadow-sm hover:bg-blue-700 active:scale-[.99] transition">
			            완료 </button>
			  </div>
		  </div>
			</form>
               
            </section>
         </main>
      </div>
   </div>

   <!-- 푸터 시작 -->
   <%@ include file="../setting/footer.jsp"%>
   <!-- 푸터 끝 -->
</body>
</html>