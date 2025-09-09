<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style type="text/css">
    .hero-section1 {
      width: 100%;
      background: white;
      padding: .5rem 0;
      padding-top: 5rem; /* 고정 헤더 여백 */
    }
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

      <!-- 사이드바 (네비게이션 수정 금지) -->
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
          <a href="./admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="./admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="./admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <div class="mb-6">
          <h1 class="text-2xl font-bold">관리자 대시보드</h1>
          <p class="text-sm text-gray-500 mt-1">${sessionid} 관리자님 환영합니다.</p>
        </div>

        <!-- 핵심 지표 (옵션: model에 값 있으면 표시, 없으면 0) -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 mb-8">
          <div class="bg-white rounded-xl border p-5">
            <div class="text-sm text-gray-500">게시글 수</div>
            <div class="text-2xl font-bold mt-1"><c:out value="${boardCount}" default="0"/></div>
          </div>
          <div class="bg-white rounded-xl border p-5">
            <div class="text-sm text-gray-500">주문 수</div>
            <div class="text-2xl font-bold mt-1"><c:out value="${orderCount}" default="0"/></div>
          </div>
          <div class="bg-white rounded-xl border p-5">
            <div class="text-sm text-gray-500">상품 수</div>
            <div class="text-2xl font-bold mt-1"><c:out value="${productCount}" default="0"/></div>
          </div>
          <div class="bg-white rounded-xl border p-5">
            <div class="text-sm text-gray-500">문의 수</div>
            <div class="text-2xl font-bold mt-1"><c:out value="${qnaCount}" default="0"/></div>
          </div>
          <div class="bg-white rounded-xl border p-5">
            <div class="text-sm text-gray-500">리뷰 수</div>
            <div class="text-2xl font-bold mt-1"><c:out value="${reviewCount}" default="0"/></div>
          </div>
          <div class="bg-white rounded-xl border p-5">
            <div class="text-sm text-gray-500">회원 수</div>
            <div class="text-2xl font-bold mt-1"><c:out value="${userCount}" default="0"/></div>
          </div>
        </div>

        <!-- 섹션 바로가기 버튼 6개 -->
        <section aria-label="관리자 섹션 바로가기">
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- 게시판관리 -->
            <a href="${path}/admin_board" class="group">
              <div class="bg-white border rounded-2xl p-6 hover:shadow-md transition">
                <div class="flex items-center justify-between">
                  <h3 class="text-lg font-semibold">게시판관리</h3>
                  <span class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">바로가기</span>
                </div>
                <p class="text-sm text-gray-500 mt-2">게시글 목록/검색/삭제/상세 관리</p>
                <div class="mt-4 h-10 flex items-center justify-between">
                  <span class="text-3xl font-bold"><c:out value="${boardCount}" default="0"/></span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-70 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-width="1.5" d="M4 6h16M4 12h16M4 18h7"/>
                  </svg>
                </div>
              </div>
            </a>

            <!-- 주문관리 -->
            <a href="${path}/admin_order" class="group">
              <div class="bg-white border rounded-2xl p-6 hover:shadow-md transition">
                <div class="flex items-center justify-between">
                  <h3 class="text-lg font-semibold">주문관리</h3>
                  <span class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">바로가기</span>
                </div>
                <p class="text-sm text-gray-500 mt-2">주문 현황/상태 변경/검색</p>
                <div class="mt-4 h-10 flex items-center justify-between">
                  <span class="text-3xl font-bold"><c:out value="${orderCount}" default="0"/></span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-70 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-width="1.5" d="M3 3h2l.4 2M7 13h10l3-8H6.4M7 13L5.4 5M7 13l-2 6h12m-6-6v6"/>
                  </svg>
                </div>
              </div>
            </a>

            <!-- 상품관리 -->
            <a href="${path}/admin_product" class="group">
              <div class="bg-white border rounded-2xl p-6 hover:shadow-md transition">
                <div class="flex items-center justify-between">
                  <h3 class="text-lg font-semibold">상품관리</h3>
                  <span class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">바로가기</span>
                </div>
                <p class="text-sm text-gray-500 mt-2">상품 등록/수정/재고/노출 상태</p>
                <div class="mt-4 h-10 flex items-center justify-between">
                  <span class="text-3xl font-bold"><c:out value="${productCount}" default="0"/></span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-70 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-width="1.5" d="M3 7l9-4 9 4-9 4-9-4zm0 6l9 4 9-4"/>
                  </svg>
                </div>
              </div>
            </a>

            <!-- 문의관리 -->
            <a href="${path}/admin_qna" class="group">
              <div class="bg-white border rounded-2xl p-6 hover:shadow-md transition">
                <div class="flex items-center justify-between">
                  <h3 class="text-lg font-semibold">문의관리</h3>
                  <span class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">바로가기</span>
                </div>
                <p class="text-sm text-gray-500 mt-2">상품/주문 관련 문의 응대</p>
                <div class="mt-4 h-10 flex items-center justify-between">
                  <span class="text-3xl font-bold"><c:out value="${qnaCount}" default="0"/></span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-70 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-width="1.5" d="M8 10h8M8 14h5M21 12c0 4.97-4.48 9-10 9a10.9 10.9 0 01-4-.75L3 21l.75-4A9.93 9.93 0 013 12C3 7.03 7.48 3 13 3s8 4.03 8 9z"/>
                  </svg>
                </div>
              </div>
            </a>

            <!-- 리뷰관리 -->
            <a href="${path}/admin_review" class="group">
              <div class="bg-white border rounded-2xl p-6 hover:shadow-md transition">
                <div class="flex items-center justify-between">
                  <h3 class="text-lg font-semibold">리뷰관리</h3>
                  <span class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">바로가기</span>
                </div>
                <p class="text-sm text-gray-500 mt-2">리뷰 모니터링/필터/신고처리</p>
                <div class="mt-4 h-10 flex items-center justify-between">
                  <span class="text-3xl font-bold"><c:out value="${reviewCount}" default="0"/></span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-70 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-width="1.5" d="M12 17l-5.878 3.09L7 13.545 2 9.41l6.061-.877L12 3l3.939 5.533L22 9.41l-5 4.136 1.878 6.545z"/>
                  </svg>
                </div>
              </div>
            </a>

            <!-- 회원관리 -->
            <a href="${path}/admin_user" class="group">
              <div class="bg-white border rounded-2xl p-6 hover:shadow-md transition">
                <div class="flex items-center justify-between">
                  <h3 class="text-lg font-semibold">회원관리</h3>
                  <span class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">바로가기</span>
                </div>
                <p class="text-sm text-gray-500 mt-2">가입/권한/탈퇴/통계</p>
                <div class="mt-4 h-10 flex items-center justify-between">
                  <span class="text-3xl font-bold"><c:out value="${userCount}" default="0"/></span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-70 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-width="1.5" d="M16 14a4 4 0 10-8 0m12 4v-1a7 7 0 00-14 0v1m7-11a4 4 0 110-8 4 4 0 010 8z"/>
                  </svg>
                </div>
              </div>
            </a>
          </div>
        </section>

        <!-- 하단 여백 -->
        <div class="h-6"></div>
      </main>
    </div>
  </div>

  <!-- 푸터 시작 -->
  <%@ include file="../setting/footer.jsp" %>
  <!-- 푸터 끝 -->

</body>
</html>
