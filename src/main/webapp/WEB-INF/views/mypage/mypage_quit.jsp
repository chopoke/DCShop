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
               <form action="${pageContext.request.contextPath}/mypage_quitAction.do" method="post"
			      class="bg-white rounded-2xl shadow-md border border-gray-100">
			
					  <!-- 헤더 -->
					<div class="px-8 py-10 text-center border-b border-gray-100 bg-white">
					  <h2 class="text-2xl font-extrabold text-gray-900">회원 탈퇴 </h2>
					
					  <p class="mt-3 text-red-600 font-semibold text-base">
					    ⚠️ 주의하세요! ⚠️
					  </p>
					
					  <!-- 설명 -->
					  <div class="mt-4 text-gray-600 leading-relaxed space-y-2 max-w-lg mx-auto">
					    <p>탈퇴 시 삭제/유지되는 정보를 반드시 확인하세요.</p>
					    <p>회원 탈퇴 시, 계정은 삭제되며 복구되지 않습니다.</p>
					    <p>서비스에서 탈퇴를 원하시면 비밀번호를 한 번 더 입력해주세요.</p>
					  </div>
					</div>
			
			<div class="divide-y divide-gray-100">
				<c:if test="${param.err == '1'}">
					<div class="mb-4 p-3 bg-red-50 text-red-600 rounded">비밀번호가 일치하지 않습니다.</div>
				</c:if>
			  	<!-- 아이딩 -->
			    <div class="px-6 sm:px-8 py-4 flex items-center gap-6">
			      	<label class="w-32 sm:w-44 text-sm font-medium text-gray-700 flex items-center">
			        	<span class="text-red-500 mr-1"></span>비밀번호
			      	</label>
			      	<input type="hidden" name="u_id" value="${sessionScope.sessionid}"
			             class="flex-1 bg-white-100 border border-gray-200 rounded-lg px-3 py-2 text-gray-600 focus:outline-none">
			       	<input type="password" name="u_password" class="flex-1 bg-white-100 border border-gray-200 rounded-lg px-3 py-2 text-gray-600 focus:outline-none">
			    </div>
			  <!-- 푸터 버튼 -->
			  <div class="flex flex-wrap px-6 sm:px-8 py-5 bg-gray-50 rounded-b-2xl p-5 gap-3">
			  		 <button type="button" onclick="location.href='${pageContext.request.contextPath}/mypage_main.do'"
			            class="flex-1 h-12 border border-gray-500 rounded-xl bg-white-600 text-blue font-semiboldshadow-sm hover:bg-blue-200 active:scale-[.99] transition">
			            돌아가기 </button>
			    	<button type="submit"
			            class="flex-1 h-12 rounded-xl border border-gray-500 bg-white-600 text-red font-semiboldshadow-sm hover:bg-red-200 active:scale-[.99] transition">
			            회원탈퇴 </button>
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