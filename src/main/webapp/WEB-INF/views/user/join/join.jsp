<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹 -->
<meta name="viewport" =content="width=device-width, initial-scale=1">
<title>main</title>

<!-- css 작성 -->
<link rel="stylesheet" href="${path}/resources/css/customer/join.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${path}/resources/js/customer/join.js" defer></script>
<script type="text/javascript"
	src="${path}/resources/js/customer/emailAuthentication.js"></script>

<style type="text/css">
.stepper {
	margin: 0 0 .75rem 0
}

.stepper .segments {
	display: flex;
	gap: 6px
}

.stepper .seg {
	flex: 1;
	height: 4px;
	background: #e9ecef;
	border-radius: 999px
}
/* 현재 단계만 검은색 */
.stepper.is-1 .seg:nth-child(1) {
	background: #000
}

.stepper.is-2 .seg:nth-child(2) {
	background: #000
}

.stepper.is-3 .seg:nth-child(3) {
	background: #000
}

.stepper .count {
	margin-top: 6px;
	font-size: 12px;
	color: #6b7280;
	text-align: right
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



	<div class="wrap">
		<!-- Header 시작 -->
		<%@ include file="../../setting/header.jsp"%>
		<!-- Header 끝 -->


		<section class="hero-section1"></section>

		<!-- 컨텐츠 시작 -->
		<main class="container my-4 my-md-5">
			<div id="contents">
				<div class="mb-3">
					<ol class="breadcrumb mb-2">
						<li class="breadcrumb-item"><a
							style="color: black; list-style-type: none"
							href="${pageContext.request.contextPath}/">홈</a></li>
						<li class="breadcrumb-item active">회원가입</li>
					</ol>

					<div class="stepper is-2">
						<div class="segments">
							<div class="seg"></div>
							<div class="seg"></div>
							<div class="seg"></div>
						</div>
					</div>
				</div>

				<!-- 상단 중앙1 시작 -->
				<div id="section1">
					<h1 align="center">회원가입창</h1>
				</div>
				<hr style="border: 3px solid">
				<!-- 상단 중앙2 시작 -->
				<div id="section2">
					<div id="s2_inner">
						<!-- join 시작 -->
						<div class="join">
							<form name="inputform" action="insertPet.do" method="post"
								onsubmit="return singleCheck()">

								<!-- 2-1. 중복확인 버튼 안 눌렀을때 0으로 설정 -->
								<input type="hidden" name="hiddenUserid" value="0"> <input
									type="hidden" name="hiddenUserNickName" value="0"> <input
									type="hidden" id="emailVerified" name="emailVerified" value="N">
								<input type="hidden" id="agreePrivacy" name="agreePrivacy"
									value="${agreementdto.agreePrivacy}"> <input
									type="hidden" id="agreeMarketing" name="agreeMarketing"
									value="${agreementdto.agreeMarketing}">
								<table>
									<tr>
										<th><label for="u_id">아이디<span style="color: red">*</span></label></th>
										<td><input type="text" id="u_id" name="u_id"
											class="input" size="20" placeholder="공백없이 20자 이내로 작성"
											autofocus>
											<button type="button" class="btn btn-dark btn-sm ms-2"
												onclick="confirmId()">아이디 중복확인</button></td>
									</tr>
									<tr>
										<th><label for="u_nickname">닉네임<span
												style="color: red">*</span></label></th>
										<td><input type="text" id="u_nickname" name="u_nickname"
											class="input" size="20" placeholder="공백없이 20자 이내로 작성"
											autofocus>
											<button type="button" class="btn btn-dark btn-sm ms-2"
												onclick="confirmNickName()">닉네임 중복확인</button></td>
									</tr>
									<tr>
										<th><label for="u_password">비밀번호<span
												style="color: red">*</span></label></th>
										<td><input type="password" id="u_password"
											name="u_password" class="input" size="20"
											placeholder="공백없이 20자 이내로 작성" required autofocus></td>
									</tr>
									<tr>
										<th><label for="re_password">비밀번호(확인)<span
												style="color: red">*</span></label></th>
										<td><input type="password" id="re_password"
											name="re_password" class="input" size="20"
											placeholder="비밀번호 재입력" required autofocus></td>
									</tr>
									<tr>
										<th><label for="u_name">이름<span
												style="color: red">*</span></label></th>
										<td><input type="text" id="u_name" name="u_name"
											class="input" size="20" placeholder="이름 작성" required
											autofocus></td>
									</tr>
									<tr>
										<th><label>생년월일<span style="color: red">*</span></label></th>
										<td><input type="date" name="u_birthday" class="input"
											size="8" placeholder="-없이 생년월일 6자리 입력" required autofocus></td>
									</tr>
									<tr>
										<th rowspan="2"><label for="u_address">주소<span
												style="color: red">*</span></label></th>
										<td><input type="text" id="u_address" name="u_address"
											class="input" style="width: 500px;"
											placeholder="주소를 검색하세요.(선택)" required autofocus>
											<div id="addrResult"
												style="border: 1px solid #ccc; background: #fff; max-height: 200px; overflow-y: auto; display: none; position: absolute; z-index: 100;"></div>
											<input type="text" id="u_zip_code" name="u_zip_code"
											class="input" style="width: 100px;"
											placeholder="우편 번호 입력해주세요." required autofocus></td>
									</tr>
									<tr>
										<td><input type="text" id="u_deTailaddress"
											name="u_deTailAddress" class="input" size="30"
											placeholder="상세 주소 입력해주세요." required autofocus></td>
									</tr>
									<tr>
										<th><label for="u_phone1">휴대폰 번호<span
												style="color: red">*</span></label></th>
										<td><input type="text" id="u_phone1" name="u_phone1"
											class="input" maxlength="3" style="width: 100px"> - <input
											type="text" id="u_phone2" name="u_phone2" class="input"
											maxlength="4" style="width: 100px"> - <input
											type="text" id="u_phone3" name="u_phone3" class="input"
											maxlength="4" style="width: 100px"></td>
									</tr>

									<tr>
										<th><label for="u_mail1">이메일<span
												style="color: red">*</span></label></th>
										<td>
											<div class="row g-2 align-items-center">
												<div class="col-12 col-md">
													<!-- 한 줄로 붙는 input-group (좁으면 자동 줄바꿈) -->
													<div class="input-group">
														<input type="text" id="u_mail1" name="u_mail1"
															class="form-control" placeholder="아이디" required>
														<span class="input-group-text">@</span> <input type="text"
															id="u_mail2" name="u_mail2" class="form-control"
															placeholder="도메인" required> <select
															class="form-select" id="u_mail3" name="u_mail3"
															onchange="selectEmailChk(this)">
															<option value="">직접입력</option>
															<option value="naver.com">naver.com</option>
															<option value="gmail.com">gmail.com</option>
															<option value="daum.net">daum.net</option>
															<option value="nate.com">nate.com</option>
														</select>
													</div>
												</div>

												<div class="col-auto">
													<button type="button" id="btnSend" class="btn btn-dark"
														onclick="authnum_email()">코드 발송</button>
												</div>
											</div>

											<div id="emailMsg" class="msg"></div> <!-- 인증코드 입력 영역: 최초 숨김 -->
											<!-- 인증코드 영역 (초기 숨김) -->
											<div id="emailVerifyBox" class="hidden mt-2">
												<div class="input-group">
													<span class="input-group-text">인증코드</span>
													<input type="text" id="emailCode"
														class="inp" maxlength="6" inputmode="numeric"
														placeholder="6자리" />
													<div class="col-auto">
														<button type="button" id="btnVerify"
															class="btn btn-outline-secondary"
															onclick="verifyEmailCode()">검증</button>
													</div>
												</div>
												<!-- 줄 바꿈 -->
												<div class="w-100"></div>

												<!-- 타이머: 아래 줄 왼쪽 위치 -->
												<div class="col-12 d-flex justify-content-left">
													<span id="emailTimer"
														class="badge text-bg-secondary rounded-pill px-3 py-2 font-monospace shadow-sm"
														aria-live="polite">03:00</span>
												</div>
											</div> 
											<input type="hidden" id="user_email" name="user_email">

										</td>
									</tr>

									<tr>
										<td colspan="2" class="border-0">
											<div class="d-flex justify-content-end gap-2 mt-3">
												<!-- 코드 발송과 동일 톤 -->
												<button type="submit" class="btn btn-dark">펫등록</button>
												<button type="reset" class="btn btn-outline-secondary">취소</button>
												<a class="btn btn-danger" href="main.do">가입취소</a>
											</div>
										</td>
									</tr>
								</table>
								<input type="hidden" name="privacyAgree" value="${privacyAgree}">
								<input type="hidden" name="marketingAgree"
									value="${marketingAgree}">
							</form>
						</div>
						<!-- join 끝 -->
					</div>
				</div>
				<!-- 상단 중앙 끝 -->
			</div>
		</main>
	</div>

	<!-- 컨텐츠 끝 -->

	<!-- Footer 시작 -->
	<%@ include file="../../setting/footer.jsp"%>
	<!-- Footer 시작 -->
</body>
</html>