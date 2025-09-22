/**
 * 회원가입 관련 이벤트
 */


// /DCShop 경로 시작(setting.jsp에 설정 : pageContext.request.contextPath)
// window라는게, 가장 최상위 객체라고 하네요.
var CTX = window.CTX

// 아이디 입력 후 중복체크 확인 까지 했지만, 다시 아이디를 입력시 다시 중복체크 해야함...
$('#u_id').on('change', function(e) {
	document.inputform.hiddenUserid.value = "0";
});

// 아이디 입력 후 중복체크 확인 까지 했지만, 다시 아이디를 입력시 다시 중복체크 해야함...
$('#u_nickname').on('change', function(e) {
	document.inputform.hiddenUserNickName.value = "0";
});

// 아이디 중복확인 버튼 클릭시
// 1. 아이디 중복확인 페이지 open
function confirmId() {
	const userId = document.getElementById('u_id');
	if (userId.value == "") {
		alert("아이디를 입력하세요.");
		document.inputform.u_id.focus();
		return false;
	}
	//중복확인 버튼 클릭시 컨트롤러 url을 전달, 컨트롤러에 소스 추가
	let url = CTX + "/idConfirmAction.do?u_id=" + document.inputform.u_id.value;
	window.open(url, "confirm", "menubar=no, width=500, height=400");
}

function confirmNickName() {
	const userNickName = document.getElementById('u_nickname');
	if (userNickName.value == "") {
		alert("닉네임을 입력하세요.");
		document.inputform.u_id.focus();
		return false;
	}
	//중복확인 버튼 클릭시 컨트롤러 url을 전달, 컨트롤러에 소스 추가
	let url = CTX + "/nickNameConfirmAction.do?u_nickname=" + document.inputform.u_nickname.value;
	window.open(url, "confirm", "menubar=no, width=500, height=400");
}

// 아이디 중복체크 했는지?
function setUserId(userid) {

	opener.document.inputform.u_id.value = userid;
	opener.document.inputform.hiddenUserid.value = "1";
	self.close();

}

// 닉네임 중복체크 했는지?
function setUserNickName(userNickName) {

	opener.document.inputform.u_nickname.value = userNickName;
	opener.document.inputform.hiddenUserNickName.value = "1";
	self.close();

}

// 회원가입, 수정시의 이메일
function selectEmailChk(selectElem) {

	const email2 = document.getElementById('u_mail2');
	const value = selectElem.value;
	if (value === '0') {
		email2.value = '';
		email2.focus();
	} else {
		email2.value = value;
	}

}

// 2. join.jsp - onSubmit시 - 회원가입페이지 필수 체크
// onSubmit(제출)
function singleCheck(e) {

    // 아이디 중복체크
	if (document.inputform.hiddenUserid.value == "0") {
		alert("아이디 중복확인 해주세요.!!");
		document.inputform.u_id.focus();
		return false;
	}
	
	// 닉네임 중복체크
	if (document.inputform.hiddenUserNickName.value == "0") {
		alert("닉네임 중복확인 해주세요.!!");
		document.inputform.u_nickname.focus();
		return false;
	}

	// [필수] - 비밀번호 불일치 => 과제
	if (document.inputform.u_password.value != document.inputform.re_password.value) {
		alert("비밀번호가 불이치합니다.");
		return false;
	}

    // [필수] - 이메일 인증 유무
	if(document.inputform.emailVerified.value == "N") {                   
		alert("이메일 인증을 해주세요");
		return false;
	}
	
}

// 주소 API
// 참고한 URL : https://business.juso.go.kr/addrlink/openApi/searchApi.do
$(function() {
  // 실시간 검색
  $('#u_address').on('keyup', function(e) {
    var keyword = $(this).val().trim();
     if (keyword.length < 5) {
      $('#addrResult').hide();
      return;
    }

    $.ajax({
      url: "https://business.juso.go.kr/addrlink/addrLinkApiJsonp.do",
      type: "GET",
      data: {
      	// 해당 API 서벙 요구하는 정보
        keyword: keyword,
        confmKey: "devU01TX0FVVEgyMDI1MDczMDEyMzQyNDExNjAwMzc=", // 본인 인증키
        resultType: "json" // 검색결과형식 설정 : 서버로부터 응답받을 데이터의 형식 {statusCode : "200", data: "", messsage : ""}
        /*
        	JSONP 기본원리
			- 한 웹페이지에서 도메인이 다른 웹페이지로 데이터를 요청할 때 사용하는 자바스크립트 개발 방법론
			- 웹 브라우저는 도메인이 다른 웹 페이지로는 Ajax 등의 방법으로 접근하지 못하게 제한 : 동일출처원칙(Same-origin policy)
			- JSONP는 바로 이러한 경우에 동일출처원칙을 회피하는 일종의 편법
			- type 값은 무조건 GET으로 고정해야함
        */
      },
      dataType: "jsonp", // 실제 데이터를 어떤식으로 받도 싶은건지?
      success: function(data) {
      	// 통신이 성공하면, 여기로 옴... success는 트리거를 여기서 함...
      	
      	// 승인되지 않은 KET인 경우
      	if(data.results.common.errorCode == "E0001") {
      		$('#addrResult').html(
                '<div class="text-danger p-2">인증키 오류(E0001): ' +
                (data.results.common.errorMessage || '인증키를 확인하세요') + '</div>'
            ).show();
            return false;
      	}
      	
      	var html = '';
      	/*
	      	<div class="addr-item" 
	      		data-road="서울특별시 강남구 양재천로 199 (도곡동)" 
	      		data-zip="06300" style="padding:5px;cursor:pointer;">
	      		서울특별시 강남구 양재천로 199 (도곡동) <span style="color:#888">
	      		[06300]</span>
	      	</div>
      	*/
        if(data.results && data.results.juso && data.results.juso.length > 0) {
          data.results.juso.forEach(function(addr) {
            html += '<div class="addr-item" '
                  + 'data-road="' + addr.roadAddr + '" '
                  + 'data-zip="' + addr.zipNo + '" '
                  + 'style="padding:5px;cursor:pointer;">'
                  + addr.roadAddr + ' <span style="color:#888">[' + addr.zipNo + ']</span>'
                  + '</div>';
          });
          $('#addrResult').html(html).show();
        } else {
          // 조회시 값이 존재하지 않을 경우
          $('#addrResult').html('<div style="padding:5px;">검색 결과 없음</div>').show();
        }
      },
      error : function(xhr, ajaxSettings, thrownError) {
      		// 자체의 통신에 에러가 생길 경우, error에서 예외 처리를 할 수 있습니다.
	        alert(thrownError + ":" + xhr.status);
	  }
    });
  });

  // 결과 클릭 시: 주소와 우편번호 분리 입력 => 목적 각 u_address에는 도로명 주소 / u_zip_code에 우편번호 넣기
  $(document).on('click', '.addr-item', function() {
  	//
    var roadAddr = $(this).data('road');
    var zipNo = $(this).data('zip');
    
    //
    $('#u_address').val(roadAddr);
    $('#u_zip_code').val(zipNo);
    
    // 주소 검색 부분 숨기기
    $('#addrResult').hide();
  });

});