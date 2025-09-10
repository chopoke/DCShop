<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>슬라이더 카드</title>

<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
	rel="stylesheet" />

<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: { primary: "#57B5E7", secondary: "#8DD3C7" },
        borderRadius: {
          none: "0px", sm: "4px", DEFAULT: "8px", md: "12px", lg: "16px",
          xl: "20px", "2xl": "24px", "3xl": "32px", full: "9999px", button: "8px",
        },
      },
    },
  };
</script>

<style>
:where([class^="ri-"])::before {
	content: "\f3c2";
}

.slider-container {
	background: #fff;
}

.card {
	transition: transform .35s ease, box-shadow .35s ease, opacity .35s ease;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .10);
}

.card:hover {
	transform: translateY(-4px);
	box-shadow: 0 15px 35px rgba(0, 0, 0, .15);
}

/* 가운데 카드 강화 */
.card--center {
	transform: translateY(-6px) scale(1.10);
	box-shadow: 0 18px 40px rgba(0, 0, 0, .16);
	opacity: 1;
}

.card--side {
	opacity: .9;
}

/* === Tooltip === */
#tooltip {
	position: fixed;
	z-index: 60;
	pointer-events: none;
	opacity: 0;
	visibility: hidden;
	transform: translate(-50%, -100%) scale(.98);
	transition: opacity .15s ease, transform .15s ease, visibility .15s;
	background: rgba(17, 17, 17, .9);
	color: #fff;
	padding: .375rem .625rem; /* 6px 10px */
	font-size: .875rem; /* text-sm */
	border-radius: .5rem; /* rounded-lg */
	box-shadow: 0 10px 25px rgba(0, 0, 0, .18);
	max-width: 260px;
	line-height: 1.2;
	text-wrap: balance;
	white-space: pre-line;
}

#tooltip.show {
	opacity: 1;
	visibility: visible;
	transform: translate(-50%, -100%) scale(1);
}

#tooltip::after {
	content: "";
	position: absolute;
	width: 10px;
	height: 10px;
	background: inherit;
	transform: rotate(45deg);
	left: 50%;
	translate: -50% 0;
}

#tooltip[data-pos="top"]::after {
	bottom: -5px;
}

#tooltip[data-pos="bottom"] {
	transform: translate(-50%, 0) scale(1);
}

#tooltip[data-pos="bottom"]::after {
	top: -5px;
}
</style>
</head>

<body class="min-h-screen flex items-center justify-center">
	<div
		class="slider-container w-full py-6 flex flex-col items-center justify-start px-6 gap-7">
		<div class="flex items-center gap-4 max-w-6xl w-full">


			<!-- Cards -->
			<div class="flex-1 flex items-center justify-center">
				<div id="cardContainer"
					class="flex items-center gap-2 transition-all duration-500 ease-in-out select-none">
					<!-- 카드들: data-desc(선택) 없으면 img.alt로 대체 -->
					<div
						class="card w-32 h-48 flex items-center justify-center rounded-lg overflow-hidden bg-white"
						data-desc="상품명 : ${p.name}&#10;상품 가격 : <fmt:formatNumber value='${100000}' pattern='#,###'/>원&#10;상품 할인된 가격 : <fmt:formatNumber value='${33444}' pattern='#,###'/>원">
						<img src="${path}/resources/shop/product/cat_ball01.jpg"
							alt="Cat ball (장난감)" class="w-full h-full object-cover" />
					</div>
					<div
						class="card w-32 h-48 flex items-center justify-center rounded-lg overflow-hidden bg-white"
						data-desc="고양이 이발기">
						<img src="${path}/resources/shop/product/cat_clipper01.jpg"
							alt="Cat clipper (이발기)" class="w-full h-full object-cover" />
					</div>
					<div
						class="card w-40 h-56 flex items-center justify-center rounded-lg overflow-hidden bg-white"
						data-desc="반려견 미용 가위">
						<img src="${path}/resources/shop/product/dog_scissors01.jpg"
							alt="Dog scissors (미용 가위)" class="w-full h-full object-cover" />
					</div>
					<div
						class="card w-32 h-48 flex items-center justify-center rounded-lg overflow-hidden bg-white"
						data-desc="강아지 인형">
						<img src="${path}/resources/shop/product/dog_doll01.jpg"
							alt="Dog doll (인형)" class="w-full h-full object-cover" />
					</div>
					<div
						class="card w-32 h-48 flex items-center justify-center rounded-lg overflow-hidden bg-white">
						<img src="${path}/resources/shop/product/cat_ball01.jpg"
							alt="Cat ball (예비)" class="w-full h-full object-cover" />
					</div>
				</div>
			</div>


		</div>

		<!-- Play / Pause -->
		<div class="flex items-center gap-4 mt-4">
			<button id="playPauseBtn"
				class="w-12 h-12 flex items-center justify-center bg-white rounded-full shadow-md hover:shadow-lg transition-all duration-200 !rounded-button"
				aria-label="일시정지">
				<i class="ri-pause-line text-gray-600 text-lg"></i>
			</button>
		</div>
	</div>

	<!-- 전역 툴팁 엘리먼트 -->
	<div id="tooltip" role="tooltip" aria-hidden="true"></div>

	<!-- 기능 스크립트 -->
	<script>
  document.addEventListener("DOMContentLoaded", () => {
    const container = document.getElementById("cardContainer");
    const playBtn   = document.getElementById("playPauseBtn");
    const tooltip   = document.getElementById("tooltip");

    // 상태 플래그
    let playing = false;        // 실제 타이머가 돌고 있는지
    let userPaused = false;     // 사용자가 수동으로 일시정지했는지
    let hoverPaused = false;    // 마우스 호버 때문에 잠깐 멈춘 상태인지

    // 타이머 & 재시작 예약
    let timer = null;
    let restartTimer = null;

    /* 가운데 카드 강조 */
    function applyActive() {
      const cards = Array.from(container.children);
      const mid = Math.floor(cards.length / 2);

      cards.forEach((card, i) => {
        card.className = "card flex items-center justify-center rounded-lg overflow-hidden bg-white";
        const size = i === mid ? ["w-40","h-56"] : ["w-32","h-48"];
        card.classList.add(...size, i===mid ? "card--center" : "card--side", i===mid ? "shadow-xl" : "shadow-lg");
      });
    }

    /* 무한 슬라이드 */
    function next() { container.appendChild(container.firstElementChild); applyActive(); }
    function prev() { container.insertBefore(container.lastElementChild, container.firstElementChild); applyActive(); }

    /* 아이콘 갱신 */
    function updateIcon(){
      // 버튼에는 "현재 일시정지 상태냐?"만 보여주면 됨(사용자 일시정지 or 실제 비재생)
      const pausedNow = userPaused || !playing;
      playBtn.innerHTML = pausedNow
        ? '<i class="ri-play-line text-gray-600 text-lg"></i>'
        : '<i class="ri-pause-line text-gray-600 text-lg"></i>';
      playBtn.setAttribute('aria-label', pausedNow ? '재생' : '일시정지');
    }

    /* 재생/정지 */
    function startAuto(){
      clearInterval(timer);
      const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
      if (reduce) { playing = false; updateIcon(); return; }
      timer = setInterval(next, 3000);
      playing = true;
      updateIcon();
    }
    function stopAuto(){
      clearInterval(timer);
      timer = null;
      playing = false;
      updateIcon();
    }

    /* 사용자 조작 후 잠시 뒤 자동 재시작(단, 사용자 일시정지거나 호버 중이면 재시작 안 함) */
    function scheduleRestart(delay=3000){
      clearTimeout(restartTimer);
      stopAuto();
      restartTimer = setTimeout(()=>{
        if (!userPaused && !hoverPaused) startAuto();
      }, delay);
    }

    /* 카드 클릭 시 중앙으로 */
    container.addEventListener('click', (e)=>{
      const card = e.target.closest('.card'); if (!card) return;
      const cards = Array.from(container.children);
      const mid = Math.floor(cards.length/2);
      const idx = cards.indexOf(card);
      if (idx === -1) return;
      const steps = idx - mid;
      if (steps > 0) for (let i=0;i<steps;i++) next(); else for (let i=0;i<-steps;i++) prev();
      scheduleRestart();
    });

    /* Hover: 타이머만 잠깐 멈춤(사용자 일시정지 여부는 건드리지 않음) */
    container.addEventListener('mouseenter', ()=>{
      hoverPaused = true;
      if (playing) stopAuto();     // 돌고 있으면만 멈춤
    });
    container.addEventListener('mouseleave', ()=>{
      hoverPaused = false;
      if (!userPaused) startAuto(); // 사용자가 멈춘 게 아니면 자동 재생 재개
      else updateIcon();
    });

    /* Play/Pause 토글(사용자 의도) */
    playBtn.addEventListener('click', ()=>{
      userPaused = !userPaused;
      clearTimeout(restartTimer);
      if (userPaused) stopAuto();
      else if (!hoverPaused) startAuto();
      else updateIcon();
    });

    /* 키보드 ←/→ */
    document.addEventListener('keydown', (e)=>{
      if (e.key === 'ArrowRight'){ next(); scheduleRestart(); }
      if (e.key === 'ArrowLeft'){  prev(); scheduleRestart(); }
    });

    /* ===== Tooltip 기능 ===== */
    function getDesc(card){
      if (!card) return "";
      if (card.dataset && card.dataset.desc) return card.dataset.desc;
      const img = card.querySelector('img');
      return img ? (img.getAttribute('alt') || '') : '';
    }

    function showTooltip(text, x, y, preferredTop=true){
      if (!text){ hideTooltip(); return; }
      tooltip.textContent = text;
      tooltip.setAttribute('aria-hidden', 'false');

      const margin = 12;
      const vw = window.innerWidth;

      tooltip.classList.add('show');
      tooltip.dataset.pos = preferredTop ? 'top' : 'bottom';

      const rect = tooltip.getBoundingClientRect();

      let cx = Math.min(Math.max(x, 8), vw - 8);
      let topPreferred = preferredTop;
      let ty = y - margin - rect.height;  // 위
      if (ty < 8) { topPreferred = false; ty = y + margin; }
      tooltip.dataset.pos = topPreferred ? 'top' : 'bottom';

      tooltip.style.left = cx + 'px';
      tooltip.style.top  = ty + 'px';
    }

    function moveTooltip(e){
      const card = e.target.closest('.card'); if (!card) return;
      const text = getDesc(card);
      showTooltip(text, e.clientX, e.clientY, true);
    }
    function hideTooltip(){
      tooltip.classList.remove('show');
      tooltip.setAttribute('aria-hidden', 'true');
    }

    container.addEventListener('mousemove', moveTooltip);
    container.addEventListener('mouseenter', (e)=>{
      const card = e.target.closest('.card'); if (!card) return;
      const text = getDesc(card);
      if (text) tooltip.classList.add('show');
    }, true);
    container.addEventListener('mouseleave', hideTooltip, true);

    // 초기 렌더 & 자동재생 시작
    applyActive();
    startAuto();
  });
</script>
</body>
</html>