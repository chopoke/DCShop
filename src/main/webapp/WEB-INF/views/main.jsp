<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="setting/setting.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>독캣배송</title>
</head>
<link rel="stylesheet" href="${path}/resources/css/main.css">

<style>

</style>
<body>
	<!-- 헤더 시작 -->
		<%@ include file="setting/header.jsp" %>
	<!-- 헤더 끝 -->
	
	<section class="hero-section1">
		<!-- <div class="hero-container">
			<div class="hero-content">
				<h1 class="hero-title">랜딩 페이지 제목</h1>
				<p class="hero-description">실용성 있는 디자인과 직관적이며 대담한 추상적 조합으로, 사용하기
					자연스럽고 유용한 소프트웨어를 초점에 맞춘다.</p>
				<button class="hero-btn">더보기</button>
			</div>
		</div> -->
	</section>
	<section class="main-image-section" id="main-image-section" width="600px">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  
  <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel"  align="center">
    <div class="carousel-inner">
      <!-- 첫 번째 이미지 -->
      <div class="carousel-item active" >
        <img height="600px" src="resources/img_main/메인_강아지1.jpg" class="d-block w-100" alt="강아지 이미지1" />
        <div class="carousel-caption d-none d-md-block text-start">
          <br>
			<div class="main-image-content">
				<div class="main-image-text">
					<h2 class="main-image-title">사랑스러운 <br>반려동물과 함께</h2>
					<p class="main-image-description">건강하고 행복한 반려동물을 위한 프리미엄 용품과
						<br>서비스를 제공합니다.</p>
					<div class="main-image-buttons">
						<button class="primary-btn" onclick="window.location='${path}/shop_main.do'">SHOP</button>
						<button class="secondary-btn" onclick="window.location='${path}/board_list'">COMM</button>
					</div>
				</div>
			</div>
        </div>
      </div>
      
      <!-- 두 번째 이미지 -->
      <div class="carousel-item">
        <img height="600px" src="resources/img_main/메인_고양이1.jpg" class="d-block w-100" alt="이미지 2" />
        <div class="carousel-caption d-none d-md-block text-start">
          <br>
			<div class="main-image-content">
				<div class="main-image-text">
					<h2 class="main-image-title">사랑스러운 <br>반려동물과 함께</h2>
					<p class="main-image-description">건강하고 행복한 반려동물을 위한 프리미엄 용품과
						<br>서비스를 제공합니다.</p>
					<div class="main-image-buttons">
						<button class="primary-btn" onclick="window.location='${path}/shop_main.do'">SHOP</button>
						<button class="secondary-btn" onclick="window.location='${path}/board_list'">COMM</button>
					</div>
				</div>
			</div>
        </div>
      </div>

      <!-- 세 번째 이미지 -->
      <div class="carousel-item">
        <img height="600px" src="resources/img_main/메인_같이.png" class="d-block w-100" alt="이미지 3" />
        <div class="carousel-caption d-none d-md-block text-start">
          <br>
			<div class="main-image-content">
				<div class="main-image-text">
					<h2 class="main-image-title">사랑스러운 <br>반려동물과 함께</h2>
					<p class="main-image-description">건강하고 행복한 반려동물을 위한 프리미엄 용품과
						<br>서비스를 제공합니다.</p>
					<div class="main-image-buttons">
						<button class="primary-btn" onclick="window.location='${path}/shop_main.do'">SHOP</button>
						<button class="secondary-btn" onclick="window.location='${path}/board_list'">COMM</button>
					</div>
				</div>
			</div>
        </div>
      </div>
      
      <!-- 네 번째 이미지 -->
      <div class="carousel-item">
        <img height="600px" src="resources/img_main/메인_커뮤2.png" class="d-block w-100" alt="이미지 4" />
        <div class="carousel-caption d-none d-md-block text-start">
          <br>
			<div class="main-image-content">
				<div class="main-image-text">
					<h2 class="main-image-title">사랑스러운 <br>반려동물과 함께</h2>
					<p class="main-image-description">건강하고 행복한 반려동물을 위한 프리미엄 용품과
						<br>서비스를 제공합니다.</p>
					<div class="main-image-buttons">
						<button class="primary-btn" onclick="window.location='${path}/shop_main.do'">SHOP</button>
						<button class="secondary-btn" onclick="window.location='${path}/board_list'">COMM</button>
					</div>
				</div>
			</div>
        </div>
      </div>
    </div>
    
    

    <!-- 캐러셀 네비게이션 -->
    <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</section>
	
	<section class="product-section">
	  <div class="container">
	  <!-- 멍 파트 -->
	  	<div align="center"><a href="${path }/shop_main.do?petType=1"><img height="100px" src="resources/img_main/icon/멍3.png" alt="" /></a></div>
	    <!-- <h2 class="product-title">멍</h2> -->
	
	    <!-- 자동재생 / 3초마다 전환 -->
	    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 못쓰면 아래 fmt줄을 그냥 ${product.price}로 바꾸세요 --%>

		<div id="productCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
		  <div class="carousel-inner">
		
		    <c:forEach var="product" items="${list_d}" varStatus="s">
				
		      <!-- 슬라이드 시작 (3개 단위) -->
		      <c:if test="${s.index % 3 == 0}">
		        <c:choose>
		          <c:when test="${s.index == 0}">
		            <div class="carousel-item active">
		          </c:when>
		          <c:otherwise>
		            <div class="carousel-item">
		          </c:otherwise>
		        </c:choose>
		          <div class="row">
		      </c:if>
		
		      <!-- 상품 카드 -->
		      <div class="col-md-4">
		        <div class="product-card"> 
			        <a class="click_card" href="${path}/ad_shop_detailAction.pd?pdId=${product.pd_id}">
			          <div class="product-image">
			            <img src="${path}${product.pd_image_url}" alt="${product.pd_name}" class="d-block w-100">
			          </div>
			          <h3 class="product-card-title">${product.pd_name}</h3>
			          <p class="product-card-description">
			            ${product.pd_brand}<br>
			            ₩<fmt:formatNumber value="${product.pd_price}" pattern="#,###"/>
			            <%-- fmt 못쓰면: ₩${product.price} --%>
			          </p>
		          	</a>
		        </div>
		      </div>
		
		      <!-- 슬라이드 끝 (3개 단위 또는 마지막에서 닫기) -->
		      <c:if test="${s.index % 3 == 2 || s.last}">
		          </div> <!-- .row -->
		        </div>   <!-- .carousel-item -->
		      </c:if>
		    </c:forEach>
		  </div>
	  </div>
	 
	</section>
	
	<!-- 냥 파트 -->
	<div align="center"><hr width="400px"></div>
	<section class="product-section">
	  <div class="container">
	  	<div align="center"><a href="${path }/shop_main.do?petType=2"><img height="100px" src="resources/img_main/icon/냥1.png" alt="" /></a></div>
	    <!-- <h2 class="product-title">멍</h2> -->
	
	    <!-- 자동재생 / 3초마다 전환 -->
	    <div id="productCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
		  <div class="carousel-inner">
		
		    <c:forEach var="product" items="${list_c}" varStatus="s">
				
		      <!-- 슬라이드 시작 (3개 단위) -->
		      <c:if test="${s.index % 3 == 0}">
		        <c:choose>
		          <c:when test="${s.index == 0}">
		            <div class="carousel-item active">
		          </c:when>
		          <c:otherwise>
		            <div class="carousel-item">
		          </c:otherwise>
		        </c:choose>
		          <div class="row">
		      </c:if>
		
		      <!-- 상품 카드 -->
		      <div class="col-md-4">
		        <div class="product-card"> 
			        <a class="click_card" href="${path}/ad_shop_detailAction.pd?pdId=${product.pd_id}">
			          <div class="product-image">
			            <img src="${path}${product.pd_image_url}" alt="${product.pd_name}" class="d-block w-100">
			          </div>
			          <h3 class="product-card-title">${product.pd_name}</h3>
			          <p class="product-card-description">
			            ${product.pd_brand}<br>
			            ₩<fmt:formatNumber value="${product.pd_price}" pattern="#,###"/>
			            <%-- fmt 못쓰면: ₩${product.price} --%>
			          </p>
		          	</a>
		        </div>
		      </div>
		
		      <!-- 슬라이드 끝 (3개 단위 또는 마지막에서 닫기) -->
		      <c:if test="${s.index % 3 == 2 || s.last}">
		          </div> <!-- .row -->
		        </div>   <!-- .carousel-item -->
		      </c:if>
		    </c:forEach>
		  </div>
	  </div>
	
	     
	  
	</section>
	
	<div align="center"><hr width="400px"></div>
	
	<section class="product-section">
		<div class="product-container">
			<h2 class="product-title">서비스</h2>
			<div class="product-grid">
				
				<div class="product-card">
					<div class="product-image">
						<img
							src="https://readdy.ai/api/search-image?query=Modern pet store interior with organized shelves of pet food, toys, and accessories, clean bright lighting, professional retail environment, colorful pet products display&width=300&height=200&seq=store1&orientation=landscape"
							alt="스토어">
					</div>
					<h3 class="product-card-title">스토어</h3>
					<p class="product-card-description">반려동물을 위한 최고 품질의 사료, 용품,
						장난감을 한 곳에서 만나보세요.</p>
				</div>
				
				<div class="product-card">
					<div class="product-image">
						<img
							src="https://readdy.ai/api/search-image?query=Happy pet owners community gathering with dogs and cats, people smiling and interacting, warm social atmosphere, modern pet-friendly environment, natural lighting, welcoming community space&width=300&height=200&seq=community1&orientation=landscape"
							alt="커뮤니티">
					</div>
					<h3 class="product-card-title">커뮤니티</h3>
					<p class="product-card-description">반려동물을 키우는 가족들과 소통하고 정보를
						공유하는 따뜻한 공간입니다.</p>
				</div>
				
				<div class="product-card">
					<div class="product-image">
						<img
							src="https://readdy.ai/api/search-image?query=Professional veterinarian caring for cute puppy and kitten, modern veterinary clinic interior, gentle healthcare atmosphere, clean medical environment, caring professional service&width=300&height=200&seq=care1&orientation=landscape"
							alt="케어 서비스">
					</div>
					<h3 class="product-card-title">케어 서비스</h3>
					<p class="product-card-description">전문 수의사와 케어 전문가들이 제공하는 건강하고
						행복한 반려동물 관리 서비스입니다.</p>
				</div>
			</div>
		</div>
	</section>
	
	<!-- 푸터 시작 -->
		<%@ include file="setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
</html>