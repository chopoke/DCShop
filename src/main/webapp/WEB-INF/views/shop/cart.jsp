<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<fmt:setLocale value="ko_KR" />
<!-- 설정 값 넣기 시작 -->
<%-- 
  기대하는 모델:
  - cart : List<CartDTO> (각 DTO에 productDto: List<ProductDTO> 존재, 보통 1개)
  - user : UserDTO (uName, uEmail 등 필드)
  선택적으로 member(Map/Bean: name, email) 를 내려도 됨. 없으면 user로 대체.
--%>

<%-- 배송비/세금(금액) 기본값. shippingFee/tax가 이미 내려오면 그대로 사용 --%>
<c:set var="shippingFee" value="${empty shippingFee ? 0 : shippingFee}" />
<c:set var="tax" value="${empty tax ? 0 : tax}" />

<%-- 합계 계산: CartDTO + ProductDTO[0]만 이용 (여러 옵션이면 로직 확장) --%>
<c:set var="itemsCount" value="0" />
<c:set var="subtotal" value="0" />
<c:set var="shippingFeeSum" value="0" />

<c:forEach var="c" items="${cart}">
	<c:set var="qty" value="${empty c.ctQuantity ? 1 : c.ctQuantity}" />
	<%-- 첫 번째 상품만 사용 --%>
	<c:set var="hasPd"
		value="${not empty c.productDto and fn:length(c.productDto) gt 0}" />
	<c:set var="pdPrice" value="${hasPd ? c.productDto[0].pd_price : 0}" />
	<c:set var="pdShip"
		value="${hasPd ? c.productDto[0].pd_shipping_fee : 0}" />

	<c:set var="itemsCount" value="${itemsCount + qty}" />
	<c:set var="subtotal" value="${subtotal + (pdPrice * qty)}" />
	<c:set var="shippingFeeSum" value="${shippingFeeSum + pdShip}" />
</c:forEach>

<%-- 컨트롤러에서 shippingFee를 안 줬다면, 상품별 합산을 사용 --%>
<c:if test="${shippingFee == 0}">
	<c:set var="shippingFee" value="${shippingFeeSum}" />
</c:if>

<%-- 컨트롤러에서 tax를 안 줬다면, 예시로 10% 적용 --%>
<c:if test="${tax == 0}">
	<c:set var="tax" value="${subtotal * 0.10}" />
</c:if>

<c:set var="total" value="${subtotal + shippingFee + tax}" />

<%-- 사이드 패널 표시용: member가 없으면 user의 uName/uEmail을 사용 --%>
<c:set var="memberName"
	value="${not empty member.name ? member.name : (not empty user.uName ? user.uName : 'John Smith')}" />
<c:set var="memberEmail"
	value="${not empty member.email ? member.email : (not empty user.uEmail ? user.uEmail : 'john.smith@example.com')}" />

<!-- 설정 값 넣기 끝 -->
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SHOP-main</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/resources/css/cart.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/resources/css/cart.css">
<link rel="stylesheet" href="${path}/resources/css/main.css">
<link rel="stylesheet" href="${path}/resources/css/shop/cart.css">
<body
	class="bg-body-tertiary<c:if test='${not empty cart}'> has-sticky-footer</c:if>">
	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp"%>
	<!-- 헤더 끝 -->

	<section class="hero-section1"></section>

	<script>

   function plusFunction(pdId) {
	   const qtyId = "qty-" + pdId;
	   const el = document.getElementById(qtyId);

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
	    			window.location.href = CTX + '/cartListShow.do';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
   
   }
    
   function decFunction(pdId) {
	   const qtyId = "qty-" + pdId;
	   
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
	    			window.location.href = CTX + '/cartListShow.do';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
	   
	}
   
   function removeFunction(pdId) {
	   const qtyId = "qty-" + pdId;
	   const el = document.getElementById(qtyId);
	   
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
	    			window.location.href = CTX + '/cartListShow.do';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
	   
	}
   
    function onChangeCount(pdId, qtyVal) {
    	const qty = parseInt(qtyVal, 10) || 0;
    	
    	
    	let obj = new Object();
    	obj.pdId = pdId;
    	obj.qty = qty;
    	
    	let jsonData = JSON.stringify(obj);
		
	    $.ajax({
	    	url : CTX + '/onCQty.do',
	    	type : 'POST',
	    	data : jsonData,
	    	contentType: 'application/json;charset=UTF-8',
	    	success : function(res) {
	    		if (res.result === 'ok') {
	    			window.location.href = CTX + '/cartListShow.do';
	    		}
	    	},
	    	error : function(request, status, error) {
	    	},
	    });
	   
	}
    
 

</script>

	<!-- Main -->
	<main class="container-xxl py-4">
		<div class="container-xxl py-3">
			<div class="d-flex align-items-center gap-3">
				<a href="${path}/products.do"
					class="btn btn-light rounded-circle p-2"> <i
					class="bi bi-arrow-left"></i>
				</a>
				<h1 class="h5 mb-0 fw-semibold">
					장바구니 <small class="text-body-secondary fw-normal"
						id="itemsCountText"> (<c:out value="${itemsCount}" />개)
					</small>
				</h1>
			</div>
		</div>
		<div class="row g-4">
			<!-- Cart Items -->
			<div class="col-lg-8">

				<!-- 비어있지 않은 경우 -->
				<c:if test="${not empty cart}">
					<div class="vstack gap-3 cart-list-scroll" id="cartItems"
						role="region" aria-label="장바구니 상품 목록" tabindex="0">
						<c:forEach var="c" items="${cart}">
							<c:set var="qty" value="${empty c.ctQuantity ? 1 : c.ctQuantity}" />
							<c:set var="hasPd"
								value="${not empty c.productDto and fn:length(c.productDto) gt 0}" />
							<c:set var="pd" value="${hasPd ? c.productDto[0] : null}" />
							<c:set var="price" value="${hasPd ? pd.pd_price : 0}" />

							<div class="card cart-item" data-id="${c.pdId}">
								<div class="card-body d-flex flex-wrap gap-3 align-items-center">
									<c:choose>
										<c:when test="${hasPd and not empty pd.pd_image_url}">
											<img src="${pd.pd_image_url}" alt="${pd.pd_name}"
												class="cart-item-thumb flex-shrink-0" />
										</c:when>
										<c:otherwise>
											<div
												class="cart-item-thumb bg-body d-flex align-items-center justify-content-center">
												<i class="bi bi-image text-secondary"></i>
											</div>
										</c:otherwise>
									</c:choose>

									<div class="me-auto">
										<div class="fw-semibold">
											<c:out value="${hasPd ? pd.pd_name : '알 수 없는 상품'}" />
										</div>
										<div class="text-primary fw-bold price" data-price="${price}">
											<fmt:formatNumber value="${price}" type="currency"
												currencySymbol="₩" minFractionDigits="0"
												maxFractionDigits="0" />
										</div>
									</div>

									<!-- 수량 조절 -->
									<div class="d-flex align-items-center gap-2">
										<button type="button"
											class="btn btn-outline-secondary qty-btn js-dec"
											onclick="decFunction(${c.pdId})">
											<i class="bi bi-dash"></i>
										</button>
										<div id="qty-${c.pdId}" class="px-2 text-center qty"
											style="min-width: 2ch;">
											<input type="text" value="${qty}"
												class="form-control text-center qty-input"
												style="width: 6rem;" inputmode="numeric"
												onchange="onChangeCount(${c.pdId}, this.value)" />
										</div>
										<button type="button"
											class="btn btn-outline-secondary qty-btn js-inc"
											onclick="plusFunction(${c.pdId})">
											<i class="bi bi-plus"></i>
										</button>
									</div>

									<button type="button"
										class="btn btn-outline-danger js-remove ms-2"
										onclick="removeFunction(${c.pdId})">
										<i class="bi bi-trash"></i>
									</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<!-- 비어있는 경우 -->
				<c:if test="${empty cart}">
					<section class="text-center py-5" id="emptyCart">
						<div
							class="d-inline-flex align-items-center justify-content-center rounded-circle bg-body p-4 mb-3"
							style="width: 96px; height: 96px;">
							<i class="bi bi-cart text-secondary fs-1"></i>
						</div>
						<h3 class="h5 fw-semibold mb-2">장바구니가 비어 있습니다</h3>
						<p class="text-body-secondary mb-4">상품을 담아 결제를 시작해 보세요.</p>
						<a href="${path}/products.do" class="btn btn-secondary btn-lg">쇼핑하러
							가기</a>
					</section>
				</c:if>
			</div>

			<!-- Order Summary -->
			<aside class="col-lg-4">
				<div class="card">
					<div class="card-body">
						<div class="d-flex align-items-center gap-3 mb-3">
							<div class="avatar">
								<i class="bi bi-person"></i>
							</div>
							<div>
								<h3 class="h6 mb-1 fw-semibold">
									<c:out value="${memberName}" />
								</h3>
								<small class="text-body-secondary"> <c:out
										value="${memberEmail}" />
								</small>
							</div>
						</div>

						<hr class="my-3" />
						<div class="d-flex justify-content-between small mb-3">
							<span class="text-body-secondary">총 주문 수</span> <span
								class="fw-medium"><c:out value="${itemsCount}" /></span>
						</div>

						<h4 class="h6 fw-semibold mb-3">주문 요약</h4>

						<div class="d-flex justify-content-between small mb-2">
							<span class="text-body-secondary">상품 합계</span> <span
								id="summarySubtotal" class="fw-medium"> <fmt:formatNumber
									value="${subtotal}" type="currency" currencySymbol="₩"
									minFractionDigits="0" maxFractionDigits="0" />
							</span>
						</div>

						<div class="d-flex justify-content-between small mb-2">
							<span class="text-body-secondary">배송비</span> <span
								id="summaryShipping" class="fw-medium"> <c:choose>
									<c:when test="${shippingFee == 0}">무료</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${shippingFee}" type="currency" currencySymbol="₩" minFractionDigits="0" maxFractionDigits="0" />
									</c:otherwise>
								</c:choose>
							</span>
						</div>

						<div class="d-flex justify-content-between small mb-3">
							<span class="text-body-secondary">세금</span> <span id="summaryTax"
								class="fw-medium"> 
								<fmt:formatNumber value="${tax}" type="currency" currencySymbol="₩" minFractionDigits="0" maxFractionDigits="0" />
							</span>
						</div>

						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<span class="fw-semibold">총 결제금액</span> <span id="summaryTotal"
								class="fs-5 fw-bold text-primary"> <fmt:formatNumber value="${total}" type="currency" currencySymbol="₩" minFractionDigits="0" maxFractionDigits="0" />
							</span>
						</div>					
						<input type="button" onclick="window.location='${path}/pay.do'" class="btn btn-dark w-100" value="결제하기"/>
					</div>
				</div>
			</aside>
		</div>
	</main>

	<c:if test="${not empty cart}">
		<div id="stickyFooter"
			class="fixed-bottom bg-white border-top shadow fixed-checkout">
			<div class="container-xxl py-3">
				<div
					class="d-flex flex-column flex-md-row gap-3 align-items-center justify-content-between">
					<input type="button" onclick="window.location='${path}/pay.do'"
						class="btn btn-primary btn-lg w-100 w-md-auto px-3" value="결제하기" />
				</div>
			</div>
		</div>
	</c:if>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${path}/resources/js/cart.js"></script>

	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp"%>
	<!-- 푸터 끝 -->
</body>
</html>