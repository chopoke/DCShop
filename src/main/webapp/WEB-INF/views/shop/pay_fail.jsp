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

<title>결제 실패</title>
</head>
<body>

	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	
	<section class="hero-section1">
	</section>

	<div class="wrapper w-100">
		<div class="flex-column align-center w-100 max-w-540">
			<img src="https://static.toss.im/lotties/error-spot-no-loop-space-apng.png" width="160" height="160"></img>
			<h2 class="title">결제를 실패했어요</h2>
			<div class="response-section w-100">
				<div class="flex justify-between">
					<span class="response-label">code</span> 
					<span id="code" class="response-text"></span>
				</div>
				<div class="flex justify-between">
					<span class="response-label">message</span> 
					<span id="message" class="response-text"></span>
				</div>
			</div>
			<div class="w-100 button-group">
				<div class="flex" style="gap: 16px;">
					<a class="paybtn w-100" href="${path}/checkout"  rel="noreferrer noopener">다시 주문하기</a>
					<a class="paybtn w-100" href="${path}/main.do" rel="noreferrer noopener">홈으로</a>
					<!-- <a class="btn w-100" href="https://docs.tosspayments.com/reference/error-codes" target="_blank" rel="noreferrer noopener">에러코드 문서보기</a> 
					<a class="btn w-100" href="https://techchat.tosspayments.com" target="_blank" rel="noreferrer noopener">실시간 문의하기</a> -->
				</div>
			</div>
		</div>
	</div>
	
	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
<script>
	const urlParams = new URLSearchParams(window.location.search);

	const codeElement = document.getElementById("code");
	const messageElement = document.getElementById("message");

	codeElement.textContent = urlParams.get("code");
	messageElement.textContent = urlParams.get("message");
	
</script>
</html>