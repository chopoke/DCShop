<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<fmt:setLocale value="ko_KR" />
<c:set var="shippingFeeSum" value="0" />
<c:set var="dissubtotal" value="0" />
<c:set var="dissubtotalSum" value="0" />

<c:forEach var="c" items="${cart}">

	<!-- 상품 배송비 -->
	<c:set var="pdShip" value="${c.productDto[0].pdShippingFee}" />
		<!-- 갯수 가져오기 -->
	<c:set var="qty" value="${c.ctQuantity}" />
	<!-- 상품 할인 비율 -->
	<c:set var="rate" value="${c.productDto[0].pdDiscountRate}" />
	<!-- 상품 할인된 가격 가져오기 -->
	<c:set var="hasDiscount" value="${rate gt 0 and rate lt 100}" />
	<c:set var="discPriceInt" value="${ (c.productDto[0].pdPrice * (100 - rate)) div 100 }" />
	<c:set var="dissubtotal" value="${dissubtotal + (discPriceInt * qty)}" />
	
	<%-- 배송비 0원이 있으면 플래그 true --%>
	<c:if test="${pdShip == 0}">
		
		<c:set var="hasFreeShipping" value="true" />
	</c:if>
	
	<%-- 무료배송이 아닌 경우 최대 배송비 계산 --%>
	<c:if test="${pdShip gt shippingFeeSum}">
		<c:set var="shippingFeeSum" value="${pdShip}" />
	</c:if>
	
</c:forEach>

<%-- 플래그에 따라 최종 배송비 확정 --%>
<c:choose>

	<c:when test="${hasFreeShipping}">
		<c:set var="shippingFee" value="0" />
	</c:when>
	<c:when test="${dissubtotal >= 100000}">
		<c:set var="shippingFee" value="0" />
	</c:when>
	<c:otherwise>
		<c:set var="shippingFee" value="${shippingFeeSum}" />
	</c:otherwise>
	
</c:choose>

<c:set var="dissubtotalSum" value="${dissubtotal + shippingFee}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - 독캣배송</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<script type="text/javascript">

	// 선택한 제품 삭제하기
	function deleteSelected() {
	  const selected = document.querySelectorAll(".cart-item-checkbox:checked");
	  if (selected.length === 0) {
	    alert("삭제할 상품을 선택해주세요.");
	    return;
	  }
	  
	  // 체크된 항목의 pd_id / ct_num 수집
	  const items = Array.from(selected, cb => ({
	    pdId: Number(cb.value),
	    ctId: Number(cb.dataset.ctId)
	  }));
	  console.log(items);
	  
	  if (!confirm(`선택한 ${selected.length}개 상품을 삭제하시겠습니까?`)) return;
	 
	  $.ajax({
	    	url : CTX + '/decsQty.do',
	    	type : 'POST',
	    	data: JSON.stringify({ items }),
	    	contentType: 'application/json;charset=UTF-8',
	    	success : function(res) {
	    		if (res.result === 'ok') {
	    			window.location.href = CTX + '/cartList';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	   });
	}
	
	document.addEventListener('DOMContentLoaded', () => {
		  const selectAll = document.getElementById('selectAll');
		  const items = document.querySelectorAll('.cart-item-checkbox');

		  // 1) 전체 체크 → 모두 토글
		  selectAll.addEventListener('change', () => {
		    items.forEach(cb => cb.checked = selectAll.checked);
		    selectAll.indeterminate = false; // 부분 체크 상태 해제
		  });

		  // 2) 개별 체크 → 전체 체크/부분 체크 상태 갱신
		  items.forEach(cb => {
		    cb.addEventListener('change', () => {
		      const total = items.length;
		      const checked = document.querySelectorAll('.cart-item-checkbox:checked').length;

		      selectAll.checked = (checked == total);
		      if(checked == total) {
		      	selectAll.indeterminate = (checked > 0 && checked < total);
		      }
		    });
		 });
	});
	
	
	// 수량 증가
   function plusFunction(pdId) {
		console.log(pdId);
		let obj = new Object();
		obj.pdId = pdId;
		   
		let jsonData = JSON.stringify(obj);
	    $.ajax({
	    	url : CTX + '/incQty.do',
	    	type : 'POST',
	    	data : jsonData,
	    	contentType: 'application/json;charset=UTF-8',
	    	success : function(res) {
	    		if (res.result === 'ok') {
	    	        // 해당 카드의 수량 텍스트 교체
	    			//document.getElementById(qtyId).textContent = res.qty;
	    			window.location.href = CTX + '/cartList';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
   
   }
    // 수량 감소
   function decFunction(pdId) {

		let obj = new Object();
		obj.pdId = pdId;
		   
		let jsonData = JSON.stringify(obj);
	    $.ajax({
	    	url : CTX + '/dicQty.do',
	    	type : 'POST',
	    	data : jsonData,
	    	contentType: 'application/json;charset=UTF-8',
	    	success : function(res) {
	    		if (res.result === 'ok') {
	    	        // 해당 카드의 수량 텍스트 교체
	    			//document.getElementById(qtyId).textContent = res.qty;
	    			window.location.href = CTX + '/cartList';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
	   
	}
   
   // 상품 제거
   function removeFunction(pdId, button) {
	   
	   if (confirm("상품을 삭제하시겠습니까?")) {
		  
       } else {
    	   return false;
       }
	   
		let obj = new Object();
		obj.pdId = pdId;
		   
		let jsonData = JSON.stringify(obj);
	    $.ajax({
	    	url : CTX + '/decQty.do',
	    	type : 'POST',
	    	data : jsonData,
	    	contentType: 'application/json;charset=UTF-8',
	    	success : function(res) {
	    		if (res.result === 'ok') {
	    			button.closest("tr").remove();
	    			window.location.href = CTX + '/cartList';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
	   
	}
   
   
   function checkout() {
	   const form = document.querySelector('form[name="payMent"]');
	   
	   const totalText = (document.getElementById("finalAmount").textContent).trim();
	   const totalClient = Number(totalText.replace(/[^\d]/g, '') || 0);

	   
	   const summaryShipping = (document.getElementById("shippingFee").textContent).trim();
	   const pdShippingFee = Number(summaryShipping.replace(/[^\d]/g, '') || 0);
	   
	   const rows = document.querySelectorAll("#cartItems tr.cart-row");
	   
	   const items = [];
	   rows.forEach(row => {
		   const pdId = (row.dataset.pdId);
		   const pdName = (row.querySelector(".pd-name").textContent).trim();
		   const pdPriceValue = (row.querySelector(".order-amount").textContent).trim();
		   const pdPrice = Number(pdPriceValue.replace(/[^\d]/g, '') || 0);
		   const qty = (row.querySelector(".pd-qty").textContent).trim();
		   const pdImg  = (row.querySelector(".pd-img").value);
		   const pdDiscountRate = (row.querySelector(".pd-discount").value);
		   items.push({ pdId, pdName, pdPrice, qty, pdImg, pdDiscountRate });
	   });
	   
	  add('_payload', JSON.stringify({ items, pdShippingFee, totalClient }));

  	  form.method = 'post';
  	  form.action = CTX + '/payQty.do';
  	  form.submit();

	  function add(name, value) {
	  	    const input = document.createElement('input');
	  	    input.type = 'hidden';
	  	    input.name = name;
	  	    input.value = value;
	  	    input.setAttribute('data-dyn','1');
	  	    form.appendChild(input);
	  }
   }
     

</script>
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
					class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600"
					onclick="window.location='${path}/mypage_pwdcheck.do'">정보수정</button>
				
				<!-- 네비게이션 -->
				<nav class="w-full space-y-2 text-sm">
					<a href="./orderList"
						class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a> <a
						href="#" class="block py-2 px-3 rounded hover:bg-gray-100">위시리스트</a>
					<a href="./cartList"
						class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> <a
						href="#" class="block py-2 px-3 rounded hover:bg-gray-100">1:1
						문의</a> <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a>
					<a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a>
					<a href="#"
						class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
				</nav>
			</aside>

			<!-- 메인 콘텐츠 -->
			<main class="flex-1 p-8 bg-gray-50">
				<h1 class="text-3xl font-bold text-gray-900 mb-2">장바구니</h1>
				<c:out value="${hasFreeShipping}">dd</c:out>
				<div class="d-flex justify-content-between align-items-center mb-3">
					<div class="text-secondary small">
						주문한 상품 총: <strong id="totalItemsCount">${cartCountSum}</strong>개
					</div>

					<button id="deleteSelectedBtn"
						class="btn btn-outline-secondary btn-sm"
						onclick="deleteSelected()">선택상품 삭제</button>
				</div>

				<!-- 장바구니 상품 목록 -->
				<div class="card shadow-sm mb-4">
					<div class="card-body p-0">
						<div class="table-responsive">
							<table class="table align-middle mb-0">
								<thead class="table-light">
									<tr>
										<th class="ps-3"><input class="form-check-input"
											type="checkbox" id="selectAll" /></th>
										<th>상품정보</th>
										<th class="text-center">수량</th>
										<th class="text-end">상품금액</th>
										<th class="text-end">주문금액</th>
										<th class="text-center">삭제</th>
									</tr>
								</thead>
								<tbody class="border-top" id="cartItems">
										
										<c:forEach var="item" items="${cart}">
											
											<div id="cart-item" data-id="${item.pdId}"></div>
											<c:set var="pd" value="${item.productDto[0]}" />
											<c:set var="rate" value="${pd.pdDiscountRate}" />
											<c:set var="hasDiscount" value="${rate gt 0 and rate lt 100}" />
											<c:set var="discPriceInt" value="${ (pd.pdPrice * (100 - rate)) div 100 }" />
											<tr class="cart-row" data-pd-id="${item.pdId}" data-ct-id="${item.ctNum}">
												<td class="ps-3">
													<input class="form-check-input cart-item-checkbox" type="checkbox"
														value="${item.pdId}" data-ct-id="${item.ctNum}" />
												</td>
												<td>
													<div class="d-flex align-items-center gap-3">
														<input type="hidden" class="pd-img" value="<c:out value="${pd.pdImageUrl}"/>">
														<input type="hidden" class="pd-discount" value="<c:out value="${pd.pdDiscountRate}"/>">
														<img src="<c:url value="${pd.pdImageUrl}"/>" alt="상품 이미지"
															class="rounded w-16 h-16 object-cover" width="64" height="64" />
														<div>
															<div class="fw-semibold pd-name">
																<c:out value="${pd.pdName}" />
															</div>

															<div class="text-secondary small mt-1">
																<c:if test="${pd.pdOption != ''}">
																${pd.pdOption}
															</c:if>
															</div>
														</div>
													</div>
												</td>
												<td class="text-center">
													<div class="d-inline-flex align-items-center gap-2">
														<button class="btn btn-outline-secondary btn-sm"
															onclick="decFunction(${item.pdId})" aria-label="수량 감소">
															<i class="bi bi-dash"></i>
														</button>

														<span class="quantity-display fw-semibold pd-qty"> 
															<c:out value="${item.ctQuantity}" />
														</span>

														<button class="btn btn-outline-secondary btn-sm"
															onclick="plusFunction(${item.pdId})" aria-label="수량 증가">
															<i class="bi bi-plus"></i>
														</button>
													</div>
												</td>
												
												<td class="text-end fw-semibold ">
													
												
													<c:choose>
														<c:when test="${hasDiscount}">
															<span class="price-now money"> <fmt:formatNumber
																	value="${discPriceInt}" type="currency"
																	currencySymbol="₩" minFractionDigits="0"
																	maxFractionDigits="0" />
															</span>
															<s class="price-old money order-amount"> <fmt:formatNumber
																	value="${pd.pdPrice}" type="currency" currencySymbol="₩"
																	minFractionDigits="0" maxFractionDigits="0" />
															</s>
														</c:when>
														<c:otherwise>
															<span class="price-now money order-amount"> <fmt:formatNumber
																	value="${pd.pdPrice}" type="currency" currencySymbol="₩"
																	minFractionDigits="0" maxFractionDigits="0" />
															</span>
														</c:otherwise>
													</c:choose>
												
												</td>
												
												
												<td class="text-end fw-bold">
													<fmt:formatNumber value="${discPriceInt * item.ctQuantity}" type="currency" currencySymbol="₩"
																	minFractionDigits="0" maxFractionDigits="0" />
														
												</td>
												<td class="text-center">
													<button class="btn btn-link text-secondary px-2"
														onclick="removeFunction(${item.pdId}, this)"
														aria-label="삭제">
														<i class="bi bi-x-lg"></i>
													</button>
												</td>
											</tr>
										</c:forEach>
										
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- 주문 요약 및 액션 버튼 (교체본) -->
				<div class="card shadow-sm rounded-3">
					<div class="card-body">
						<div class="d-flex flex-wrap align-items-center gap-3">

							
							<div
								class="ms-auto d-flex align-items-center gap-3 flex-wrap justify-content-end">

								<div class="text-end fw-bold order-amount">
									<div class="text-secondary small">총 상품금액</div>
									<div class="fs-5 fw-semibold" id="totalAmount">
										<fmt:formatNumber value="${dissubtotal}" type="currency"
											currencySymbol="₩" minFractionDigits="0"
											maxFractionDigits="0" />
									</div>
								</div>

								<span class="text-secondary d-none d-md-inline">+</span>
								<div class="vr d-none d-md-block"></div>

								<div class="text-end">
									<div class="text-secondary small">배송비</div>
									<div class="fs-5 fw-semibold" id="shippingFee">
										<c:choose>
											<c:when test="${shippingFee == 0}">무료</c:when>
											<c:when test="${discPriceInt >= 100000}">무료</c:when>
											<c:otherwise>
												<fmt:formatNumber value="${shippingFeeSum}" type="currency"
													currencySymbol="₩" minFractionDigits="0"
													maxFractionDigits="0" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>

								<span class="text-secondary d-none d-md-inline">=</span>
								<div class="vr d-none d-md-block"></div>

								<div class="text-end">
									<div class="text-secondary small">총 결제금액</div>
									<div class="fs-4 fw-bold text-primary" id="finalAmount">

										<fmt:formatNumber value="${dissubtotalSum}" type="currency"
											currencySymbol="₩" minFractionDigits="0"
											maxFractionDigits="0" />
									</div>
								</div>
								<form name="payMent" method="post"
									class="btn btn-primary btn-lg ms-sm-2 mt-2 mt-sm-0">
									<input type="button" onclick="checkout()"
										class="btn btn-primary w-100" value="결제하기" />
								</form>
							</div>
						</div>
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
