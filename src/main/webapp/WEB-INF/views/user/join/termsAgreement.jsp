<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>약관 동의 | Shop</title>
<!-- 약관동의 페이지 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style>

.step {
	height: 4px;
	background: #e9ecef;
	border-radius: 999px;
	overflow: hidden;
}

.step .bar {
	height: 100%;
	width: 33%;
	background: #0d6efd;
}

.terms-box {
	max-height: 220px;
	overflow: auto;
	border: 1px solid #e9ecef;
	border-radius: .5rem;
	padding: 1rem;
	background: #fff;
}

.required-badge {
	font-size: .75rem;
}

.sticky-actions {
	position: sticky;
	bottom: 0;
	background: rgba(255, 255, 255, .9);
	backdrop-filter: saturate(180%) blur(6px);
	border-top: 1px solid #e9ecef;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #fafafa;
	color: #212529;
	line-height: 1.6;
}

/* 테마 */

.border-primary {
  border-color: #000 !important;
}

.bg-primary,
.btn-primary {
  background-color: #000 !important;
  border-color: #000 !important;
  color: #fff !important;
}

.btn-primary:hover {
  background-color: #fff !important;
}

/* 필수 / 선택 라벨도 검정 */
.badge,
.label,
.required {
  background-color: #000 !important;
}

body {
	background-color: #fff;
	color: #000;
}

a, a:hover {
	text-decoration: none;
}
/* -------------------------------------------------------------------- */
.hero-section1 {
	width: 100%;
	background: white;
	padding: .5rem 0;
	padding-top: 5rem;
}


.test2 {
    background-color: black !important;
    color: #fff !important;
    margin-left: .25rem !important;
    --bs-badge-padding-x: 0.65em;
    --bs-badge-padding-y: 0.35em;
    --bs-badge-font-size: 0.75em;
    --bs-badge-font-weight: 700;
    --bs-badge-color: #fff;
    --bs-badge-border-radius: var(--bs-border-radius);
    display: inline-block;
    padding: var(--bs-badge-padding-y) var(--bs-badge-padding-x);
    font-size: var(--bs-badge-font-size);
    font-weight: var(--bs-badge-font-weight);
    line-height: 1;
    color: var(--bs-badge-color);
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: var(--bs-badge-border-radius);
}

.test {
    background-color: gray !important;
    color: #fff !important;
    margin-left: .25rem !important;
    --bs-badge-padding-x: 0.65em;
    --bs-badge-padding-y: 0.35em;
    --bs-badge-font-size: 0.75em;
    --bs-badge-font-weight: 700;
    --bs-badge-color: #fff;
    --bs-badge-border-radius: var(--bs-border-radius);
    display: inline-block;
    padding: var(--bs-badge-padding-y) var(--bs-badge-padding-x);
    font-size: var(--bs-badge-font-size);
    font-weight: var(--bs-badge-font-weight);
    line-height: 1;
    color: var(--bs-badge-color);
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: var(--bs-badge-border-radius);
}

.form-check-input:checked {
    background-color: #000000 !important;
    border-color: #000000 !important;
}



.form-text {
	align-self: flex-start;
}

.custom-main {
  max-width: 900px; /* 원하는 너비 */
}

/* -------------------------------------------------------------------- */
.btn {
	background-color: #000; /* 버튼 검정 */
	color: #fff; /* 버튼 텍스트 흰색 */
	border: 1px solid #000;
}

.btn:hover {
	background-color: #fff;
	color: #000;
}

.form-check-input:checked {
	background-color: #000;
	border-color: #000;
}

.border, hr {
	border-color: #000 !important; /* 선 검정 */ . text-primary , a, a : hover,
	.link-primary {
  color : #000 !important;
	text-decoration: none !important; /* 필요시 밑줄 제거 */
}

.border-primary {
	border-color: #000 !important;
}

.bg-primary, .btn-primary {
	background-color: #000 !important;
	border-color: #000 !important;
	color: #fff !important;
}

.btn-primary:hover {
	background-color: #fff !important;
	color: #000 !important;
}

/* 필수 / 선택 라벨도 검정 */
.badge, .label, .required {
	color: #000 !important;
}

/* 헤더 */
header {
	border-bottom: 1px solid #e5e5e5;
}

header .navbar-brand {
	font-weight: 700;
	font-size: 1.25rem;
}

header .nav-link {
	font-weight: 500;
}

/* 제목 */
h1, .h3 {
	font-weight: 700;
	color: #111;
}

/* 약관 카드 */
.card {
	border: 1px solid #e5e5e5;
	border-radius: 0.75rem;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);
}

.card-header {
	font-weight: 600;
	background-color: #fff;
}

.terms-box {
	font-size: 0.9rem;
	line-height: 1.5;
}

/* 체크박스 스타일 */

.form-check-input:checked {
	background-color: #000;
	border-color: #000;
}

.form-check-input {
	border-color: #000;
}

.form-check-label {
	cursor: pointer;
}

/* 전체 동의 */
.form-switch {
	background-color: #fff;
	border: 1px solid #e5e5e5;
	border-radius: 0.75rem;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);
}

/* 버튼 */
.btn-primary {
	background-color: #000;
	border-color: #000;
}

.btn-primary:hover {
	background-color: #333;
	border-color: #333;
}

.btn-outline-secondary {
	border-radius: 0.5rem;
}

/* 하단 고정 영역 */
.sticky-actions {
	background: rgba(255, 255, 255, .95);
	border-top: 1px solid #e5e5e5;
	box-shadow: 0 -2px 6px rgba(0, 0, 0, 0.04);
}

/* 푸터 */
footer {
	font-size: 0.85rem;
	background-color: #fff;
	border-top: 1px solid #e5e5e5;
}

footer a {
	color: #666;
	text-decoration: none;
}

footer a:hover {
	color: #000;
}
</style>
</head>
<body>
	
	
	<!-- 헤더부분 -->
	<%@ include file="../../setting/header.jsp" %>
	<!-- <header class="border-bottom bg-white">
		<div
			class="container py-3 d-flex align-items-center justify-content-between">
			<a class="navbar-brand fw-bold text-decoration-none"
				href="#">Shop</a>
			<nav class="d-none d-md-flex gap-3 small text-muted">
				<span>1. 약관동의</span> 
				<span>→ 2. 정보입력</span>
				<span>→ 3. 완료</span>
			</nav>
		</div> -->
	

	<section class="hero-section1">
	</section>
	
	<main class="container-fluid my-4 my-md-5" style="max-width: 900px;">
		<div class="mb-3">
			<ol class="breadcrumb mb-2">
				<li class="breadcrumb-item"><a style="color: black;"
					href="${pageContext.request.contextPath}/">홈</a></li>
				<li class="breadcrumb-item active">약관 동의</li>
			</ol>
			<div class="step" aria-hidden="true">
				<div class="bar" style="width: 33%; background-color:black;"></div>
			</div>
		</div>

		<h1 class="h3 fw-semibold mb-4">약관에 동의해 주세요</h1>

		<!-- 다음 버튼을 눌렀을 때 action으로 넘기기 -->
		<form id="termsForm" method="post" action="join.do">	

			<!-- 전체 동의 -->
         <div class="form-check form-switch bg-white border rounded-3 p-3 mb-3 d-flex align-items-center justify-content-between">
           <label class="form-check-label fw-semibold" for="agreeAll">전체 동의</label>
         <div class="form-text">모든 약관(필수/선택)에 일괄 동의합니다.</div><!-- 마이페이지에서 선택항목 수정가능? -->
           <input class="form-check-input" type="checkbox" role="switch" id="agreeAll">
         </div>
				
				
			</div>

			<!-- (필수1. 반드시 체크!) 서비스 이용약관 -->
			<section class="card mb-3">
				<div
					class="card-header bg-white d-flex align-items-center justify-content-between">
					<div class="form-check m-0">
						<input class="form-check-input required-check" type="checkbox"
							value="Y" id="agreeTerms" name="agreeTerms" required> 
							<label class="form-check-label" for="agreeTerms"> 
								(필수) 서비스 이용약관 동의 
							</label> 
							<span class="test2">필수</span>
					</div>
					<button class="btn btn-sm btn-outline-secondary" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseTerms"
						aria-expanded="false" aria-controls="collapseTerms">내용 보기</button>
				</div>
				<div id="collapseTerms" class="collapse">
					<div class="card-body">
						<div class="terms-box" id="termsBox1" tabindex="0"
							aria-label="서비스 이용약관 전문">
							<h6 class="fw-semibold">서비스 이용약관 (요약)</h6>
							<p>본 약관은 웹 페이지가가 제공하는 온라인 쇼핑 서비스의 이용과 관련하여 회사와 회원 간의 권리, 의무 및
								책임사항을 규정합니다. 회원 가입 시 본 약관에 동의한 것으로 간주됩니다.</p>
							<ul>
								<li>회원의 계정/비밀번호 관리 책임</li>
								<li>주문, 결제, 배송 및 청약철회 규정</li>
								<li>금지행위와 서비스 이용 제한</li>
								<li>책임 제한 및 분쟁 해결</li>
							</ul>
							<p class="text-muted small mb-0">※ 실제 서비스에 적용 시, 회사의 최신 약관
								전문을 삽입하세요.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- (필수) 개인정보 수집 및 이용 동의 -->
			<section class="card mb-3">
				<div
					class="card-header bg-white d-flex align-items-center justify-content-between">
					<div class="form-check m-0">
						<input class="form-check-input required-check" type="checkbox"
							value="Y" id="agreePrivacy" name="agreePrivacy" required>
						<label class="form-check-label" for="agreePrivacy">(필수)
							개인정보 수집 및 이용 동의</label> <span
							class="test2">필수</span>
					</div>
					<button class="btn btn-sm btn-outline-secondary" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapsePrivacy"
						aria-expanded="false" aria-controls="collapsePrivacy">내용
						보기</button>
				</div>
				<div id="collapsePrivacy" class="collapse">
					<div class="card-body">
						<div class="terms-box" id="termsBox2" tabindex="0"
							aria-label="개인정보 수집 및 이용 동의 전문">
							<h6 class="fw-semibold">수집 항목 및 목적</h6>
							<ul>
								<li>필수: 아이디, 비밀번호, 이름, 이메일, 휴대전화번호 — 회원 식별 및 서비스 제공</li>
								<li>선택: 생년월일, 성별 — 맞춤형 서비스 제공</li>
							</ul>
							<h6 class="fw-semibold mt-3">보유/이용 기간</h6>
							<p>회원 탈퇴 시까지 또는 관련 법령에 따른 보관 의무 기간.</p>
							<p class="text-muted small mb-0">※ 실제 서비스에 적용 시, 회사의 개인정보
								처리방침을 반영하세요.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- (선택) 개인정보 제3자 제공 동의 -->
			<section class="card mb-3">
				<div
					class="card-header bg-white d-flex align-items-center justify-content-between">
					<div class="form-check m-0">
						<input class="form-check-input optional-check" type="checkbox"
							value="Y" id="agreeThird" name="agreeThird"> <label
							class="form-check-label" for="agreeThird">(선택) 개인정보 제3자
							제공 동의</label> <span class="test">선택</span>
					</div>
					<button class="btn btn-sm btn-outline-secondary" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseThird"
						aria-expanded="false" aria-controls="collapseThird">내용 보기</button>
				</div>
				<div id="collapseThird" class="collapse">
					<div class="card-body">
						<div class="terms-box" id="termsBox3" tabindex="0"
							aria-label="개인정보 제3자 제공 동의 전문">
							<p>물류/배송사, 결제대행사 등 서비스 제공을 위한 필수 위탁 및 제공이 발생할 수 있습니다. 제공 받는
								자, 목적, 항목, 보유기간을 명시하고 동의를 받습니다.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- (선택) 마케팅 수신 동의 -->
			<section class="card mb-4">
				<div class="card-header bg-white d-flex align-items-center justify-content-between">
					<div class="form-check m-0">
						<input class="form-check-input optional-check" type="checkbox"
							value="Y" id="agreeMarketing" name="agreeMarketing"> <label
							class="form-check-label" for="agreeMarketing">(선택) 광고성 정보
							수신 동의</label> 
							<span class="test">선택</span>
					</div>
					<button class="btn btn-sm btn-outline-secondary" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseMarketing"
						aria-expanded="false" aria-controls="collapseMarketing">세부
						설정</button>
				</div>
				<div id="collapseMarketing" class="collapse">
					<div class="card-body">
						<div class="row g-3 align-items-center">
							<div class="col-12 col-md-6">
								<div class="form-check">
									<input class="form-check-input marketing-channel"
										type="checkbox" value="EMAIL" id="mkEmail" name="mkChannel"
										disabled> <label class="form-check-label"
										for="mkEmail">이메일</label>
								</div>
								<div class="form-check">
									<input class="form-check-input marketing-channel"
										type="checkbox" value="SMS" id="mkSms" name="mkChannel"
										disabled> <label class="form-check-label" for="mkSms">문자(SMS)</label>
								</div>
								<div class="form-check">
									<input class="form-check-input marketing-channel"
										type="checkbox" value="PUSH" id="mkPush" name="mkChannel"
										disabled> <label class="form-check-label" for="mkPush">앱
										푸시</label>
								</div>
							</div>
							<div class="col-12 col-md-6">
								<div class="form-text">할인쿠폰, 혜택 안내 등 마케팅 메시지를 수신합니다. 언제든지
									수신 거부할 수 있습니다.</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			<div
				class="sticky-actions d-flex flex-column flex-md-row gap-2 justify-content-between align-items-stretch align-items-md-center p-3 rounded-3">
				<div class="small text-muted">필수 항목에 동의해야 다음 단계로 진행됩니다.</div>
				<div class="d-flex gap-2">
					<a href="javascript:history.back()"
						class="btn btn-outline-secondary">이전</a>
					<button id="nextBtn" type="submit" class="btn btn-primary" disabled>다음</button>
				</div>
			</div>

		</form>
	</main>

<!-- footer부분 -->
	
		<!-- <div
			class="container d-flex flex-column flex-md-row gap-2 justify-content-between text-muted">
			<div>
				©
				<script>document.write(new Date().getFullYear())</script>
				Shop Inc.
			</div>
			<div class="d-flex gap-3">
				<a class="text-muted text-decoration-none"
					href="#"
					target="_blank">이용약관</a> <a class="text-muted text-decoration-none"
					href="#"
					target="_blank">개인정보처리방침</a> <a
					class="text-muted text-decoration-none"
					href="#" target="_blank">고객센터</a>
			</div>
		</div> -->
		<%@ include file="../../setting/footer.jsp" %>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
  (function(){
    const agreeAll = document.getElementById('agreeAll');
    const requiredChecks = Array.from(document.querySelectorAll('.required-check'));
    const optionalChecks = Array.from(document.querySelectorAll('.optional-check'));
    const nextBtn = document.getElementById('nextBtn');
    const mkMaster = document.getElementById('agreeMarketing');
    const mkChannels = Array.from(document.querySelectorAll('.marketing-channel'));

    // 전체 동의 시
    // ...~~ 은 스프레드 연산자
    agreeAll.addEventListener('change', function(){
      const checked = this.checked;
      [...requiredChecks, ...optionalChecks].forEach(cb => { cb.checked = checked; cb.dispatchEvent(new Event('change')); });
      updateNextButton();
    });

    // 필수 항목 상태 변경 시 전체동의/다음 버튼 갱신
    [...requiredChecks, ...optionalChecks].forEach(cb => {
      cb.addEventListener('change', function(){
        // 전체동의 스위치 동기화
        const allBoxes = [...requiredChecks, ...optionalChecks];
        agreeAll.checked = allBoxes.every(x => x.checked);
        // 마케팅 세부 채널 활성화
        if (cb === mkMaster) {
          const enable = mkMaster.checked;
          mkChannels.forEach(ch => { ch.disabled = !enable; if (!enable) ch.checked = false; });
        }
        updateNextButton();
      });
    });

    function updateNextButton(){
      const ok = requiredChecks.every(cb => cb.checked);
      nextBtn.disabled = !ok;
    }

    // 서버 검증 실패 시(리다이렉트 후) 기존 값 반영 가정
    updateNextButton();

    // 제출 시 브라우저 기본 검증 + 사용자 안내
    document.getElementById('termsForm').addEventListener('submit', function(e){
      if (!requiredChecks.every(cb => cb.checked)){
        e.preventDefault();
        alert('필수 약관에 모두 동의해주세요.');
      }
    });
  })();
</script>
</body>
</html>