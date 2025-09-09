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


.fixed-table {
  width: 800px;               /* 전체 가로 폭 */
  table-layout: fixed;        /* 셀 폭을 고정(내용에 안 끌려감) */
  border-collapse: collapse;
  white-space: nowrap;        /* 줄바꿈 금지 */
}

.fixed-table td, .fixed-table th {
  border: 1px solid #ddd;
  padding: 8px;
  vertical-align: middle;
}

.cell-scroll {
  max-width: 100%;            /* 셀 너비만큼만 표시 */
  white-space: nowrap;        /* 줄바꿈 금지 */
  overflow-x: auto;           /* 가로 스크롤 허용 */
  overflow-y: hidden;
  -webkit-overflow-scrolling: touch; /* 모바일 관성 스크롤 */
}

.cell-scroll::-webkit-scrollbar { height: 6px; }  /* 선택: 스크롤바 얇게 */
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
          <a href="./admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="./admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="./admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="./admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="./admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="./admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>
      <!-- 메인 콘텐츠 -->
      <main class="flex-1 min-w-0 p-8 bg-gray-50">
        <!-- 주문 내역 -->
        <section class="mb-8">
        <h2>회원관리</h2>
          <h2 class="text-lg font-semibold mb-3">가입 회원 <font size=1>최신순</font></h2>
            <form>
            	<table border="1" class="fixed-table">
	            	<thead>
					    <tr>
					      <th class="border border-gray-200 px-3 py-2">회원번호</th>
					      <th class="border border-gray-200 px-3 py-2">아이디</th>
					      <th class="border border-gray-200 px-3 py-2">이름</th>
					      <th class="border border-gray-200 px-3 py-2">주소</th>
					      <th class="border border-gray-200 px-3 py-2">이메일</th>
					      <th class="border border-gray-200 px-3 py-2">생년월일</th>
					      <th class="border border-gray-200 px-3 py-2">닉네임</th>
					      <th class="border border-gray-200 px-3 py-2">가입일</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach var="dto" items="${list}">
					    <tr>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_member_id}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_id}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_name}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_address}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_email}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_birthday}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_nickname}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_regdate}</div></td>
					    </tr>
					    </c:forEach>
					  </tbody>
            	</table>
            </form>
            <h2 class="text-lg font-semibold mb-3">탈퇴 회원 <font size=1>탈퇴순</font></h2>
            <form>
            	<table border="1" class="fixed-table">
	            	<thead>
					    <tr>
					      <th class="border border-gray-200 px-3 py-2">회원번호</th>
					      <th class="border border-gray-200 px-3 py-2">아이디</th>
					      <th class="border border-gray-200 px-3 py-2">이름</th>
					      <th class="border border-gray-200 px-3 py-2">주소</th>
					      <th class="border border-gray-200 px-3 py-2">이메일</th>
					      <th class="border border-gray-200 px-3 py-2">생년월일</th>
					      <th class="border border-gray-200 px-3 py-2">닉네임</th>
					      <th class="border border-gray-200 px-3 py-2">가입일</th>
					      <th class="border border-gray-200 px-3 py-2">탈퇴일</th>
					    </tr>
					  </thead>
					  <tbody>
					    <c:forEach var="dto" items="${list}">
					    <tr>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_member_id}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_id}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_name}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_address}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_email}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_birthday}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_nickname}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">${dto.u_regdate}</div></td>
					      <td class="border border-gray-200 px-3 py-2"><div class="cell-scroll">null</div></td>
					    </tr>
					    </c:forEach>
					  </tbody>
            	</table>
            </form>
        </section>
        <!-- 위시리스트 -->
      </main>
    </div>
  </div>
	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
</html>