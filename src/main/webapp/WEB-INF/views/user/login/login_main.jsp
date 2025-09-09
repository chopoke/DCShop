<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/customer/login_main.css">

<style type="text/css">
	body {
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
			sans-serif;
		line-height: 1.6;
		color: #333;
	}

	.main-image-section {
	/* width: 70%; */
	
	position: relative;
	min-height: 60vh;
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	
	max-width: 1280px;
	margin: 0 auto;
	padding: 0 1.5rem;
	}
	.hero-section {
	width: 100%;
	background: white;
	padding: 5rem 0;
	padding-top: 8rem;
}
.inputButton {
	background: black;
	color: white;
	padding: 0.5rem 1rem;
	font-size: 1rem;
	border: none;
	border-radius: .3rem;
	cursor: pointer;
	white-space: nowrap;
	transition: background 0.2s;
}
</style>

</head>
<body>
	<!-- 헤더 시작 -->
		<%@ include file="../../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	<section class="hero-section">
		<!-- <div class="hero-container">
			<div class="hero-content">
				<h1 class="hero-title">랜딩 페이지 제목</h1>
				<p class="hero-description">실용성 있는 디자인과 직관적이며 대담한 추상적 조합으로, 사용하기
					자연스럽고 유용한 소프트웨어를 초점에 맞춘다.</p>
				<button class="hero-btn">더보기</button>
			</div>
		</div> -->
	</section>
		<!-- 컨텐츠 시작 -->
		<section class="main-image-section" id="main-image-section" width="600px">
		
		<div id="container" >
			<div id="contents">
				<!-- 상단 중앙1 시작 -->
				<div id="section1">
					<!-- <h1 align="center">로그인</h1> -->
					<center><div id="login-image"></div></center>
				</div>
				<!-- 상단 중앙2 시작 -->
				<div id="section2" align="center">
					<div id="s2_inner">
						<div class="join">
							<form name="loginform" action="loginaction.do" method="post" >
								<!-- 2-1. 중복확인을 거치지 않았을때 0으로 설정 -->
								<input type="hidden" name="hiddenuserid" value="0">
								<table>
									<tr>
										<th>아이디</th>
										<td>
											<input type="text" class="input" name="user_id" size="20" placeholder="공백없이 20자 이내로 작성" required autofocus>
										</td>
									</tr>
									<tr>
										<th>비밀번호</th>
										<td>
											<input type="password" class="input" name="user_password" size="20" placeholder="공백없이 20자 이내로 작성" required>
										</td>
									</tr>
									
									<tr>
										<td colspan="2" style="border-bottom: none;">
											<div align="right">
												<input class="inputbutton" type="submit" value="로그인">
												<input class="inputbutton" type="reset" value="초기화">
												<input class="inputbutton" type="button" value="회원가입" onclick="window.location='${path}/join'">
											</div>
										</td>
									</tr>
								</table>
							</form>
						</div>	<!-- join end -->
					</div>
				</div>
				<!-- 상단 중앙2 끝 -->
				
			</div>
		<br><br><br><br>
		<br><br><br><br>
		   
		</div>
		</section>
		<!-- 컨텐츠 끝 -->
	<script>
	  window.onload = function() {
	    const path = "${path}"; // JSP에서 EL로 contextPath 전달
	    const images = [
	      path + "/resources/img_main/로그인2.png",
	      path + "/resources/img_main/로그인1.png"
	    ];
	    
	    const randomImage = images[Math.floor(Math.random() * images.length)];
	    document.getElementById("login-image").innerHTML =
	      '<img src="' + randomImage + '" alt="로그인 이미지" style="width:300px;">';
	  }
	</script>
	<!-- 푸터 시작 -->
	<%@ include file="../../setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
</html>