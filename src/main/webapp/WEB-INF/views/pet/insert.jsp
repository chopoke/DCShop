<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>반려동물 등록</title>

<!-- css -->
<link rel="stylesheet" href="${path}/resources/css/pet/pet.css"><!-- pet 전용 -->
<link rel="stylesheet" href="${path}/resources/css/customer/join.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style type="text/css">
.hero-section1 {
	width: 100%;
	background: white;
	padding: .5rem 0;
	padding-top: 5rem;
}

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

.stepper.is-2 .seg:nth-child(3) {
    background: #000;
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
<!-- js -->
<script src="https://kit.fontawesome.com/11defe47b4.js" crossorigin="anonymous"></script>
<script src="${path}/resources/js/common/main.js" defer></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript">

	function get_dog() { // "강아지" 클릭 시, "상세품종"의 옵션을 강아지 품종 리스트로 바꿈
		
		$("#selectBox").empty();
		
		$("#selectBox").append("<option value=''>상세품종 선택</option>");
        $("#selectBox").append("<option value='말티즈'>말티즈</option>");
        $("#selectBox").append("<option value='포메라니안'>포메라니안</option>");
        $("#selectBox").append("<option value='푸들'>푸들</option>");
        $("#selectBox").append("<option value='진돗개'>진돗개</option>");
        $("#selectBox").append("<option value='리트리버'>리트리버</option>");
        $("#selectBox").append("<option value='보더콜리'>보더콜리</option>");
        $("#selectBox").append("<option value='웰시코기'>웰시코기</option>");
        $("#selectBox").append("<option value='치와와'>치와와</option>");
        $("#selectBox").append("<option value='시츄'>시츄</option>");
        $("#selectBox").append("<option value='시바견'>시바견</option>");
        $("#selectBox").append("<option value='비글'>비글</option>");
        $("#selectBox").append("<option value='기타'>기타</option>");
        $("#selectBox").val('');       //  기본값 비움
        handleKindChange(document.getElementById('selectBox'));  // handleKindChange 호출.
        
	}
	function get_cat() {  // "고양이" 클릭 시, "상세품종" 옵션을 고양이 품종 리스트로 갈아끼움
		
		$("#selectBox").empty();
		
		$("#selectBox").append("<option value=''>상세품종 선택</option>");
		$("#selectBox").append("<option value='코숏'>코숏</option>");
        $("#selectBox").append("<option value='먼치킨'>먼치킨</option>");
        $("#selectBox").append("<option value='샴'>샴</option>");
        $("#selectBox").append("<option value='러시안블루'>러시안블루</option>");
        $("#selectBox").append("<option value='메인쿤'>메인쿤</option>");
        $("#selectBox").append("<option value='스핑크스'>스핑크스</option>");
        $("#selectBox").append("<option value='페르시안'>페르시안</option>");
        $("#selectBox").append("<option value='터키시앙고라'>터키시앙고라</option>");
        $("#selectBox").append("<option value='코리안쇼트헤어'>코리안쇼트헤어</option>");
        $("#selectBox").append("<option value='아비시니안'>아비시니안</option>");
        $("#selectBox").append("<option value='뱅갈'>뱅갈</option>");
        $("#selectBox").append("<option value='기타'>기타</option>");
        $("#selectBox").val('');       //  기본값 비움
        handleKindChange(document.getElementById('selectBox')); // handleKindChange 호출.
        
	}
</script>

</head>
<body>

<div class="wrap">
	
	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	
	<section class="hero-section1">
	</section>
	
	<main class="container my-4 my-md-5">
		<div id="contents">
			<div class="mb-3">
				<ol class="breadcrumb mb-2">
					<li class="breadcrumb-item"><a
						style="color: black; list-style-type: none"
						href="${pageContext.request.contextPath}/">홈</a></li>
					<li class="breadcrumb-item active">펫 등록</li>
				</ol>

				<div class="stepper is-2">
					<div class="segments">
						<div class="seg"></div>
						<div class="seg"></div>
						<div class="seg"></div>
					</div>
				</div>
			</div>
		</div>
  <!-- 컨텐츠 시작 -->
  <div id="container">
    <div id="contents">
      <!-- 상단 중앙1 시작 -->
      <div id="section1">
        <h1 align="center">반려동물 등록</h1>
      </div>
      <hr style="border: 3px solid">

      <!-- 상단 중앙2 시작 -->
      <div id="section2">
        <div id="s2_inner">
          <div class="join">
            <form action="insertAction.do" method="post">
              <table>
                <tr>
                  <th>* 펫 이름</th>
                  <td><input type="text" name="pet_name" class="input" placeholder="이름 작성"></td>
                </tr>

                <tr>
                  <th>* 생일</th>
                  <td><input type="date" name="pet_birthday" class="input"></td>
                </tr>

				<tr>
				  <th>* 반려동물 종류</th>
				  <td colspan="2">
				    <div class="radio-compact">
				      <label><input type="radio" name="pet_type" value="강아지" onclick="get_dog()"> 강아지</label>
				      <label><input type="radio" name="pet_type" value="고양이" onclick="get_cat()"> 고양이</label>
				    </div>
				  </td>
				</tr>
				
				<tr>
					<th>상세품종</th>
					<td colspan="2" width="300px">
					<select id="selectBox" name="pet_kind" onchange="handleKindChange(this)">
						<option value=''>반려동물 종류를 선택해주세요.</option>
			  		</select>
			  		<!-- '기타'선택 시 -->
			  		<input type="text" id="pet_kind_custom" class="input" placeholder="직접입력"  style="display:none;">
					</td>
				</tr>

                <tr>
                  <th>* 성별</th>
                  <td>
                    <select name="pet_gender" class="input">
                      <option value="">-- 선택하세요 --</option>
                      <option value="M">수컷</option>
                      <option value="F">암컷</option>
                    </select>
                  </td>
                </tr>
                
                <tr>
				  <th>중성화 여부</th>
				  <td colspan="2">
				    <div class="radio-compact">
				      <label><input type="radio" name="pet_neutered" value="Y"> Y(네)</label>
				      <label><input type="radio" name="pet_neutered" value="N" checked> N(아니오)</label>
				    </div>
				  </td>
				</tr>
                

                <tr>
                  <th>* 몸무게(kg)</th>
                  <td>
                    <div style="display:flex; gap:10px; align-items:center;">
                      <input type="number" id="pet_kg" name="pet_kg" class="input" step="0.1" min="0"
                             placeholder="예) 7.5" oninput="updateSize()">
                      <span id="sizeText" class="sizeText" style="min-width:80px;">체급: -</span>
                    </div>
                    <input type="hidden" id="pet_size" name="pet_size"><!-- 서버 전송용 -->
                  </td>
                </tr>

                <tr>
                  <td colspan="2" style="border-bottom:none">
                    <!-- <br> -->
                    <div class="br-toggle"><br></div>

					
                    <div align="right">
                      <input type="hidden" name="u_member_id">
                      <div class="test" style="display: none;">
	                      <a style="color: red">※ 추가등록시 밑에 추가되어있는 항목만 등록됩니다!</a>
                      </div>
                      <button type="button" class="inputButton" id="addAnotherBtn">+ 추가 등록</button>
                      
                      <input class="inputButton" type="submit" value="건너뛰기" >
                      <input class="inputButton" type="submit" value="등록" id="submitBtn">
                      <input class="inputButton" type="reset" value="초기화">
                      <input class="inputButton" type="button" value="취소" onclick="history.back()">
                    </div>
                  </td>
                </tr>
              </table>
              
              <!-- 추가로 모을 리스트 영역 + 서버 보낼 히든 -->
				<div id="addedPetsWrap" style="margin-top:10px; display:none;">  <!-- 추가된 반려동물들을 보여주는 영역(처음엔 숨김) -->
				  <div class="small text-secondary" id="petCountLabel"></div> <!-- 추가된 반려동물 n마리 문구 -->
				  <div id="addedPets" class="pet-list"></div>  <!-- 칩 형태로 각각 표시 -->
				  <input type="hidden" name="petsJson" id="petsJson">  <!-- 모든 추가 된 동물들을 JSON 문자열로 서버에 보내는 hidden -->
				</div>
            </form>
          </div><!-- .join -->
        </div>
      </div>
      <!-- 상단 중앙2 끝 -->
    </div>
	</main>
  <!-- 컨텐츠 끝 -->
</div>

<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->

<script>
  const size = {
    "강아지":[{max:5,label:"소형"},{max:15,label:"중형"},{max:Infinity,label:"대형"}],
    "고양이":[{max:4,label:"소형"},{max:6,label:"중형"},{max:Infinity,label:"대형"}]
  };

  function getSelectedType(){
    const r = document.querySelector('input[name="pet_type"]:checked');
    return r ? r.value : "강아지"; // r이 null이 아니면 r.value 반환 r이 null이면 "강아지" 반환
  }

  function updateSize(){
    const type = getSelectedType();  
    const kg = parseFloat(document.getElementById("pet_kg").value);
    const sizeTextEl = document.getElementById("sizeText");
    const sizeHidden = document.getElementById("pet_size");

    if (isNaN(kg) || kg <= 0){
      sizeTextEl.textContent = "체급: -";
      sizeHidden.value = "";
      return;
    }
    const arr = size[type] || size["강아지"];  // 강아지/고양이 기준표
    let bucket = null;  // 결과 담을 변수

    for (let i = 0; i < arr.length; i++) {
      if (kg <= arr[i].max) {
        bucket = arr[i];
        break;   // 첫 번째로 맞는 조건에서 멈춤
      }
    }
    if (bucket != null) {
        sizeTextEl.textContent = "체급: " + bucket.label;
        sizeHidden.value = bucket.label;
      } else {
        sizeTextEl.textContent = "체급: -";
        sizeHidden.value = "";
      }
   }
  
  document.addEventListener("DOMContentLoaded", function(){
	updateSize();

    var kgInput = document.getElementById("pet_kg");
    kgInput.addEventListener("input", updateSize);

    var radios = document.getElementsByName("pet_type");
    for (var i = 0; i < radios.length; i++) {
      radios[i].addEventListener("change", updateSize);
    }
  });
</script>

<script>
function handleKindChange(sel){
  var isOther = sel.value === '기타';
  var $select = $('#selectBox');
  var $custom = $('#pet_kind_custom');

  if(isOther){
    $custom.show().attr('name','pet_kind').focus(); // 입력칸이 서버 전송 담당
    $select.removeAttr('name');                     
  }else{
    $custom.hide().removeAttr('name').val('');      // 입력칸 숨김/초기화
    $select.attr('name','pet_kind');               
  }
}

// 초기 상태 반영
$(function(){
  handleKindChange(document.getElementById('selectBox'));

  // 폼 제출 시 “기타”면 값 필수 확인
  $('form[action="insertAction.do"]').on('submit', function(e){
    if($('#selectBox').val() === '기타' && !$('#pet_kind_custom').val().trim()){
      alert('상세품종을 직접 입력해주세요.');
      e.preventDefault();
    }
  });
});
</script>

<script>
const pets = []; // 추가 등록된 반력동물이 담기는 배열

function readCurrentPet() {
  const name = $('input[name="pet_name"]').val().trim();
  const birthday = $('input[name="pet_birthday"]').val();
  const type = $('input[name="pet_type"]:checked').val();     // 강아지/고양이
  const kindSel = $('#selectBox').val();
  const kindCustom = $('#pet_kind_custom').val().trim();
  const kind = (kindSel === '기타' ? kindCustom : kindSel);
  const gender = $('select[name="pet_gender"]').val();
  const neutered = $('input[name="pet_neutered"]:checked').val(); // Y/N
  const kg = $('#pet_kg').val();
  const size = $('#pet_size').val();
  const umemberId = $('input[name="u_member_id"]').val();

  // 간단 검증
  if(!name || !birthday || !type || !gender || !kg){  // 필수 항목 중 하나라도 비어있으면 경고 띄우고 함수 중단
    alert('필수 항목(*)을 모두 입력하세요.');
    return null;
  }
  if(kindSel === '기타' && !kindCustom){
    alert('상세품종을 직접 입력하세요.');
    return null;
  }
  return { u_member_id:umemberId, pet_name:name, pet_birthday:birthday, pet_type:type,
           pet_kind:kind || '', pet_gender:gender, pet_neutered:neutered,
           pet_kg:kg, pet_size:size };
}

//HTML 특수문자 이스케이프 (XSS 방지)
function esc(s){
  s = (s == null ? '' : String(s));
  return s.replace(/[&<>"']/g, function(m){ return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;','\'':'&#39;'}[m]); });
}

function renderPets(){
	 const $wrap = $('#addedPetsWrap');        // 전체 래퍼
	 const $list = $('#addedPets').empty();    // 칩 목록
	 var count = Array.isArray(pets) ? pets.length : 0;
	 
	  if (pets.length === 0){
	    $wrap.hide();                           // 아무것도 없을 경우 => 아무것도 안 보이게
	    $('#petCountLabel').text('');
	    $('#petsJson').val('');
	    return;
	  }
	  
  // 한 마리 이상이면 보이게
  $wrap.show();
  $('#petCountLabel').text('추가된 반려동물 ' + count + '마리');
  
  if(pets.length >= 1) {
	  $(".test").show();
  } 
  if(pets.length >= 1) {
	  $(".br-toggle").hide();
  } 

  for(var i=0;i<pets.length;i++){
    var p = pets[i];
    var genderLabel  = (p.pet_gender === 'M' ? '수컷' : (p.pet_gender === 'F' ? '암컷' : '-'));
    var neuterLabel  = (p.pet_neutered === 'Y' ? 'Y(네)' : 'N(아니오)');
    var sizeLabel    = p.pet_size ? esc(p.pet_size) : '-';

    var html =
      '<div class="pet-chip">' +
        '<div class="chip-lines">' +
          '<span><b>펫 이름:</b> ' + esc(p.pet_name) + '</span>' + 
          '<span><b>생일:</b> ' + esc(p.pet_birthday) + '</span>' +
          '<span><b>반려동물 종류:</b> ' + esc(p.pet_type) + '</span>' +
          '<span><b>상세품종:</b> ' + esc(p.pet_kind || '-') + '</span>' +
          '<span><b>성별:</b> ' + genderLabel + '</span>' +
          '<span><b>중성화 여부:</b> ' + neuterLabel + '</span>' +
          '<span><b>몸무게:</b> ' + esc(p.pet_kg) + 'kg</span>' +
          '<span><b>체급:</b> ' + sizeLabel + '</span>' +
        '</div>' +
        '<button type="button" class="del" data-idx="' + i + '">삭제</button>' +
      '</div>';

    $list.append(html);
  }

  $('#petsJson').val(JSON.stringify(pets));  // 서버 전송용
}

// 클릭: 추가 등록
$('#addAnotherBtn').on('click', function(){
  const pet = readCurrentPet();
  if(!pet) return;

  pets.push(pet);
  renderPets();

  // 폼 비우기(다시 입력할 수 있게)
  $('input[name="pet_name"]').val('');
  $('input[name="pet_birthday"]').val('');
  // 상세품종 초기화
  $('#selectBox').val('');
  $('#pet_kind_custom').val('').hide().removeAttr('name');
  $('#selectBox').attr('name','pet_kind');
  // 성별/중성화/체중 초기화
  $('select[name="pet_gender"]').val('');
  $('input[name="pet_neutered"][value="N"]').prop('checked', true);
  $('#pet_kg').val('');
  $('#pet_size').val('');
  $('#sizeText').text('체급: -');
});

// 칩 삭제
$('#addedPets').on('click', '.del', function(){
  const idx = +$(this).data('idx');
  pets.splice(idx, 1);
  renderPets();
});

// 제출 시: 폼에 입력 중인 내용이 또 있다면 같이 담아 보내기
$('form[action="insertAction.do"]').on('submit', function(){
  // 폼에 남은 값이 완성되어 있으면 한 마리 더 추가
  const hasSomething =
    $('input[name="pet_name"]').val().trim() ||
    $('#selectBox').val() || $('#pet_kind_custom').val().trim();

  if(hasSomething){
    const extra = readCurrentPet();
    if(extra){ pets.push(extra); renderPets(); }
  }
});

//등록 버튼 클릭 시: 리스트가 있으면 브라우저 required 우회
$('#submitBtn').on('click', function () {
  if (pets.length > 0) {
    // 개별 필드의 required 해제(리스트 기반으로만 제출)
    $('input[name="pet_name"]').prop('required', false);
    $('input[name="pet_birthday"]').prop('required', false);
    $('select[name="pet_gender"]').prop('required', false);
    $('input[name="pet_kg"]').prop('required', false);
    // pet_type 라디오는 계속 체크 상태라 괜찮음(라디오에 required 이미 한 쪽만 있음)
  }
});
</script>

</body>
</html>