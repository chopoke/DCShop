<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>COMM-main</title>
<style type="text/css">
.justify-between {
    justify-content: space-between;
}
.items-center {
    align-items: center;
}
.h-16 {
    height: 4rem;
}
.flex {
    display: flex;
}
*, ::after, ::before {
    box-sizing: border-box;
}
@media (min-width: 1024px) {
    .lg\:hidden {
        display: none;
    }
}
*, ::after, ::before {
    box-sizing: border-box;
    border-width: 0;
    border-style: solid;
    border-color: #e5e7eb;
}
*, ::before, ::after
Specificity: (0,0,1)
 {
    --tw-border-spacing-x: 0;
    --tw-border-spacing-y: 0;
    --tw-translate-x: 0;
    --tw-translate-y: 0;
    --tw-rotate: 0;
    --tw-skew-x: 0;
    --tw-skew-y: 0;
    --tw-scale-x: 1;
    --tw-scale-y: 1;
    --tw-pan-x: ;
    --tw-pan-y: ;
    --tw-pinch-zoom: ;
    --tw-scroll-snap-strictness: proximity;
    --tw-gradient-from-position: ;
    --tw-gradient-via-position: ;
    --tw-gradient-to-position: ;
    --tw-ordinal: ;
    --tw-slashed-zero: ;
    --tw-numeric-figure: ;
    --tw-numeric-spacing: ;
    --tw-numeric-fraction: ;
    --tw-ring-inset: ;
    --tw-ring-offset-width: 0px;
    --tw-ring-offset-color: #fff;
    --tw-ring-color: rgb(59 130 246 / 0.5);
    --tw-ring-offset-shadow: 0 0 #0000;
    --tw-ring-shadow: 0 0 #0000;
    --tw-shadow: 0 0 #0000;
    --tw-shadow-colored: 0 0 #0000;
    --tw-blur: ;
    --tw-brightness: ;
    --tw-contrast: ;
    --tw-grayscale: ;
    --tw-hue-rotate: ;
    --tw-invert: ;
    --tw-saturate: ;
    --tw-sepia: ;
    --tw-drop-shadow: ;
    --tw-backdrop-blur: ;
    --tw-backdrop-brightness: ;
    --tw-backdrop-contrast: ;
    --tw-backdrop-grayscale: ;
    --tw-backdrop-hue-rotate: ;
    --tw-backdrop-invert: ;
    --tw-backdrop-opacity: ;
    --tw-backdrop-saturate: ;
    --tw-backdrop-sepia: ;
    --tw-contain-size: ;
    --tw-contain-layout: ;
    --tw-contain-paint: ;
    --tw-contain-style: ;
}

.main-image-section .grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr; /* 3등분 */
  align-items: center;
}
.flex items-center justify-end space-x-4{
	align-items: flex-end;
}
</style>
</head>
<link rel="stylesheet" href="${path}/resources/css/footer.css">
<link rel="stylesheet" href="${path}/resources/css/header.css">
<link rel="stylesheet" href="${path}/resources/css/main.css">
<body>
	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	
	<section class="hero-section1">
	</section>
	<section class="main-image-section" id="main-image-section" width="600px">
  <div class="flex justify-between items-center h-16">

    <!-- 왼쪽 : logo -->
    <div class="flex items-center">
      <div class="font-['Pacifico'] text-2xl text-primary"> </div>
    </div>

    <!-- 가운데 : 메뉴 -->
    <div class="flex justify-center space-x-6">
      <a href="#">공지/이벤트 게시판</a>&nbsp;&nbsp;
      <a href="board_list">자유 게시판</a>&nbsp;&nbsp;
      <a href="#">묘한발견?(준비중)</a>
    </div>

    <!-- 오른쪽 : 검색 + 메뉴 버튼 -->
    <div class="flex items-center justify-end space-x-4">
      <div class="relative hidden md:block">
        <div class="flex items-center bg-gray-100 rounded-lg px-4 py-2 w-80">
          <div class="w-5 h-5 flex items-center justify-center mr-3">
            <i class="ri-search-line text-gray-500">&nbsp;&nbsp;</i>
          </div>
          <input type="text" placeholder="Search"
                 class="bg-transparent border-none outline-none flex-1 text-sm" />
        </div>
      </div>
      <button
        class="lg:hidden mobile-menu-button w-10 h-10 flex items-center justify-center rounded-lg hover:bg-gray-100">
        <i class="ri-menu-line text-gray-700 text-xl"></i>
      </button>
    </div>

  </div>
</section>
	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
</html>