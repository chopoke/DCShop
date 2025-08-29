<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
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
	<%@ include file="../setting/header.jsp" %>
	<!-- 헤더 끝 -->

	<section class="hero-section1">
	</section>
	
  <!-- 전체 컨테이너 -->
  <div class="min-h-screen flex justify-center py-8">
    <!-- 메인 래퍼 -->
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">
      
      <!-- 사이드바 -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <!-- 프로필 -->
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>

        <!-- 네비게이션 -->
        <nav class="w-full space-y-2 text-sm">
          <a href="./mypage_admin_board" class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="./mypage_admin_order" class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="./mypage_admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="./mypage_admin_qna" class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="./mypage_admin_review" class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="./mypage_admin_user" class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-2xl font-bold mb-6">${sessionid}님의 마이페이지입니다.</h1>

        <!-- 주문 내역 -->
        <h2>문의관리</h2>
        <section class="mb-8">
          <h2 class="text-lg font-semibold mb-3">주문 내역 <font size=1>최신순</font></h2>
          <div class="bg-white border rounded-lg divide-y">
            <div class="p-4 flex justify-between">
              <span>주문번호 (주문날짜) 상품명</span>
              <span class="font-semibold">$129.99</span>
            </div>
            <div class="p-4 flex justify-between">
              <span>Order #12344 (2025-08-20)</span>
              <span class="font-semibold">$69.99</span>
            </div>
          </div>
        </section>

        <!-- 위시리스트 -->
        <section>
          <h2 class="text-lg font-semibold mb-3">관심상품/장바구니</h2>
          <div class="bg-white border rounded-lg divide-y">
            <div class="p-4 flex justify-between">
              <span>Premium Headphones</span>
              <span class="font-semibold">$199.99</span>
            </div>
            <div class="p-4 flex justify-between">
              <span>Wireless Mouse</span>
              <span class="font-semibold">$49.99</span>
            </div>
          </div>
        </section>
      </main>
    </div>
  </div>

	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->

</body>
</html>