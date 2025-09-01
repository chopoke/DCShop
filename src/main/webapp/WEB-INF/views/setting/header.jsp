<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Insert title here</title>
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@4.0.0/fonts/remixicon.css"
	rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${path}/resources/css/header.css">
<style>
/* CSS */
.nav-item-with-sub {
  position: relative;
  display: inline-block;
}

.sub-menu {
  display: none;
  position: absolute;
  top: 100%; /* 부모 아래에 위치 */
  left: 0;
  background: white;
  border: 1px solid #ddd;
  min-width: 150px;
  z-index: 1000;
}

.sub-menu a {
  display: block;
  padding: 8px 12px;
  color: #333;
  text-decoration: none;
}

.sub-menu a:hover {
  background-color: #f5f5f5;
}

.nav-item-with-sub:hover .sub-menu {
  display: block;
}

</style>
</head>
<body>
<header class="header1">
		<div class="header-container1">
			<div class="logo1"><img alt="" src="resources/img_main/독캣배송_아이콘만.png" width="70px"> <!-- 사이트 이름 --></div>
			<div><a href="${path}/main.do"><img alt="" src="resources/img_main/독캣배송_폰트만.png" width="250px"></a></div>
			<nav class="desktop-nav1">
				<!-- <a href="#" class="nav-link">주요</a> --> 
				<a href="#" class="nav-link1" onclick="window.location='${path}/shop_main.do'">SHOP</a>
				<%-- <a href="#" class="nav-link1" onclick="window.location='${path}/comm_main.do'">COMMUNITY</a> --%>
				<nav class="desktop-nav1">
				    <div class="nav-item-with-sub">
				        <a href="#" class="nav-link1">COMMUNITY</a>
				        <div class="sub-menu">
				            <a href="${path}/comm_main.do">공지/이벤트</a>
				            <a href="${path}/board_list" >자유</a>
				            <a href="${path}/comm_CSD.do">묘한발견(준비중)</a>
				        </div>
				    </div>
				</nav>
				
				
				<c:if test="${empty sessionScope.sessionid}">
				<a href="#" class="nav-link1" onclick="window.location='${path}/termsAgreement.do'">회원가입</a>
				</c:if>
				<c:if test="${!(empty sessionScope.sessionid)}">
				<a href="#" class="nav-link1" onclick="window.location='${path}/mypage_main.do'">나의정보</a>
				</c:if>
				
				<c:if test="${empty sessionScope.sessionid}">
				<button class="b_test" onclick="window.location='${path}/login_main.do'">로그인</button>
				</c:if>
				<c:if test="${!(empty sessionScope.sessionid)}">
				<button class="b_test" onclick="window.location='${path}/logout.do'">로그아웃</button>
				</c:if>
			</nav>
			<!-- <button class="mobile-menu-btn1" onclick="toggleMobileMenu()">
				<i class="ri-menu-line" id="menu-icon"></i>
			</button> -->
		</div>
		<!-- <div class="mobile-menu" id="mobile-menu">
			<nav class="mobile-nav">
				<a href="#" class="mobile-nav-link1">주요</a> <a href="#"
					class="mobile-nav-link1">회사소개</a> <a href="#"
					class="mobile-nav-link1">메뉴</a>
				<button class="mobile-contact-btn1">연락</button>
			</nav>
		</div> -->
	</header>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>