<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>board_detail</title>

<link rel="stylesheet" href="${path}/resources/css/board.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#recommendBtn").click(function() {
		    var btn = $("#recommendBtn");
		    var b_num = btn.data("bnum");
		    
		    if(${sessionScope.sessionid != null}) {
			    if (!btn.hasClass("active")) {
			        // 추천 추가
			        $.ajax({
			            url: "${path}/recommend",
			            type: "POST",
			            data: { b_num: b_num, click: 1 },
			            success: function(result) {
			                if (parseInt(result.success) === 1) {
			                    btn.addClass("active"); // 이미지 교체
				                $("#recommendTotal").text(result.b_recommend); 
			                }
			            },
			            error: function() {
			                alert("추천 처리 중 오류가 발생했습니다.");
			            }
			        });
			    } else {
			        // 추천 취소
			        $.ajax({
			            url: "${path}/recommend",
			            type: "POST",
			            data: { b_num: b_num, click: 0 },
			            success: function(result) {
			                if (parseInt(result.success) === 1) {
			                    btn.removeClass("active"); // 이미지 원복
			                    $("#recommendTotal").text(result.b_recommend); 
			                }
			            },
			            error: function() {
			                alert("추천 취소 중 오류가 발생했습니다.");
			            }
			        });
			    }
		    } else {
		    	if(confirm("로그인이 필요합니다.")) {	// 확인 눌렀을 때
					// 로그인 페이지로 이동	
					location.href="${path}/login_main.do";
				}
				// 취소 누르면 목록페이지 그대로
		    }
		});
	});
	
	// 댓글 등록
	$(function(){
		comment_list();
		
		$('#btnCommentSave').on('click',function(e){
			e.preventDefault();
			comment_add();
		});
		
		$('#btnCommentLogin').on('click',function(e){
			e.preventDefault();
			comment_login();
		});
	});
	function comment_login(){
		if(confirm('로그인이 필요합니다.')){
			location.href="${path}/login_main.do";
		}
	}
	
	function comment_add(){
		
		const content = ($('#c_content').val() || '').trim();
		if(!content.length){
			alert('내용을 입력해주세요.');
			$('#c_content').focus();
			return;
		}
		
		let param = {
			b_num : "${board.b_num}",
			c_content : content
		};
		
		$.ajax({
			url: '${path}/comment_insert',
			type:'POST',
			data: param,
			success:function(){
				$('#c_content').val("");
				comment_list();
			},
			error : function(){
				alert('comment_add() 오류');
			}
		});
	}	
	function comment_list(){
		$.ajax({
			url: '${path}/comment_list',
			type:'POST',
			data: {b_num : "${board.b_num}"},
			success:function(result){
				$('#comment_list').html(result);
			},
			error : function(){
				alert('comment_list() 오류');
			}
		});
	}
	
	// 댓글 수정
	// location.search url에 ?뒷부분
	// new URLSearchParams 그 뒷부분을 쉽게 읽어주는 도우미
	// .get('b_num') b_num값 받을래 없거나 빈값이면 ${board.b_num}<-(서버가 미리 채워넣은 번호)를 대신 씀
	function getBnumFromQuery(){
  		return new URLSearchParams(location.search).get('b_num') || "${board.b_num}";
	}

	// document 화면전체에서
	// click 버튼을 클리하면
	// btnCommentEdit라는 클래스 버튼을
	// function()함수로 작동할거야
	// e.preventDefault를 이용하여 자동문(정해진일만하라는뜻) 닫기(type='submit'이라면 안씀)
	// 수정 버튼에 붙어있는 data-cnum을 꺼내서 cnum에 담고
	// 화면에서 해당 cnum을 가진 댓글 내용 칸()을 찾아서 $td에 담아
	// 만약 그것이 0이면 중단하고 return(종료해) 그것이 수정중이라면 중단하고 return(종료해)
	// 화면에 텍스트만 가져와서 oldText에 담아놓고
	// 취소할때 복원할 수 있도록 origHtml에 저장해놔
	// jsp에서 만들걸(수정을 눌렀을때 나오는) 여기다가 저장 취소 버튼 만들고
	// 옛것은 oldText에 텍스트로 담는다.
	// 요약하면 수정버튼을 클릭했을때 해야하는 action들
	$(document).on('click', '.btnCommentEdit', function(e){
		  e.preventDefault();
		  const cnum = $(this).data('cnum'); // 버튼이 들고 있는 댓글번호
		  const $td  = $('td.c-content[data-cnum="'+ cnum +'"]'); // 그 번호의 글칸 찾기
		  if (!$td.length || $td.data('editing')) return; // 이미 수정중이면 무시

		  const oldText = $.trim($td.text());         // 원래 글
		  $td.data('editing', true).data('origHtml', $td.html()); // 되돌릴 때 필요
		  const editor =
		    '<div class="edit-area">'
		    + '<textarea class="edit-text" style="width:100%;height:80px;">' + $('<div>').text(oldText).html() + '</textarea>'
		    + '<div style="margin-top:8px;text-align:right;">'
		    + '  <button type="button" class="inputButton btnEditSave" data-cnum="'+cnum+'">저장</button> '
		    + '  <button type="button" class="inputButton btnEditCancel">취소</button>'
		    + '</div></div>';
		  $td.html(editor);
		});

	// 댓글 수정 저장
	// 이제 댓글 수정 클릭해서 나온 저장 버튼을 눌렀을때
	// 전체화면에서 수정버튼을 클릭하면 함수로 작용
	// 수정텍스트를 newText에 담고
	// cnum을 찾아와 bnum에 담고
	// 만약 newText가 0이라면 내용입력 알러창 띄우고 확인시 내용란 포커스해주기 종료
	$(document).on('click', '.btnEditSave', function(e){
	  e.preventDefault();
	  const cnum = $(this).data('cnum') ?? $(this).val(); // ?? 0이어도 진행
	  const $td = $(this).closest('td.c-content');
	  const newText = ($td.find('.edit-text').val() || '').trim();
	  const bnum = getBnumFromQuery();
	  if (!newText.length){ alert('내용을 입력해주세요.'); $td.find('.edit-text').focus(); return; }

	  // 서버에서 전달 수정
	  // 성공하면 목록 갱신
	  // 실패하면 콘솔 error알림
	  $.ajax({
	    url: '${path}/comment_update',
	    type: 'POST',
	    data: { c_num: cnum, c_content: newText, b_num: bnum },
	    success: function(){ comment_list(); },
	    error: function(xhr){ console.error('comment_update error', xhr.status, xhr.responseText); alert('comment_update() 오류'); }
	  });
	});
	
	//댓글 수정 취소
	// 키값(origHtml) 가져와서 담고
	// 수정취소시 다시 원상복구
	$(document).on('click', '.btnEditCancel', function(e){
	  e.preventDefault();
	  const $td = $(this).closest('td.c-content');
	  const orig = $td.data('origHtml');
	  if (orig != null) {
	    $td.html(orig).data('editing', false).removeData('origHtml');
	  } else {
	    comment_list(); // 안전장치
	  }
	});

	// 삭제 (동일하게 cnum 읽기 보강)
	$(document).on('click', '.btnCommentDelete', function(e){
	  e.preventDefault();
	  const cnum = $(this).data('cnum'); 
	  const bnum = getBnumFromQuery();
	  if (!confirm('삭제하시겠습니까?')) return;
	
	  $.ajax({
	    url: '${path}/comment_delete',
	    type: 'POST',
	    data: { c_num: cnum, b_num: bnum },
	    success: function(){ comment_list(); },
	    error: function(){ alert('comment_delete() 오류'); }
	  });
	});
	
</script>
	<script>
		//삭제확인
		function confirmDelete(b_num) {
		    if (confirm("해당 게시물을 삭제하시겠습니까?")) {
		        location.href = "${path}/board_delete?b_num=" + b_num;
		    }
		}
		
		// 수정 페이지 이동
		function goUpdate(b_num) {
		    location.href = "${path}/board_update?b_num=" + b_num;
		}

	</script>
	
	<script>
	function goUpdate(b_num) {
	    if (!b_num || b_num === "undefined" || isNaN(b_num)) {
	        alert("게시글 번호가 유효하지 않습니다.");
	        return;
	    }
	    location.href = "${path}/board_update?b_num=" + b_num;
	}
</script>


</head>
<body class="page-comm">

	<div class="wrap">
		<!-- 헤더 부분 -->
		<%@ include file="/WEB-INF/views/setting/header.jsp" %>
		
		<section class="hero-section1">
		</section>
		<!-- 컨텐츠 부분 -->
		<div id="container">
			<div id="contents">
				<!-- <div class="titleArea" align="center">
					<h1 align="center"> 상세페이지 </h1>
				</div> -->
				<center><img alt="" src="resources/img_main/카테.png" height="100px"></center>
				<div class="text-overlay1">
				        	<h4><b>${board.b_category}</b></h4>
				      	</div>
				
				<c:set var="user" value="${board.userDTO[0]}"/>
				<div>
					<div class="table_div">
						<form name="insertForm" method="post">
							<table>
								<tr>
									<td align="left">
										<div style="font-size: 25px">[${board.b_category}] ${board.b_title}</div> 
										<div style="font-size: 15px" align="right">작성자 : ${user.u_nickname}</div>
									</td>
								</tr>
								<tr>
									<th align="left">
										<div class="inline">
											<img src="/DCShop/resources/image/board/추천_total.png">
										 	<span  id="recommendTotal"> ${board.b_recommend} </span> 
										 </div> 
										<div class="inline"> 조회 ${board.b_views} </div>
									</th>
								</tr>
								<tr>
									<td> 
										<div style="min-height: 700px; white-space: pre-line;" align="left">
											${board.b_contents} 
											<img src="${board.b_image}" style="width:350px">
										</div>
										<div align="right" style="height: 20px">
											<div style="font-size: 15px"> 등록일 : ${board.b_dateposted} </div> 
										</div>
										<c:if test="${board.b_updateDate != null}">
											<div align="right" style="height: 20px">
												<div style="font-size: 15px"> 수정일 : ${board.b_updateDate} </div>
											</div>
										</c:if>
									</td>
								</tr>
								<tr>
									<td>
										<c:if test="${isRecommended == 0}">
											추천하기 <input type="button" class="recommendButton" id="recommendBtn" data-bnum="${board.b_num}">
										</c:if>
										<c:if test="${isRecommended == 1}">
											추천하기 <input type="button" class="recommendButton active" id="recommendBtn" data-bnum="${board.b_num}">
										</c:if>
									</td>
								</tr>
							</table>
							<div align="right">
								<br>
								<!-- 작성자 본인일 때만 수정/삭제 버튼 노출 -->
								<c:if test="${sessionScope.sessionid == user.u_id}">
									<input type="button" class="inputButton" value="수정" 
									   onclick="goUpdate('${board.b_num}')">
									<input type="button" class="inputButton" value="삭제" 
									   onclick="confirmDelete('${board.b_num}')">
								</c:if>
								<input type="button" class="inputButton" value="목록" onclick="window.location='${path}/board_list'">
							</div>
						</form>
					</div>
				</div>
				<!-- 댓글 부분 -->
				<div class="table_div">
					<!-- 댓글목록 -->
					<div id="comment_list" align="center">
					</div>
					<!-- 댓글 입력 코드 -->
					<c:choose>
						<c:when test="${not empty sessionScope.sessionid}">
							<table>
								<tr style="border-top: 1px solid #e5e5e5;">
									<th style="width:150px">댓글작성</th>
									<td style="width:270px; text-align:left">
										<textarea style="width:600px" rows="5" cols="93" name="c_content" id="c_content" placeholder="댓글입력"></textarea>
									</td>
									<th style="width:40px" rowspan="2" align="right">
										<center><input type="button" class="inputButton" value="작성" id="btnCommentSave"></center>
									</th>
								</tr>
							</table>
						</c:when>
						<c:otherwise>
							<table>
								<tr>
									<th style="width:150px">댓글작성<br>(로그인후 작성가능)</th>
									<td style="width:270px; text-align:left">
										<textarea style="width:600px" rows="5" cols="93" name="c_content" id="c_content" placeholder="댓글입력"></textarea>
									</td>
									<th style="width:40px" rowspan="2" align="right">
										<center><input type="button" class="inputButton" value="작성" id="btnCommentLogin"></center>
									</th>
								</tr>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<!-- 컨텐츠 끝 -->
		<!-- footer 부분 -->
		<%@ include file="/WEB-INF/views/setting/footer.jsp" %>
	</div>
</body>
</html>