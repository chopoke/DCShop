<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="setting/setting.jsp"%>
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
	<%@ include file="setting/header.jsp"%>
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
	<section class="main-image-section" id="main-image-section"
		width="600px">
		<link
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
			rel="stylesheet" />

		<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel"
			align="center">
			<div class="carousel-inner">
				<!-- 첫 번째 이미지 -->
				<div class="carousel-item active">
					<img height="600px" src="resources/img_main/메인_강아지1.jpg"
						class="d-block w-100" alt="강아지 이미지1" />
					<div class="carousel-caption d-none d-md-block text-start">
						<br>
						<div class="main-image-content">
							<div class="main-image-text">
								<h2 class="main-image-title">
									사랑스러운 <br>반려동물과 함께
								</h2>
								<p class="main-image-description">
									건강하고 행복한 반려동물을 위한 프리미엄 용품과 <br>서비스를 제공합니다.
								</p>
								<div class="main-image-buttons">
									<button class="primary-btn"
										onclick="window.location='${path}/shop_main.do'">SHOP</button>
									<button class="secondary-btn"
										onclick="window.location='${path}/board_list'">COMM</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 두 번째 이미지 -->
				<div class="carousel-item">
					<img height="600px" src="resources/img_main/메인_고양이1.jpg"
						class="d-block w-100" alt="이미지 2" />
					<div class="carousel-caption d-none d-md-block text-start">
						<br>
						<div class="main-image-content">
							<div class="main-image-text">
								<h2 class="main-image-title">
									사랑스러운 <br>반려동물과 함께
								</h2>
								<p class="main-image-description">
									건강하고 행복한 반려동물을 위한 프리미엄 용품과 <br>서비스를 제공합니다.
								</p>
								<div class="main-image-buttons">
									<button class="primary-btn"
										onclick="window.location='${path}/shop_main.do'">SHOP</button>
									<button class="secondary-btn"
										onclick="window.location='${path}/board_list'">COMM</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 세 번째 이미지 -->
				<div class="carousel-item">
					<img height="600px" src="resources/img_main/메인_같이.png"
						class="d-block w-100" alt="이미지 3" />
					<div class="carousel-caption d-none d-md-block text-start">
						<br>
						<div class="main-image-content">
							<div class="main-image-text">
								<h2 class="main-image-title">
									사랑스러운 <br>반려동물과 함께
								</h2>
								<p class="main-image-description">
									건강하고 행복한 반려동물을 위한 프리미엄 용품과 <br>서비스를 제공합니다.
								</p>
								<div class="main-image-buttons">
									<button class="primary-btn"
										onclick="window.location='${path}/shop_main.do'">SHOP</button>
									<button class="secondary-btn"
										onclick="window.location='${path}/board_list'">COMM</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 네 번째 이미지 -->
				<div class="carousel-item">
					<img height="600px" src="resources/img_main/메인_커뮤2.png"
						class="d-block w-100" alt="이미지 4" />
					<div class="carousel-caption d-none d-md-block text-start">
						<br>
						<div class="main-image-content">
							<div class="main-image-text">
								<h2 class="main-image-title">
									사랑스러운 <br>반려동물과 함께
								</h2>
								<p class="main-image-description">
									건강하고 행복한 반려동물을 위한 프리미엄 용품과 <br>서비스를 제공합니다.
								</p>
								<div class="main-image-buttons">
									<button class="primary-btn"
										onclick="window.location='${path}/shop_main.do'">SHOP</button>
									<button class="secondary-btn"
										onclick="window.location='${path}/board_list'">COMM</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>



			<!-- 캐러셀 네비게이션 -->
			<button class="carousel-control-prev" type="button"
				data-bs-target="#mainCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"></span> <span
					class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#mainCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon"></span> <span
					class="visually-hidden">Next</span>
			</button>
		</div>

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	</section>



	<section class="product-section">
		<div class="container">
			<!-- 멍 파트 -->
			<div align="center">
				<a href="${path }/shop_main.do?petType=1"><img height="100px"
					src="resources/img_main/icon/멍3.png" alt="" /></a>
			</div>
			<!-- <h2 class="product-title">멍</h2> -->

			<!-- 자동재생 / 3초마다 전환 -->
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<%-- 못쓰면 아래 fmt줄을 그냥 ${product.price}로 바꾸세요 --%>

			<div id="productCarousel" class="carousel slide"
				data-bs-ride="carousel" data-bs-interval="3000">
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
								<a class="click_card"
									href="${path}/ad_shop_detailAction.pd?pdId=${product.pd_id}">
									<div class="product-image">
										<img src=" ${product.pd_image_url}"
											alt="${product.pd_name}" class="d-block w-100">
									</div>
									<h3 class="product-card-title">${product.pd_name}</h3>
									<p class="product-card-description">
										${product.pd_brand}<br> ₩
										<fmt:formatNumber value="${product.pd_price}" pattern="#,###" />
										<%-- fmt 못쓰면: ₩${product.price} --%>
									</p>
								</a>
							</div>
						</div>

						<!-- 슬라이드 끝 (3개 단위 또는 마지막에서 닫기) -->
						<c:if test="${s.index % 3 == 2 || s.last}">
				</div>
				<!-- .row -->
			</div>
			<!-- .carousel-item -->
			</c:if>
			</c:forEach>
		</div>
		</div>

	</section>

	<!-- 메인 공지/이벤트 미니 팝업 -->
	<div class="modal fade" id="mainNoticeModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered"
			style="max-width: 420px;">
			<div class="modal-content" style="border-radius: 12px;">
				<div class="modal-header" style="border-bottom: none;">
					<h5 class="modal-title">소식 안내</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" style="padding-top: 0;">
					<%--
					 * 메인 미니 팝업
					 * - latestNotices/latestEvents 중 가장 최신 1건씩 노출
					 * - 제목 클릭 시 상세로 이동하며 listClick=1을 주어 조회수 증가 및 상세 렌더링 일관성 유지
					 --%>
					<!-- 최신 공지 -->
					<c:if test="${not empty latestNotices}">
						<c:set var="n" value="${latestNotices[0]}" />
						<div
							style="margin-bottom: 12px; padding: 10px; border: 1px solid #f1f1f1; border-radius: 8px;">
							<div style="font-size: 12px; color: #888;">공지</div>
							<div
								style="font-weight: 600; margin-top: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
								<a href="${path}/notice_detail?b_num=${n.b_num}"
									style="text-decoration: none; color: #333;">${n.b_title}</a>
							</div>
							<div style="font-size: 12px; color: #9a9a9a; margin-top: 2px;">
								<fmt:formatDate value="${n.b_dateposted}" pattern="yyyy.MM.dd" />
								
							</div>
						</div>
					</c:if>

					<!-- 최신 이벤트 (가입이벤트 등) -->
					<c:if test="${not empty latestEvents}">
						<c:set var="e" value="${latestEvents[0]}" />
						<div
							style="padding: 10px; border: 1px solid #f1f1f1; border-radius: 8px;">
							<div style="font-size: 12px; color: #888;">이벤트</div>
							<div
								style="font-weight: 600; margin-top: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
								<a href="${path}/notice_detail?b_num=${e.b_num}"
									style="text-decoration: none; color: #333;">${e.b_title}</a>
							</div>
							<div style="font-size: 12px; color: #9a9a9a; margin-top: 2px;">
								<fmt:formatDate value="${e.b_dateposted}" pattern="yyyy.MM.dd" />
								
							</div>
						</div>
					</c:if>
				</div>
				<div class="modal-footer"
					style="border-top: none; display: flex; justify-content: space-between; width: 100%;">
					<div>
						<a href="${path}/notice_list?category=공지"
							class="btn btn-sm btn-outline-secondary">공지 더보기</a> <a
							href="${path}/notice_list?category=이벤트"
							class="btn btn-sm btn-primary" style="margin-left: 6px;">이벤트
							더보기</a>
					</div>
					<div>
						<button id="hideTodayBtn" type="button"
							class="btn btn-sm btn-link"
							style="text-decoration: none; color: #777;">오늘 하루 보지 않기</button>
						<button type="button" class="btn btn-sm btn-outline-dark"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			try {
				var hasNotice = '${not empty latestNotices}' === 'true';
				var hasEvent = '${not empty latestEvents}' === 'true';
				if (!hasNotice && !hasEvent) return;

				var hideUntil = localStorage.getItem('mainNoticeHideUntil');
				var now = new Date();
				if (hideUntil && now.getTime() < parseInt(hideUntil)) return;

				// 새 플로팅 패널 표시
				var panel = document.getElementById('floatingNoticePanel');
				if (panel) panel.style.display = 'block';

				// 오늘 하루 보지 않기
				var hideBtn = document.getElementById('hideTodayBtn2');
				if (hideBtn) {
					hideBtn.addEventListener('click', function() {
						var endOfDay = new Date();
						endOfDay.setHours(23, 59, 59, 999);
						localStorage.setItem('mainNoticeHideUntil', String(endOfDay.getTime()));
						if (panel) panel.style.display = 'none';
					});
				}

				// 패널 닫기
				var closeBtn = document.getElementById('closeFloatingPanel');
				if (closeBtn) {
					closeBtn.addEventListener('click', function() {
						if (panel) panel.style.display = 'none';
					});
				}

				// 위젯 제거됨

				// 드래그 기능
				if (panel) {
					var header = document.getElementById('floatingNoticeHeader');
					var isDragging = false, offsetX = 0, offsetY = 0;
					var startX = 0, startY = 0;
					var rect;
					function onMouseDown(e) {
						isDragging = true;
						rect = panel.getBoundingClientRect();
						startX = e.clientX;
						startY = e.clientY;
						offsetX = startX - rect.left;
						offsetY = startY - rect.top;
						document.addEventListener('mousemove', onMouseMove);
						document.addEventListener('mouseup', onMouseUp);
					}
					function onMouseMove(e) {
						if (!isDragging) return;
						var x = e.clientX - offsetX;
						var y = e.clientY - offsetY;
						// 경계 제한
						var maxX = window.innerWidth - panel.offsetWidth - 8;
						var maxY = window.innerHeight - panel.offsetHeight - 8;
						if (x < 8) x = 8;
						if (y < 8) y = 8;
						if (x > maxX) x = maxX;
						if (y > maxY) y = maxY;
						panel.style.left = x + 'px';
						panel.style.top = y + 'px';
						panel.style.right = 'auto'; // 오른쪽 고정 해제
					}
					function onMouseUp() {
						isDragging = false;
						document.removeEventListener('mousemove', onMouseMove);
						document.removeEventListener('mouseup', onMouseUp);
					}
					if (header) header.addEventListener('mousedown', onMouseDown);
				}
			} catch (e) { /* no-op */ }
		});
	</script>

	<!-- 우측 상단 고정 플로팅 패널 (드래그 가능) -->
	<div id="floatingNoticePanel"
		style="display: none; position: fixed; top: 16px; right: 88px; z-index: 1056; width: 360px; background: #fff; border: 1px solid #e9e9e9; border-radius: 12px; box-shadow: 0 6px 24px rgba(0, 0, 0, 0.12);">
		<div id="floatingNoticeHeader"
			style="cursor: move; user-select: none; padding: 10px 12px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #f1f1f1;">
			<div style="font-weight: 600;">소식 안내</div>
			<button id="closeFloatingPanel" type="button"
				class="btn btn-sm btn-outline-secondary">닫기</button>
		</div>
		<div style="padding: 12px;">
			<c:if test="${not empty latestNotices}">
				<c:set var="n" value="${latestNotices[0]}" />
				<div
					style="margin-bottom: 10px; padding: 10px; border: 1px solid #f5f5f5; border-radius: 8px;">
					<div style="font-size: 12px; color: #888;">공지</div>
					<div
						style="font-weight: 600; margin-top: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
						<a href="${path}/notice_detail?b_num=${n.b_num}&listClick=1"
							style="text-decoration: none; color: #333;">${n.b_title}</a>
					</div>
						 <div style="font-size: 12px; color: #9a9a9a; margin-top: 2px; text-align: right;">
						<fmt:formatDate value="${n.b_dateposted}" pattern="yyyy.MM.dd" />
						
					</div>
				</div>
			</c:if>
			<c:if test="${not empty latestEvents}">
				<c:set var="e" value="${latestEvents[0]}" />
				<div
					style="padding: 10px; border: 1px solid #f5f5f5; border-radius: 8px;">
					<div style="font-size: 12px; color: #888;">이벤트</div>
					<div
						style="font-weight: 600; margin-top: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
						<a href="${path}/notice_detail?b_num=${e.b_num}&listClick=1"
							style="text-decoration: none; color: #333;">${e.b_title}</a>
					</div>
					<div style="font-size: 12px; color: #9a9a9a; margin-top: 2px; text-align: right;">
						<fmt:formatDate value="${e.b_dateposted}" pattern="yyyy.MM.dd" />
						
					</div>
				</div>
			</c:if>
		</div>
		<%-- <div
			style="display: flex; gap: 8px; align-items: center; justify-content: flex-end; flex-wrap: nowrap; padding: 8px 12px; border-top: 1px solid #f1f1f1; overflow: hidden;">
			<a href="${path}/notice_list?category=공지" class="btn btn-sm btn-outline-secondary" style="white-space: nowrap;">공지 더보기</a> <a
				
			   href="${path}/notice_list?category=이벤트" class="btn btn-sm btn-primary" style="white-space: nowrap;">이벤트 더보기</a>

	</div> --%>
			<!-- 오늘 하루 보지 않기 버튼  -->
  		<div style="display: flex; justify-content: center;">
		    <button id="hideTodayBtn2" type="button" class="btn btn-sm btn-light" style="border: 1px solid #e3e3e3; "> 오늘 하루 보지 않기
		    </button>
  		</div>

	</div>


	<!-- 우측 상단 작은 위젯 -->

	<!-- 냥 파트 -->
	<div align="center">
		<hr width="400px">
	</div>
	<section class="product-section">
		<div class="container">
			<div align="center">
				<a href="${path }/shop_main.do?petType=2"><img height="100px"
					src="resources/img_main/icon/냥1.png" alt="" /></a>
			</div>
			<!-- <h2 class="product-title">멍</h2> -->

			<!-- 자동재생 / 3초마다 전환 -->
			<div id="productCarousel" class="carousel slide"
				data-bs-ride="carousel" data-bs-interval="3000">
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
								<a class="click_card"
									href="${path}/ad_shop_detailAction.pd?pdId=${product.pd_id}">
									<div class="product-image">
										<img src=" ${product.pd_image_url}"
											alt="${product.pd_name}" class="d-block w-100">
									</div>
									<h3 class="product-card-title">${product.pd_name}</h3>
									<p class="product-card-description">
										${product.pd_brand}<br> ₩
										<fmt:formatNumber value="${product.pd_price}" pattern="#,###" />
										<%-- fmt 못쓰면: ₩${product.price} --%>
									</p>
								</a>
							</div>
						</div>

						<!-- 슬라이드 끝 (3개 단위 또는 마지막에서 닫기) -->
						<c:if test="${s.index % 3 == 2 || s.last}">
				</div>
				<!-- .row -->
			</div>
			<!-- .carousel-item -->
			</c:if>
			</c:forEach>
		</div>
		</div>



	</section>

	<div align="center">
		<hr width="400px">
	</div>

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
<!-- 					<div class="product-image"> -->
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
	<%@ include file="setting/footer.jsp"%>
	<!-- 푸터 끝 -->
<c:if test="${param.quit == '1'}">
	<script>
		(function () {
			// url에서 객체 찾아주기
		    const params = new URLSearchParams(location.search);
			// 찾은 객체가 quit이고, 값이 1이라면
		    if (params.get('quit') === '1') {
		      alert('회원 탈퇴가 완료되었습니다.');		// 알럿창 출력
		      // URL에서 quit=1 제거 (뒤로가기 이력은 유지)
		      params.delete('quit');
		      const q = params.toString();
		      // 현재 페이지 경로 + q가 true라면 ? 와 q를 붙이고 아니면 공백 + 쿼리스ㅡ트링 정리 
		      const newUrl = location.pathname + (q ? '?' + q : '') + location.hash;
		      history.replaceState(null, '', newUrl);
		    }
		})();
	</script>
</c:if>

</body>
</html>