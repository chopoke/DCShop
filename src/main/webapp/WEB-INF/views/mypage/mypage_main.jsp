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
			
			<div class="relative inline-block">
			<img id="profileImg"
			     src="${imgUrl}"
			     alt="Profile"
			     class="rounded-full w-28 h-28 object-cover mb-4 cursor-pointer border" />
			     <label for="u_image"
				         class="absolute bottom-2 right-2 w-9 h-9 rounded-full bg-white border shadow
         						flex items-center justify-center cursor-pointer hover:shadow-md"
				         title="프로필 사진 변경">
				    <i class="ri-pencil-fill text-gray-700 text-base"></i>
				    <span class="sr-only">프로필 사진 변경</span>
				  </label>
			</div>
            <!-- <img src="resources/img_main/mypage_default.png" alt="Profile"
	               class="rounded-full w-28 h-28 object-cover mb-4"> -->
            
            <h2 class="text-lg font-semibold">${sessionScope.sessionid }</h2>
            <h2 class="text-lg font-semibold">${sessionScope.session_u_nickname }</h2>
            <p class="text-gray-500 text-sm mb-4">${sessionScope.session_u_email}</p>
            <button
               class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600"
               onclick="window.location='${path}/mypage_pwdcheck.do'">정보수정</button>

            <!-- 네비게이션 -->
            <nav class="w-full space-y-2 text-sm">
               <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">위시리스트</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">1:1 문의</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
            </nav>
			</aside>

			<!-- 메인 콘텐츠 -->
			<main class="flex-1 p-8 bg-gray-50">
				<h1 class="text-2xl font-bold mb-6">님의 마이페이지입니다.</h1>

				<!-- 주문 내역 -->
				<section class="mb-8">
					<h2 class="text-lg font-semibold mb-3">주문 내역</h2>
					<div class="relative overflow-x-auto">
						<table
							class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
							<thead
								class="text-xs text-gray-700 uppercase bg-gray-100 dark:bg-gray-700 dark:text-gray-400">
								<tr>
									<th scope="col" class="px-6 py-3 rounded-s-lg">O_Num</th>
									<th scope="col" class="px-6 py-3">ProductName</th>
									<th scope="col" class="px-6 py-3">DeliveryState</th>
									<th scope="col" class="px-6 py-3">Qty</th>
									<th scope="col" class="px-6 py-3 rounded-e-lg">Price</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty order}">
										<c:forEach var="c" items="${order}">
											<c:set var="hasPd"
												value="${not empty c.productDto and fn:length(c.productDto) gt 0}" />
											<c:set var="pd" value="${hasPd ? c.productDto[0] : null}" />

											<tr class="bg-white dark:bg-gray-800">
												<th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
													<c:out value="${pd.pdId}" />
												</th>
												<td class="px-6 py-4"><c:out value="${pd.pdName}" /></td>
												<td class="px-6 py-4"><c:out value="${c.o_Delivery_State}" /></td>
												<td class="px-6 py-4"><c:out value="${c.o_Count}" /></td>
												<td class="px-6 py-4"><c:out value="${c.o_Count * (hasPd ? pd.pdPrice : 0)}" /></td>
											</tr>
										</c:forEach>
									</c:when>

									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center py-4 text-gray-500">장바구니가
												비어 있습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tfoot>
								<tr class="font-semibold text-gray-900 dark:text-white">
									<th scope="row" class="px-6 py-3 text-base">Total</th>
									<td class="px-6 py-3"></td>
									<td class="px-6 py-3"></td>
									<td class="px-6 py-3">${productCountSum}</td>
									<td class="px-6 py-3">${productTotalPrice}</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</section>

				<section></section>

				<!-- 장바구니 -->
				<section>
					<h2 class="text-lg font-semibold mb-3">장바구니</h2>
					<div class="relative overflow-x-auto">
						<table
							class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
							<thead
								class="text-xs text-gray-700 uppercase bg-gray-100 dark:bg-gray-700 dark:text-gray-400">
								<tr>
									<th scope="col" class="px-6 py-3 rounded-s-lg">PNum</th>
									<th scope="col" class="px-6 py-3">ProductName</th>
									<th scope="col" class="px-6 py-3">DeliveryState</th>
									<th scope="col" class="px-6 py-3">Qty</th>
									<th scope="col" class="px-6 py-3 rounded-e-lg">Price</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty cart}">
										<c:forEach var="c" items="${cart}">
											<c:set var="hasPd"
												value="${not empty c.productDto and fn:length(c.productDto) gt 0}" />
											<c:set var="pd" value="${hasPd ? c.productDto[0] : null}" />

											<tr class="bg-white dark:bg-gray-800">
												<th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
													<c:out value="${pd.pdId}" />
												</th>
												<td class="px-6 py-4"><c:out value="${pd.pdName}" /></td>
												<td class="px-6 py-4"><c:out value="${pd.pdStatus}" /></td>														
												<td class="px-6 py-4"><c:out value="${c.ctQuantity}" /></td>									
												<td class="px-6 py-4"><c:out value="${pd.pdPrice}" /></td>
											</tr>
										</c:forEach>
									</c:when>

									<c:otherwise>
										<tr>
											<td colspan="5" class="text-center py-4 text-gray-500">주문
												내역이 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tfoot>
								<tr class="font-semibold text-gray-900 dark:text-white">
									<th scope="row" class="px-6 py-3 text-base">Total</th>
									<td class="px-6 py-3"></td>
									<td class="px-6 py-3"></td>
									<td class="px-6 py-3">${cartCountSum}</td>
									<td class="px-6 py-3">${cartTotalPrice}</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</section>
				
				<!-- 랜덤 : 상품 추천 -->
				<section>
				</section>
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