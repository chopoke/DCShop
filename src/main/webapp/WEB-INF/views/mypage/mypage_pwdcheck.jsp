<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - 독캣배송</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>

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
            <h1 class="text-2xl font-bold mb-6">비밀번호를 다시 한 번 입력해주세요</h1>
            <div class="mb-4 text-gray-600 flex items-center gap-2">
			  <i class="ri-lock-password-line text-lg text-red-700"></i>
			  <span>안전한 정보 수정을 위해 비밀번호를 다시 입력해주세요.</span>
			</div>

            <section>
               	<div class="p-6 bg-white rounded-lg shadow-md max-w-md">
				  	<h2 class="text-xl font-semibold mb-2">계정 보안 확인</h2>
				  	<p class="text-sm text-gray-500 mb-4">회원님의 개인정보 보호를 위해 비밀번호 확인이 필요합니다.</p>
				  
				  	<form action="${pageContext.request.contextPath}/mypage_pwdcheckAction.do" method="post" class="space-y-4">
				    	<div>
				      	<label class="block text-sm font-medium mb-1">비밀번호</label>
				      	<input type="password" name="u_password" 
				             class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500" required>
				    	</div>
				    	<button type="submit" 
				            class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700"> 확인
				    </button>
				  </form>
				</div>
               
            </section>
         </main>
      </div>
   </div>

   <!-- 푸터 시작 -->
   <%@ include file="../setting/footer.jsp"%>
   <!-- 푸터 끝 -->

</body>
</html>