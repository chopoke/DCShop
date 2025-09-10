<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<fmt:setLocale value="ko_KR" />
<%-- 
  기대하는 모델:
  - cart : List<CartDTO> (각 DTO에 productDto: List<ProductDTO>)
  - user : UserDTO (uName, uEmail 등 필드)
--%>

<%-- 초기값 셋팅 --%>
<c:set var="shippingFee" value="${shippingFee}" />
<c:set var="tax" value="${tax}" />
<c:set var="itemsCount" value="0" />
<c:set var="subtotal" value="0" />
<c:set var="shippingFeeSum" value="0" />
<c:set var="dissubtotal" value="0" />
<c:set var="dissubtotalSum" value="0" />

<%-- 카트에 담긴 상품들 가져오기 --%>
<%-- 첫 번째 상품만 사용 --%>
<c:forEach var="c" items="${cart}">
	<!-- 갯수 가져오기 -->
	<c:set var="qty" value="${empty c.ctQuantity ? 1 : c.ctQuantity}" />
	<!-- 상품 ID 가져오기 -->
	<%-- <c:set var="hasPd" value="${not empty c.productDto and fn:length(c.productDto) gt 0}" /> --%>
	<!-- 상품 가격 -->
	<c:set var="pdPrice" value="${c.productDto[0].pd_price}" />
	<!-- 상품 배송비 -->
	<c:set var="pdShip" value="${c.productDto[0].pd_shipping_fee}" />
	<!-- 상품 할인 비율 -->
	<c:set var="rate" value="${c.productDto[0].pd_discount_rate}" />
	<!-- 상품 할인된 가격 가져오기 -->
	<c:set var="hasDiscount" value="${rate gt 0 and rate lt 100}" />
	<c:set var="discPriceInt" value="${ (c.productDto[0].pd_price * (100 - rate)) div 100 }" />
	<c:set var="itemsCount" value="${itemsCount + qty}" />
	<c:set var="subtotal" value="${subtotal + (pdPrice * qty)}" />
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
	<c:when test="${shippingFee == 0}">
		<c:set var="shippingFee" value="0" />
	</c:when>
	<c:when test="${dissubtotal >= 100000}">
		<c:set var="shippingFee" value="0" />
	</c:when>
	<c:otherwise>
		<c:set var="shippingFee" value="${shippingFeeSum}" />
	</c:otherwise>
</c:choose>

<!-- 배송비 총 합계  -->
<c:set var="dissubtotalSum" value="${dissubtotal + shippingFee}" />

<%-- 유저의 이름과 이메일을 가져옵니다. --%>
<c:set var="memberName" value="${user.uName}" />
<c:set var="memberEmail" value="${user.uEmail}" />

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
<link rel="stylesheet" href="${path}/resources/css/cart.css">
<link rel="stylesheet" href="${path}/resources/css/shop/cart.css">
<body
	class="bg-body-tertiary<c:if test='${not empty cart}'> has-sticky-footer</c:if>">
	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp"%>
	<!-- 헤더 끝 -->

	<section class="hero-section1"></section>





	<script>
	// 수량 증가
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
    // 수량 감소
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
   // 상품 제거
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
   	// input에서 상품 갯수 변경
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
    // 장바구니에 상품 추가
    function checkout() {
  	  
  	  const form = document.querySelector('form[name="payMent"]');
  	  // 총액
  	  const totalText   = (document.getElementById("summaryTotal")?.textContent || "").trim();
  	  const totalClient = Number(totalText.replace(/[^\d]/g, '') || 0);

  	  // 배송비
  	  const summaryShipping = (document.getElementById("summaryShipping")?.textContent || "").trim();
  	  const pdShippingFee = Number(summaryShipping.replace(/[^\d]/g, '') || 0);
  	  
  	  // 보낼 요소들 수집
  	  const items = [];
  	  document.querySelectorAll('#cartItems .cart-item').forEach(card => {
  	    const pdId    = Number(card.dataset.id);
  	    const pdName  = (card.querySelector('.fw-semibold').textContent).trim();
  	    const pdPrice = Number(card.querySelector('.price').dataset.price);
  	    const qty     = Math.max(1, parseInt(card.querySelector('.qty-input').value));
  	    const img = card.querySelector('.pd_resource_url');
  	    const pdImg	  = img.getAttribute('src');
  	    console.log(pdImg);
  	    const pdDiscountRate = Number(card.querySelector('.pd_discount_rate').value);
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

	<!-- Main -->
	<div class="container">
		<main class="container-xxl py-4">
			<div class="container-xxl py-3">
				<div class="d-flex align-items-center gap-3">
					<a href="${path}/shop_main.do"
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
								<c:set var="rate" value="${c.productDto[0].pd_discount_rate}" />
								<c:set var="hasDiscount" value="${rate gt 0 and rate lt 100}" />
								<c:set var="discPriceInt" value="${ (c.productDto[0].pd_price * (100 - rate)) div 100 }" />
								<c:set var="qty" value="${c.ctQuantity}" />
								<%-- <c:set var="hasPd" value="${not empty c.productDto and fn:length(c.productDto) gt 0}" /> --%>
								<c:set var="pd" value="${c.productDto[0]}" />
								<c:set var="price" value="${pd.pd_price}" />

								<div class="card cart-item" data-id="${c.pdId}">
									<div
										class="card-body d-flex flex-wrap gap-3 align-items-center">
										<img src="<c:url value='${pd.pd_image_url}'/>"
											alt="${pd.pd_name}" class="cart-item-thumb flex-shrink-0" />
										<input type="hidden" class="pd_resource_url"
											src="${c.productDto[0].pd_image_url}" /> <input
											type="hidden" class="pd_discount_rate" value="${rate}" />
										<div class="me-auto">
											<div class="fw-semibold">
												<c:out value="${pd.pd_name}" />
											</div>
											<div class="text-primary fw-bold price" data-price="${price}">
												<c:choose>
													<c:when test="${hasDiscount}">
														<span class="price-now money"> <fmt:formatNumber
																value="${discPriceInt}" type="currency"
																currencySymbol="₩" minFractionDigits="0"
																maxFractionDigits="0" />
														</span>
														<s class="price-old money"> <fmt:formatNumber
																value="${price}" type="currency" currencySymbol="₩"
																minFractionDigits="0" maxFractionDigits="0" />
														</s>
													</c:when>
													<c:otherwise>
														<span class="price-now money"> <fmt:formatNumber
																value="${price}" type="currency" currencySymbol="₩"
																minFractionDigits="0" maxFractionDigits="0" />
														</span>
													</c:otherwise>
												</c:choose>
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
							<a href="${path}/shop_main.do" class="btn btn-secondary btn-lg">쇼핑하러
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
										value="${dissubtotal}" type="currency" currencySymbol="₩"
										minFractionDigits="0" maxFractionDigits="0" />
								</span>
							</div>
							<fmt:parseNumber var="dissubtotalInt" value="${dissubtotal}"
								integerOnly="true" />
							<div class="d-flex justify-content-between small mb-2">
								<span class="text-body-secondary">배송비</span> <span
									id="summaryShipping" class="fw-medium"> <c:choose>
										<c:when test="${shippingFee == 0}">무료</c:when>
										<c:when test="${dissubtotalInt >= 100000}">무료</c:when>
										<c:otherwise>
											<fmt:formatNumber value="${shippingFeeSum}" type="currency"
												currencySymbol="₩" minFractionDigits="0"
												maxFractionDigits="0" />
										</c:otherwise>
									</c:choose>
								</span>
							</div>
							<div
								class="d-flex justify-content-between align-items-center mb-3">
								<span class="fw-semibold">총 결제금액</span> <span id="summaryTotal"
									class="fs-5 fw-bold text-primary"> <fmt:formatNumber
										value="${dissubtotalSum}" type="currency" currencySymbol="₩"
										minFractionDigits="0" maxFractionDigits="0" />
								</span>
							</div>
							<form name="payMent" method="post" class="w-100 w-md-auto">
								<input type="button" onclick="checkout()"
									class="btn btn-primary w-100" value="결제하기" />
							</form>
						</div>
					</div>
				</aside>
			</div>
		</main>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${path}/resources/js/cart.js"></script>

	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp"%>
	<!-- 푸터 끝 -->
</body>
</html>