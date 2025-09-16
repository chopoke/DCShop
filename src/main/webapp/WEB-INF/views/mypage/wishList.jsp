<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WishList - 찜목록</title>
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
                 <a href="./wishList.do" class="block py-2 px-3 bg-gray-900 text-white rounded hover:bg-gray-100">관심상품</a>  
                 <a href="./cartList" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
                 <a href="./mypage_qna.do" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a> 
                 <a href="./mypage/my_reviews.do" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a>
                 <a href="${path}/logout.do" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
              </nav>
			</aside>

			<!-- 메인 콘텐츠 -->
			<main class="flex-1 p-8 bg-gray-50">
			
				<h1 class="text-2xl font-bold mb-6">내 찜 목록</h1>

				<section class="space-y-4">
				  <c:choose>
				    <c:when test="${empty wishList}">
				      <div class="bg-white border rounded-2xl p-10 text-center text-gray-500">
				        아직 찜한 상품이 없어요.
				      </div>
				    </c:when>
				
				    
				    <c:otherwise>
					  <c:forEach var="item" items="${wishList}">
					    <c:set var="p" value="${item.product}" />
					
					    <%-- 썸네일 경로 --%>
					    <c:choose>
					      <c:when test="${empty p.pd_image_url}">
					        <c:set var="thumb" value="/resources/img_main/noimage.png" />
					      </c:when>
					      <c:when test="${fn:startsWith(p.pd_image_url,'http') or fn:startsWith(p.pd_image_url,'/resources/')}">
					        <c:set var="thumb" value="${p.pd_image_url}" />
					      </c:when>
					      <c:otherwise>
					        <c:set var="thumb" value="/resources/image/product/${p.pd_image_url}" />
					      </c:otherwise>
					    </c:choose>
					
					    <div class="relative bg-white border rounded-2xl p-6 shadow-sm" data-wish-card>
					      <div class="grid grid-cols-[112px_1fr_170px] gap-6">
					        <!-- 썸네일 -->
					        <div class="shrink-0">
					          <div class="w-28 h-28 rounded-xl border bg-gray-50 overflow-hidden flex items-center justify-center">
					            <img src="<c:url value='${thumb}'/>"
					                 alt="${p.pd_name}"
					                 class="w-full h-full object-cover"
					                 onerror="this.src='${pageContext.request.contextPath}/resources/img_main/noimage.png'">
					          </div>
					        </div>
					
					        <!-- 상품명/가격 -->
					        <div class="flex flex-col justify-center">
					          <!-- 상세 ㅍㅔ이지 링크 -->
					          <a href="${path}//ad_shop_detailAction.pd?pdId=${p.pd_id}"
					             class="no-underline text-base md:text-lg font-semibold text-gray-900 hover:underline">
					            <c:out value="${p.pd_name}"/>
					          </a>
					
					          <%-- 가격/할인 계산 --%>
					          <c:set var="rate"        value="${empty p.pd_discount_rate ? 0 : p.pd_discount_rate}" />
					          <c:set var="hasDiscount" value="${rate gt 0 and rate lt 100}" />
					          <c:set var="discPriceInt" value="${ (p.pd_price * (100 - rate)) div 100 }" />
					
					          <p class="mt-2 text-sm text-gray-500">가격</p>
					          <div class="mt-0.5 flex items-center gap-2">
					            <c:choose>
					              <c:when test="${hasDiscount}">
					                <span class="text-xl font-bold text-gray-900">
					                  <fmt:formatNumber value="${discPriceInt}" type="number" maxFractionDigits="0"/>원
					                </span>
					                <s class="text-sm text-gray-400">
					                  <fmt:formatNumber value="${p.pd_price}" type="number" maxFractionDigits="0"/>원
					                </s>
					                <span class="text-sm text-rose-600 font-semibold">-${rate}%</span>
					              </c:when>
					              <c:otherwise>
					                <span class="text-xl font-bold text-gray-900">
					                  <fmt:formatNumber value="${p.pd_price}" type="number" maxFractionDigits="0"/>원
					                </span>
					              </c:otherwise>
					            </c:choose>
					          </div>
					
					          <c:if test="${p.pd_stock le 0}">
					            <span class="mt-1 inline-block text-xs px-2 py-0.5 rounded bg-gray-100 text-gray-500">품절</span>
					          </c:if>
					        </div>
					
					        <!-- 우측 액션 -->
					        <div class="flex flex-col items-end justify-between">
					          	<!-- 찜취소 -->
					          	<button type="button"
					              	class="px-3 py-1.5 rounded-lg border text-sm text-gray-700 hover:bg-gray-50"
					              	data-action="wish-cancel"
					              	data-pdid="${p.pd_id}">
					        	찜취소
					      		</button>
					          	<!-- 장바구니 담기 -->
					          	<form action="${path}/cart.do" method="get">
						            <input type="hidden" name="pdId" value="${p.pd_id}">
						            <input type="hidden" name="qty" value="1">
						            <button type="submit"
					                    class="px-4 py-2 rounded-xl bg-stone-500 text-white text-sm font-medium hover:bg-stone-400"
					                    <c:if test="${p.pd_stock le 0}">disabled</c:if>>
					              	장바구니 담기
					            	</button>
					          	</form>
					        </div>
					      </div>
					    </div>
					  </c:forEach>
					</c:otherwise>
				  </c:choose>
				</section>
			</main>
		</div>
	</div>

	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp"%>
	<!-- 푸터 끝 -->
<script>
	document.addEventListener('click', function (e) {
		const btn = e.target.closest('[data-action="wish-cancel"]');
		if (!btn) return;

		const pdId = btn.dataset.pdid;
		const card = btn.closest('[data-wish-card]');
		fetch('${pageContext.request.contextPath}/addWish.do', {
			method: 'POST',
			headers: {'Content-Type':'application/x-www-form-urlencoded;charset=UTF-8'},
			body: 'pdId=' + encodeURIComponent(pdId) + '&click=0'
		})
		.then(r => r.json())
		.then(j => {
			if (j && (j.success == 1 || j.success === '1')) {
				card.remove();
				if (!document.querySelector('[data-wish-card]')) {
					document.querySelector('section.space-y-4').innerHTML =
					'<div class="bg-white border rounded-2xl p-10 text-center text-gray-500">아직 찜한 상품이 없어요.</div>';
				}
			} else {
				alert('처리 중 오류가 발생했습니다.');
			}
		}).catch(() => alert('네트워크 오류가 발생했습니다.'));
	});
</script>
</body>
</html>