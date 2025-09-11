<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>주문관리 & 장바구니</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
<script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              primary: "#3b82f6",
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
<style type="text/css">
:where([class^="ri-"])::before {
	content: "\f3c2";
}

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
	            <form id="avatarForm" action="${path}/mypage_imgUpload.do"
	               method="post" enctype="multipart/form-data">
	               <input type="hidden" name="u_id" value="${sessionScope.sessionid}">
	               <input type="file" id="u_image" name="u_image" accept="image/*"
	                  style="display: none;">
	            </form>
	            <c:choose>
	               <c:when test="${empty dto.u_image}">
	                  <c:url var="imgUrl" value="/resources/img_main/mypage_default.png" />
	               </c:when>
	               <c:otherwise>
	                  <c:url var="imgUrl"
	                     value="/resources/image/profile/${dto.u_image}" />
	               </c:otherwise>
	            </c:choose>

	            <div class="relative inline-block">
	               <img id="profileImg" src="${imgUrl}" alt="Profile"
	                  class="rounded-full w-28 h-28 object-cover mb-4 cursor-pointer border" />
	               <label for="u_image"
	                  class="absolute bottom-2 right-2 w-9 h-9 rounded-full bg-white border shadow
	                           flex items-center justify-center cursor-pointer hover:shadow-md"
	                  title="프로필 사진 변경"> <i
	                  class="ri-pencil-fill text-gray-700 text-base"></i> <span
	                  class="sr-only">프로필 사진 변경</span>
	               </label>
	            </div>
	            <!-- <img src="resources/img_main/mypage_default.png" alt="Profile"
	                  class="rounded-full w-28 h-28 object-cover mb-4"> -->
	
	            <h2 class="text-lg font-semibold">${sessionScope.sessionid }</h2>
	            <h2 class="text-lg font-semibold">${sessionScope.session_u_nickname }</h2>
	            <p class="text-gray-500 text-sm mb-4">${sessionScope.session_u_email}</p>
	            <button
	               class="px-4 py-2 bg-black text-white !rounded-lg mb-6 hover:bg-blue-600"
	               onclick="window.location='${path}/mypage_pwdcheck.do'">정보수정</button>
	
	            <!-- 네비게이션 -->
	            <nav class="w-full space-y-2 text-sm">
	                  <a href="${pageContext.request.contextPath}/mypage_editPet.do" class="block py-2 px-3 rounded hover:bg-gray-100">내 반려동물</a> 
	                  <a href="./orderList" class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a> 
	                  <a href="./cartList" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
	                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a> 
	                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a> 
	                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
               </nav>
         </aside>

			<!-- 페이지 헤더 -->
			<main class="flex-1 p-8 bg-gray-50">
				<h1 class="text-3xl font-bold text-gray-900 mb-2">주문관리</h1>


				<!-- 검색 필터 섹션 -->
				<div
					class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-6">
					<div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
						<!-- 주문기간 -->
						<div>
							<label class="block text-sm font-medium text-gray-700 mb-2">주문기간</label>
							<div class="flex items-center space-x-2">
								<input type="date"
									class="flex-1 px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" />
								<span class="text-gray-500">~</span> <input type="date"
									class="flex-1 px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" />
							</div>
						</div>

						<!-- 주문상태 -->
						<div>
							<label class="block text-sm font-medium text-gray-700 mb-2">주문상태</label>
							<select
								class="w-full px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent pr-8">
								<option>전체</option>
								<option>주문완료</option>
								<option>결제완료</option>
								<option>배송준비중</option>
								<option>배송중</option>
								<option>배송완료</option>
								<option>주문취소</option>
							</select>
						</div>
						<div></div>
						<div align="right">
							<button
								class="px-6 py-2 bg-primary text-white rounded-button text-sm font-medium hover:bg-blue-600 transition-colors whitespace-nowrap !rounded-button">
								검색</button>
						</div>
						
					</div>
				</div>

				<!-- 주문 목록 테이블 -->
				<div class="bg-white rounded-lg shadow-sm border border-gray-200">
					<!-- 테이블 상단 컨트롤 -->
					<div
						class="p-4 border-b border-gray-200 flex justify-between items-center">
						<div class="text-sm text-gray-600">
							총 <span class="font-medium text-gray-900">${paging.count}</span> 건
						</div>
					</div>

					<!-- 테이블 헤더 -->
					<div class="overflow-x-auto">
						<table class="w-full">
							<thead class="bg-gray-50">
								<tr>
									<th class="px-4 py-3 text-left"><input type="checkbox"
										class="w-4 h-4 text-primary border-gray-300 rounded focus:ring-primary" />
									</th>
									<th
										class="px-4 py-3 text-left text-sm font-medium text-gray-700">
										주문번호</th>
									<th
										class="px-4 py-3 text-left text-sm font-medium text-gray-700">
										주문일시</th>
									<th
										class="px-4 py-3 text-left text-sm font-medium text-gray-700">
										결제수단</th>
									<th
										class="px-4 py-3 text-left text-sm font-medium text-gray-700">
										결제금액</th>
									<th
										class="px-4 py-3 text-left text-sm font-medium text-gray-700">
										주문상태</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty order}">
									<c:forEach var="o" items="${order}">
										<c:set var="pd" value="${o.productDto[0]}" />
										<tr class="bg-white dark:bg-gray-800">
											<th class="px-4 py-3 text-left">
												<input type="checkbox" class="w-4 h-4 text-primary border-gray-300 rounded focus:ring-primary" />
											</th>
											<td >
												<a href="${path}/orderDetail?o_num=${o.o_Num}" class="px-6 py-4 text-gray-900 no-underline"> 
													<c:out value="${o.o_Num}" />
												</a>
											</td>
											<td class="px-6 py-4"><c:out value="${o.o_date}" /></td>
											<td class="px-6 py-4"><c:out value="${o.o_Payment}" /></td>
											<td class="px-6 py-4">
												<fmt:formatNumber value="${o.o_price}" type="number" maxFractionDigits="0"/>원
											</td>
											<td class="px-6 py-4"><c:out value="${o.o_Status}" /></td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty order}">
									<tr>
										<td colspan="8" class="px-4 py-12 text-center text-gray-500">
											조회된 주문이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>

					<!-- 페이지네이션 -->
					<div class="p-4 border-t border-gray-200 flex justify-center">
						<nav class="flex items-center space-x-1">
							<!-- 이전 버튼 (currentPage - 1) -->
							<c:if test="${paging.currentPage > 1}">
								<a href="${path}/orderList?pageNum=${paging.currentPage - 1}" 
								   class="px-3 py-2 text-sm text-gray-500 hover:text-gray-700 no-underline">
								    <i class="ri-arrow-left-s-line"></i>
								</a>
							</c:if>
							<c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
								<a href="${path}/orderList?pageNum=${num}"
									 class="px-3 py-2 text-sm rounded no-underline ${paging.currentPage == num ? 'bg-primary text-white' : 'text-gray-500 hover:text-gray-700'}"> ${num} </a>
							</c:forEach>
							<!-- 다음 버튼 (currentPage + 1) -->
							<c:if test="${paging.currentPage < paging.pageCount}">
								<a href="${path}/orderList?pageNum=${paging.currentPage + 1}" 
								   class="px-3 py-2 text-sm text-gray-500 hover:text-gray-700 no-underline">
								    <i class="ri-arrow-right-s-line"></i>
								</a>
							</c:if>
						</nav>
					</div>
				</div>
			</main>
		</div>
	</div>

	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp"%>
	<!-- 푸터 끝 -->
	<script>
		document.addEventListener('DOMContentLoaded', function(){
			const img = document.getElementById('profileImg');
			const file = document.getElementById('u_image');
			const form = document.getElementById('avatarForm');
			
			if (!img || !file || !form) return;
			
			img.addEventListener('click', () => file.click());
			
			file.addEventListener('change', () => {
				if(!file.files || !file.files[0]) return;
				form.submit();
			});
		});
	</script>
</body>
</html>
