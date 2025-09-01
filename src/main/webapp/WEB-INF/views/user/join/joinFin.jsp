<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.fin {
	font-size: 400%;
	font-weight: 800;
	color: 	#8B6331;
}
.contact-btn2 {
	background: #EDD09F;
	color: white;
	padding: 0.5rem 1rem;
	font-size: 3rem;
	border: none;
	border-radius: 1.5rem;
	cursor: pointer;
	white-space: nowrap;
	transition: background 0.2s;
	width: 400px
}
.contact-btn1 {
	background: #EBAD5B;
	color: white;
	padding: 0.5rem 1rem;
	font-size: 3rem;
	border: none;
	border-radius: 1.5rem;
	cursor: pointer;
	white-space: nowrap;
	transition: background 0.2s;
	width: 400px
}
.hero-section1 {
	width: 100%;
	background: white;
	padding: .5rem 0;
	padding-top: 5rem;
}
</style>
</head>
<body>
<!-- 헤더 시작 -->
		<%@ include file="../../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	<section class="hero-section1">
	</section>
	<!-- <br><br><br><br><br><br>
	<div align="center" class="fin">가입되었습니다.<br>환영합니다.</div> -->
	
	<br><br>
	<div align="center">
	<img alt="" src="resources/img_main/가입성공.png" width="500px"><br><br><br><br>
	<button class="contact-btn2" onclick="window.location='${path}/login_main.do'" >로그인</button>
	<%-- <a onclick="window.location='${path}/login'"> <img alt="" src="resources/로그인으로.png" width="500px"> --%><br><br>
	<button class="contact-btn1" onclick="window.location='${path}/main.do'" >홈</button>
	<br><br>
	<%-- <a onclick="window.location='${path}/main'"> <img alt="" src="resources/홈으로.png" width="500px"></a> --%>
	</div>
	<%-- <button onclick="window.location='${path}/main'">홈</button> --%>
	<!-- 푸터 시작 -->
	<%@ include file="../../setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
</html>