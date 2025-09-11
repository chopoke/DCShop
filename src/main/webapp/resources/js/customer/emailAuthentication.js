/**
 * 이메일 인증
 */

// /DCShop 경로 시작(setting.jsp에 설정 : pageContext.request.contextPath)
// window라는게, 가장 최상위 객체라고 하네요.
var CTX = window.CTX

// 초기화
var emailTimerId = null, emailMsgHideId = null;

// 공통적으로 메시지를 보여주기 위해서 사용[이메일 인증에 대한 에러, 성공 등..]
function showMsg(text, type, hideAfterMs){
	clearTimeout(emailMsgHideId);
	var $m = $('#emailMsg').removeClass('ok err').addClass(type === 'ok' ? 'ok' : 'err');
	$m.text(text).fadeIn(120);
	if(hideAfterMs && hideAfterMs > 0){
	  emailMsgHideId = setTimeout(function(){ $m.fadeOut(150); }, hideAfterMs);
	}
}

// 유효시간에 대한 시간
function formatSec(s){
  var m = Math.floor(s/60), ss = String(s%60).padStart(2,'0');
  return m + ':' + ss;
}

function onExpire(){
    $('#emailTimer').text('만료됨').removeClass('muted');
    // 인증코드/버튼 숨김
    $('#emailCode').val('');
    $('#input-group-text').addClass('hidden');
    $('#btnVerify').prop('disabled', true).addClass('hidden');
    $('#emailCode').addClass('hidden');
    showMsg('인증코드가 만료되었습니다. 다시 발송해 주세요.', 'err', 3000);
}

function startEmailTimer(ttlSec){
	
    clearInterval(emailTimerId);
    var left = parseInt(ttlSec, 10); // ttlSec : 180이 서버로 부터 넘어와 3분으로 바꿈...
    // 영역 보이기 및 요소 초기화
    $('#emailCode').val("");
    $('#emailVerifyBox').removeClass('hidden');
    $('#btnVerify').prop('disabled', false).removeClass('hidden');
    $('#emailCode').prop('disabled', false).removeClass('hidden').focus();
    $('#emailTimer').addClass('muted');

    if(isNaN(left) || left <= 0){ onExpire(); return; }
    $('#emailTimer').text(formatSec(left));

	// 3분이 주어지고, 1초마다 지속적으로 1초씩 깍김
    emailTimerId = setInterval(function(){
        left--;
        if(left <= 0) { 
        	clearInterval(emailTimerId); onExpire(); return; 
        }
        $('#emailTimer').text(formatSec(left));
    }, 1000);
}

// 코드 발송
function authnum_email(){

	// @ 앞부분 미리 입력시
	if(!$('#u_mail1').val()) {
		alert("이메일을 입력해주세요.");
		 $('#u_mail1').focus();
		return false;
	}
	
	// @ 둿 부분 미 선택이거나 미 입력시
	if(!$('#u_mail2').val()) {
		alert("목록을 선택해주세요.");
		 $('#u_mail2').focus();
		return false;
	}

	// 이메일 형식 유효성 검사
	var to = $('#u_mail1').val().trim() + "@" + $('#u_mail2').val();
	const emailRe = /^[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?\.)+[A-Za-z]{2,}$/;
	if(!emailRe.test(to.trim())){ 
		showMsg('올바른 이메일을 입력하세요.', 'err', 2500); 
		$('#u_mail1').focus(); 
		return false; 
	}

	// 코드 발송 누르고 잠깐 동안 비활성화(여러 번 중복 버튼 누르는 거 방지)
	$('#btnSend').prop('disabled', true);
	
$.ajax({
	 url : CTX + '/sendCode.do',
	 type: 'POST',
	 data: { to : to },
	 dataType: 'json',
	    /* 
	    	캐시 처리 옵션 - cache
			IE 브라우저에서 Ajax를 사용하다 보면, 데이터가 갱신이 안되고, 이전 데이터가 그대로 남아있는 경우가 있습니다. 이는 IE 브라우저에서 ajax통신을 할 때, 새로 url을 호출하지 않고, 가지고 있는 cache값을 그대로 노출시켜주기 때문인데요. 이때는 cache옵션을 사용하여, 이런 현상을 방지할 수 있습니다. 
			출처: https://hohoya33.tistory.com/38 [개발 메모장:티스토리]
	    */
     cache: false,
     success : function(res){
	    if(res && res.ok){
		    showMsg('인증코드가 전송되었습니다. 입력 후 검증을 눌러주세요.', 'ok', 3000); // 3초 뒤 사라짐
		    var ttl = Number(res.ttlSec) || 180;
		    startEmailTimer(ttl);
		}else{
		    showMsg('발송 실패 또는 만료되었습니다.', 'err', 3000);
	    }
     },
     error : function(jqXHR) {
     	/*
     		에러 영역에 error : function( jqXHR, textStatus, errorThrown ) 3가지  파라미터 사용
     		참고 사이트 : https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=afidev&logNo=20184722536
     	*/
    	showMsg('에러: ' + jqXHR.status, 'err', 3000);
     },
     complete : function() {
     	/*
     		complete : 는 자바 try - cartch { } 블록에서 마지막 finally 로서 자기 임무를 수행
			[출처] [ jQuery ] ajax의 success , error 그리고 complete. ( 소스코드 )|작성자 사진찍는 개발자
		*/
		$('#btnSend').prop('disabled', false);
     	
     }
  })
}




// 검증
function verifyEmailCode(){
	var code = $('#emailCode').val().trim();
	
	// 숫자가 6자리인지, 유효성 체크
	if(!/^[0-9]{6}$/.test(code)){
	    showMsg('6자리 숫자만 입력하세요.', 'err', 2000); 
	    $('#emailCode').focus(); 
	    return false; 
	}
	
    // 검증 버튼 누르면, verify.do Controller 타기
    $.ajax({
        url : CTX + '/verify.do',   // 현재 GET으로 설계되어 있으면 그대로
        type: 'POST',
        data: { code: code },
        dataType: 'json',
        cache: false,                // ✅ jQuery 캐시 방지
        
        success: function(res) {
	      if (res && res.ok) {
	      	// 인증 성공했다. 그러면, N -> Y
	        $('#emailVerified').val('Y');
	        clearInterval(emailTimerId); // 시간 부분 초기화
	        // ----> 여기부터 객체
	        $('#emailTimer').text('인증 완료').removeClass('muted');
	        showMsg('인증이 완료되었습니다.', 'ok', 2000);
	        $('#input-group-text').addClass('hidden'); // 있으면 숨김
	        $('#btnVerify').addClass('hidden');
	        $('#emailCode').addClass('hidden').prop('disabled', true);
	        // <--- 여기까지 객체
	        
	      } else if (res && res.reason === 'expired') {
	        onExpire(); // 서버가 만료 판정 시 즉시 만료 UI 동기화
	      } else {
	        showMsg('인증 실패. 코드를 확인하세요. ' + (res && res.reason || ''), 'err', 2500);
	        $('#emailVerified').val('N');
	        $('#emailCode').focus().select();
	      }
    	},
    	error: function(xhr){
	        showMsg('검증 에러: ' + xhr.status, 'err', 3000);
	        $('#btnVerify').prop('disabled', false);
	    }
	});

}