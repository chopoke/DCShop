<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - 반려동물 수정</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.hero-section1 {
   width: 100%;
   background: white;
   padding: .5rem 0;
   padding-top: 5rem;
}
</style>
<script>
	$(function(){
		const $pwd = $('#u_password');
		const $pwdchk = $('#u_password_check');
		const $msg = $('#check');
		
		$msg.hide();
		function validate(){
			const pw = $pwd.val();
			const pwchk = $pwdchk.val();
			
			if(pwchk.length === 0 ){
				$msg.hide();
				return;
			}
			if(pw == pwchk){
				$msg.hide();
				return;
			}
			else {
				$msg.show();
				return;
			}
		}
		// 실시간 검사
		$pwdchk.on('input', validate);
		
	});
</script>

</head>
<body class="bg-gray-100">
   <!-- 헤더 시작 -->
   <%@ include file="../setting/header.jsp"%>
   <!-- 헤더 끝 -->

   <section class="hero-section1"></section>

   <!-- 전체 컨테이너 -->
   <div class="min-h-screen flex justify-center py-8">
      <!-- 메인 래퍼 -->
      <div
         class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

         <!-- 사이드바 -->
         <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
             <!-- 프로필 -->
            <form id="avatarForm" action="${path}/mypage_imgUpload.do" method="post" enctype="multipart/form-data">
			  	<input type="hidden" name="u_id" value="${sessionScope.sessionid}">
			  	<input type="file" id="u_image" name="u_image" accept="image/*" style="display:none;">
			</form>
			<c:choose>
				  <c:when test="${empty dto.u_image}">
				    <c:url var="imgUrl" value="/resources/img_main/mypage_default.png" />
				  </c:when>
				  <c:otherwise>
				    <c:url var="imgUrl" value="/resources/image/profile/${dto.u_image}" />
				  </c:otherwise>
			</c:choose>
			
			<img id="profileImg"
			     src="${imgUrl}"
			     alt="Profile"
			     class="rounded-full w-28 h-28 object-cover mb-4 cursor-pointer border" />

				<h2 class="text-lg font-semibold">${sessionScope.sessionid }</h2>
				<h2 class="text-lg font-semibold">${sessionScope.session_u_nickname }</h2>
				<p class="text-gray-500 text-sm mb-4">${sessionScope.session_u_email}</p>
				<button
					class="px-4 py-2 bg-black text-white !rounded-lg mb-6 hover:bg-blue-600"
					onclick="window.location='${path}/mypage_pwdcheck.do'">정보수정</button>

				<!-- 네비게이션 -->
				<nav class="w-full space-y-2 text-sm">
	               <a href="${pageContext.request.contextPath}/mypage_editPet.do" class="block py-2 px-3 rounded bg-gray-900 text-white hover:bg-gray-100">내 반려동물</a> 
	               <a href="./orderList" class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a>
	               <a href="./wishList.do" class="block py-2 px-3 rounded hover:bg-gray-100">관심상품</a>  
	               <a href="./cartList" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
	               <a href="./mypage_qna.do" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a> 
	               <a href="./mypage/my_reviews.do" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a> 
	               <!-- <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a> -->
	            </nav>
         </aside>

         <!-- 메인 콘텐츠 -->
         <main class="flex-1 p-8 bg-gray-50">
         	<h1 class="text-3xl font-bold text-gray-900 mb-2">내 반려동물</h1>
            <!-- 반려동물 목록 -->
			<section class="bg-white rounded-2xl shadow-md border border-gray-100 p-6 mt-8">
			  	<div class="flex items-center justify-between">
				    <h3 class="text-lg font-semibold text-gray-900">내 반려동물</h3>
				    <button id="btnOpenAdd" type="button"
				      class="rounded-xl bg-stone-500 px-3.5 py-2 text-sm font-medium text-white hover:bg-stone-400">
				      + 반려동물 추가
				    </button>
				  </div>
				  
				<!-- 이미 동물이 있다면 리스트로  -->
				<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

				<div id="petCards" class="mt-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
				  <c:forEach var="p" items="${petList}">
				  <fmt:formatDate value="${p.p_birth}" pattern="yyyy-MM-dd" var="birthStr" />
					  <div class="rounded-2xl border border-gray-200 bg-gray-50 p-4 pet-card"
					       data-pnum="${p.p_num}"
					       data-pname="${p.p_name}"
					       data-ptype="${p.p_type}"
					       data-pgender="${p.p_gender}"
					       data-pweight="${p.p_weight}"
					       data-psize="${p.p_size}"
					       data-pkind="${p.p_kind}"
					       data-pneutered="${p.p_neutered}"
					       data-pbirth="${birthStr}">
				      <div class="flex items-start gap-3">
				        <div class="h-16 w-16 rounded-xl bg-indigo-50 grid place-items-center text-2xl ring-1 ring-indigo-100">🐾</div>
				        <div class="flex-1">
				          <div class="flex items-center justify-between">
				            <div class="font-semibold text-gray-900">${p.p_name}</div>
				            <span class="text-xs text-gray-500">${p.p_type}</span>
				          </div>
				
				          <div class="mt-1 text-xs text-gray-600 space-x-3">
				            <span>성별: <c:if test="${p.p_gender == 'M'}">(남)♂</c:if>
				            			<c:if test="${p.p_gender == 'F'}">(여)♀</c:if></span>
				          </div>
				          <div class="mt-1 text-xs text-gray-600 space-x-3">
				            <span>몸무게: ${p.p_weight}kg</span>
			            	</div>
			            	<div class="mt-1 text-xs text-gray-600 space-x-3">
				            <span>체급: ${p.p_size}</span>
				            </div>
				          <div class="mt-1 text-xs text-gray-600">품종: ${p.p_kind}</div>
				
				          <div class="mt-3 flex gap-2">
				            <button
				              type="button"
				              class="btn-edit inline-flex items-center justify-center h-9 min-w-[64px] px-3 rounded-md border border-gray-300 bg-white text-sm font-medium whitespace-nowrap hover:!bg-indigo-100 hover:text-indigo-600 hover:shadow-sm hover:!border-blue-300 transition-colors "
				              data-pnum="${p.p_num}"
				              data-pname="${p.p_name}"
				              data-ptype="${p.p_type}"
				              data-pkind="${p.p_kind}"
				              data-pgender="${p.p_gender}"
				              data-pweight="${p.p_weight}"
				              data-psize="${p.p_size}"
				              data-pneutered="${p.p_neutered}"
				              data-pbirth="<fmt:formatDate value='${p.p_birth}' pattern='yyyy-MM-dd'/>"
				            >수정</button>
				
				            <form class="frm-delete" method="post" 
				            	action="${pageContext.request.contextPath}/mypage_deletePet.do" >
				              <input type="hidden" name="p_num" value="${p.p_num}">
				              <button type="submit" class="inline-flex items-center justify-center h-9 min-w-[64px] px-3 rounded-md border border-red-200 bg-white text-sm font-medium text-red-600 whitespace-nowrap hover:!bg-red-100 hover:!border-red-300 hover:shadow-sm transition-colors">
				                삭제
				              </button>
				            </form>
				          </div>
				        </div>
				      </div>
				    </div>
				  </c:forEach>
				</div>
			  <c:if test="${empty petList}">
			    <p class="mt-4 text-sm text-gray-500">등록된 반려동물이 없습니다. 아래 폼에서 추가하세요.</p>
			  </c:if>
			</section>
			
			  <section id="editPanel" class="bg-white rounded-2xl shadow-md border border-gray-100 p-6 mt-6 hidden">
				  <div class="flex items-center justify-between">
				    <h3 id="panelTitle" class="text-lg font-semibold text-gray-900">반려동물 추가</h3>
				    <div class="flex gap-2">
				      <button id="btnClosePanel" type="button" class="rounded-lg border px-3 py-2 text-sm hover:bg-gray-50">닫기</button>
				    </div>
				  </div>
				
				  	<form id="petForm" class="mt-4 grid grid-cols-1 sm:grid-cols-2 gap-4"
				        method="post" action="${pageContext.request.contextPath}/mypage_savePet.do">
					    <!-- 어떤 모드인지 표시는 JS로만(서버는 p_num 유무로 판단) -->
					    <input type="hidden" name="p_num" id="p_num">
					    <!-- u_member_id는 서버 세션에서 설정 권장. 필요시 hidden으로 내려도 됨 -->
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">이름</label>
					      	<input name="p_name" id="p_name" required
					             class="w-full rounded-xl border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-indigo-500">
					    </div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">생일</label>
					      	<input type="date" name="p_birth" id="p_birth" required
					             class="w-full rounded-xl border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-indigo-500">
					    </div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">종류</label>
					      	<div class="flex items-center gap-5 h-10">
					        	<label class="flex items-center gap-2 text-sm"><input type="radio" name="p_type" value="강아지" class="type-radio" required> 강아지</label>
					        	<label class="flex items-center gap-2 text-sm"><input type="radio" name="p_type" value="고양이" class="type-radio"> 고양이</label>
					      	</div>
					    </div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">상세 품종</label>
					      	<select name="p_kind" id="p_kind" required
					              class="w-full rounded-xl border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-indigo-500">
					        	<option value="">반려동물 종류를 선택해주세요.</option>
					      	</select>
					    </div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">성별</label>
					      	<select name="p_gender" id="p_gender" required
					              class="w-full rounded-xl border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-indigo-500">
					        	<option value="">-- 선택하세요 --</option>
					        	<option value="M">수컷</option>
					        	<option value="F">암컷</option>
					      	</select>
					    </div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">중성화 여부</label>
					      	<div class="flex items-center gap-6 h-10">
					        	<label class="flex items-center gap-2 text-sm"><input type="radio" name="p_neutered" value="Y"> Y(예)</label>
					        	<label class="flex items-center gap-2 text-sm"><input type="radio" name="p_neutered" value="N" checked> N(아니오)</label>
					      	</div>
				    	</div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">몸무게(kg)</label>
					      	<input type="number" step="0.1" name="p_weight" id="p_weight" required
					             class="w-40 rounded-xl border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-indigo-500">
					    </div>
					
					    <div>
					      	<label class="block text-sm font-medium text-gray-700 mb-1">체급</label>
					      	<div class="flex items-center gap-3">
					        	<input type="hidden" name="p_size" id="p_size" required>
					        	<span id="sizeBadge" class="text-sm text-gray-600">-</span>
					      	</div>
					    </div>
					
					    <div class="sm:col-span-2 mt-2 flex gap-2">
					      	<button type="submit" class="rounded-xl bg-stone-500 text-white px-4 py-2 font-medium hover:bg-stone-400">저장</button>
					      	<button type="button" id="btnReset" class="rounded-lg border px-3 py-2 hover:bg-gray-50">초기화</button>
					    </div>
				  	</form>
				</section>
         	</main>
      	</div>
   	</div>

   <!-- 푸터 시작 -->
   <%@ include file="../setting/footer.jsp"%>
   <!-- 푸터 끝 -->
   
<script>
  // --- 1) 품종 카탈로그 ---  정적배열
  	const DOG_BREEDS = ["말티즈","포메라니안","푸들","진돗개","리트리버","보더콜리","웰시코기","치와와","시츄","시바견","비글","기타"];
  	const CAT_BREEDS = ["코숏","먼치킨","샴","러시안블루","메인쿤","스핑크스","페르시안","터키시앙고라","코리안쇼트헤어","아비시니안","뱅갈","기타"];

  	function fillBreedOptions(selectEl, type, current) {
		// 종류에 맞는 품종을 select옵션으로 재구성
	  	const list = (type === '강아지') ? DOG_BREEDS : (type === '고양이' ? CAT_BREEDS : []);		
	    selectEl.innerHTML = '<option value="">반려동물 종류를 선택해주세요.</option>';	// 기존 select 초기화 맨 위에 placeholder역할
	    list.forEach(b => {		// 각 품종명(b)에 대해 option을 하나씩 만들기
	    	const opt = document.createElement('option');		// select박스의 옵션만들기
	      	opt.value = b; opt.textContent = b;					// 옵션 밸류값을 각 리스트에서 반복순회하며 넣어줌
	      	if (current && current === b) opt.selected = true;	// current가 b와 같으면 선택상태 뷰여
	      	selectEl.appendChild(opt);		// 만들어둔 옵션을 select에 붙ㅇ미 => 즉 placeholder역할 1개, b(옵션) n개 들어감
    	});
  	}

  // --- 2) 체급 계산 ---
  function mapSize(weight) {	
    const n = parseFloat(weight);		// 무조건 실수(float)로 파싱
    if (isNaN(n)) return '';		// 문자열(eba등)이 들어가면 공백처리
    // DB CHECK: '대형','중형','소형' 만 허용 → 간단 3단계 매핑
    if (n < 4)  return '소형';
    if (n < 20) return '중형';
    return '대형';
  }

  // --- 3) 패널 열기/닫기 & 프리필 ---
  const editPanel   = document.getElementById('editPanel');
  const panelTitle  = document.getElementById('panelTitle');
  const btnOpenAdd  = document.getElementById('btnOpenAdd');
  const btnClose    = document.getElementById('btnClosePanel');
  const btnReset    = document.getElementById('btnReset');

  // 폼필드 한곳에 묶어두기(입력요소)F.p_name.value 이런식으로 바로 접근하기 우해
  const F = {
    p_num:     document.getElementById('p_num'),
    p_name:    document.getElementById('p_name'),
    p_birth:   document.getElementById('p_birth'),
    p_kind:    document.getElementById('p_kind'),
    p_gender:  document.getElementById('p_gender'),
    p_weight:  document.getElementById('p_weight'),
    p_size:    document.getElementById('p_size'),
    sizeBadge: document.getElementById('sizeBadge'),
    typeRadios: document.querySelectorAll('input[name="p_type"]')
  };

  function openPanel(mode, data) {
    panelTitle.textContent = (mode === 'edit') ? '반려동물 수정' : '반려동물 추가';
    editPanel.classList.remove('hidden');		// 수정버튼 클릭시 보이기

    // 값 세팅
    F.p_num.value   = data?.p_num || '';		// data? : 옵셔널체인징 -데이터가 없거나 null이어도 undefinded반환
    F.p_name.value  = data?.p_name || '';
    F.p_birth.value = data?.p_birth || '';
    F.p_gender.value= data?.p_gender || '';
    F.p_weight.value= (data?.p_weight ?? '');		// 왼쪽이 null 또는 undefined일떄만 오른쪽 사용
    F.p_size.value  = data?.p_size || '';
    F.sizeBadge.textContent = data?.p_size || '-';		// 표시용 텍스트

    // 타입 라디오 + 품종 옵션
    let currentType = '';		// 초기화
    F.typeRadios.forEach(r => {
    	// data에 p_type이 있으면 radio value값과 일치하는 라디오  check속성 부여, 없으면 기존유지
      r.checked = (data?.p_type ? (r.value === data.p_type) : r.checked);	
      
      if (r.checked) currentType = r.value;		// 체크된 라디오 찾아서 currentType에 저장
      
      r.onchange = () => {		// 라디오가 바뀔때마다 호출
        fillBreedOptions(F.p_kind, r.value);		// 선택 타입에 맞게 품종 옵션들 재생성
        F.p_kind.value = '';			// 타입이 변경되었으니 품종 선택 초기ㅗ하
      };
    });
    // 패널을 열자마자 기본타입 또는 선택된 타입에 맞맞게 품종 채우기
    fillBreedOptions(F.p_kind, currentType, data?.p_kind);

    // 체급 연동
    const onWeight = () => {		// 몸무게/체급 갱신 콜백
      const s = mapSize(F.p_weight.value);
      F.p_size.value = s;		// hidden값을 갱신하기 위함
      F.sizeBadge.textContent = s || '-';		//sizebadge에도 같이 주고 없으면 -
    };
    F.p_weight.oninput = onWeight;	// 콜백함수 대입해 사용자가 input업데이트하는 동안 실시간으로 갱신
    onWeight();		// 패널이 열리자마자 초기화면면도 맞춰줌
  }

  function closePanel() { editPanel.classList.add('hidden'); }	// hidden값 부여

  // 동물 추가 버튼 클릭시 빈 값으로 설정된 폼 오픈
  btnOpenAdd?.addEventListener('click', () => {
    // 반려동물 타입 기본 강아지 설정
    F.typeRadios.forEach(r => r.checked = (r.value === '강아지'));
    openPanel('add', { p_type: '강아지' });
  });

  // 닫기 및 초기화
  btnClose?.addEventListener('click', closePanel);		// 옵션체이닝 -> 버튼 엘리먼트 없으면 걍 건너띔
  btnReset?.addEventListener('click', () => openPanel('add', { p_type: '강아지' }));	// 초기화 버튼이 있을때만 동작

  // 수정버튼클릭시 기존정보 로드
  document.querySelectorAll('.btn-edit').forEach(btn => {		// 페이지내 모든 btn-edit에 클릭리스너 할당
  btn.addEventListener('click', () => {
    const card = btn.closest('.pet-card');      // 버튼에서 위로 올라가면서 .pet-card 조상 요소를 가장 가까운 거 하나 찾기
    const d = card.dataset;		// 할당했던 dataset들을 카멜케이스로 담음

    openPanel('edit', {		// 카멜형식! 주의
      p_num:   d.pnum || '',		// 값이 없을때 빈 문자열 대체
      p_name:  d.pname || '',
      p_type:  d.ptype || '',       // 강아지/고양이
      p_gender:d.pgender || '',     // M/F
      p_weight:d.pweight || '',
      p_size:  d.psize || '',
      p_kind:  d.pkind || '',
      p_neutered: d.pneutered || 'N',
      p_birth: d.pbirth || ''
    });
  });
});

  // 초기 상태: petList가 없으면 패널 자동 오픈
  const hasPets = !!document.querySelector('#petCards > *');	// 카드컨테이너 petCards의 첫번째 자식요소 찾기 잇으면 true, 없ㅇ면 false
  if (!hasPets) {		//반려동물 없다면
    // 기본 타입 강아지
    F.typeRadios.forEach(r => r.checked = (r.value === '강아지'));
    openPanel('add', { p_type: '강아지' });		// 강아지 기본으로 패널을 띄움
  }
  
  // 삭제 ajax
  document.querySelectorAll('.frm-delete').forEach(frm => {		// 삭제폼 제출시 jajx처리
	  frm.addEventListener('submit', async (e) => {
	    e.preventDefault();
	    if (!confirm('삭제할까요?')) return;

	    const url = frm.action;		// 폼의 action속성
	    const formData = new FormData(frm);		// 폼내 모든 데이터필드 수집
	    try {
	      const resp = await fetch(url, {		// 비동기 post요청
	        method: 'POST',
	        body: formData
	      });
	      const data = await resp.json();
	      if (data.ok) {		// 서버에서 ok(200)응답이 오면
	        // 카드 DOM 제거
	        const card = frm.closest('[data-pnum]');	//data-pnum속성이 붙은 가장 가까운 조상
	        if (card) card.remove();		// 삭제성공시 카드 제거

	        // 목록이 비면 안내문 추가 (옵션)
	        if (!document.querySelector('#petCards > *')) {
	          const p = document.createElement('p');
	          p.className = 'mt-4 text-sm text-gray-500';
	          p.textContent = '등록된 반려동물이 없습니다. 아래 폼에서 추가하세요.';
	          document.querySelector('section.bg-white .mt-8').after(p);
	        }
	      } else {
	        alert('삭제 실패: ' + (data.msg || '알 수 없는 오류'));
	      }
	    } catch (err) {
	      alert('삭제 중 오류가 발생했습니다.');
	      console.error(err);
	    }
	  });
	});
</script>
</body>
</html>