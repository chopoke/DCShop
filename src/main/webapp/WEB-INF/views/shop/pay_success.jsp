<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/shop/pay.css">
<link rel="stylesheet" href="${path}/resources/css/footer.css">
<link rel="stylesheet" href="${path}/resources/css/header.css">
<link rel="stylesheet" href="${path}/resources/css/main.css">

<title>결제 성공</title>
</head>
<body>
	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	
	<section class="hero-section1">
	</section>
	
	
	<div class="wrapper w-100">
		<div class="flex-column align-center w-100 max-w-540">
			<img src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" width="120" height="120"></img>
			<h2 class="title">결제를 완료했어요</h2>
			<div class="response-section w-100">
				<div class="flex justify-between">
					<span class="response-label">결제 금액</span> 
					<span id="amount" class="response-text"></span>
				</div>
				<div class="flex justify-between">
					<span class="response-label">주문번호</span> 
					<span id="orderId" class="response-text"></span>
				</div>
				<!-- <div class="flex justify-between">
					<span class="response-label">paymentKey</span> 
					<span id="paymentKey" class="response-text"></span>
				</div>
				<div class="flex justify-between">
					<span class="response-label">paymentType</span> 
					<span id="paymentType" class="response-text"></span>
				</div> -->
			</div>

			<div class="w-100 button-group">
				<div class="flex" style="gap: 16px;">
					<a class="paybtn w-100" href="#">주문내역</a> 
					<a class="paybtn w-100" href="${path}/main.do" rel="noreferrer noopener">홈화면</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->

	<script>
		// 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
		// 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
		const urlParams = new URLSearchParams(window.location.search);
		const paymentKey = urlParams.get("paymentKey");
		const orderId = urlParams.get("orderId");
		const amount = urlParams.get("amount");
		const paymentType = urlParams.get("paymentType");
		const orderInfo = urlParams.get("orderInfo");

		async function confirm() {
			const requestData = {
				paymentKey : paymentKey,
				orderId : orderId,
				amount : amount,
				orderInfo: orderInfo ? JSON.parse(decodeURIComponent(orderInfo)) : null
			};

			const response = await fetch("${path}/pay_confirm", {
				method : "POST",
				headers : {
					"Content-Type" : "application/json",
				},
				body : JSON.stringify(requestData),
			});

			const json = await response.json();

			if (!response.ok) {
				// 결제 실패 비즈니스 로직을 구현하세요.
				console.log(json);
				
				window.location.href = `${path}/pay_fail?message=${json.message}&code=${json.code}`;
			}

			// 결제 성공 비즈니스 로직을 구현하세요.
			console.log(json);
		}
		confirm();

		const paymentKeyElement = document.getElementById("paymentKey");
		const orderIdElement = document.getElementById("orderId");
		const amountElement = document.getElementById("amount");
		const paymentTypeElement = document.getElementById("paymentType");

		orderIdElement.textContent = orderId;
		amountElement.textContent = amount;
		paymentKeyElement.textContent = paymentKey;
		paymentTypeElement.textContent = paymentType;
	</script>
</body>
</html>