<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 작성 페이지</title>
</head>
<script src="<c:url value='https://cdn.tailwindcss.com/3.4.16'/>"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
      rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
      rel="stylesheet"/>
    <style>
      :where([class^="ri-"])::before { content: "\f3c2"; }
    </style>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              primary: "#ff6b35",
              secondary: "#ffa726",
            },
            borderRadius: {
              none: "0px",
              sm: "4px",
              DEFAULT: "8px",
              md: "12px",
              lg: "16px",
              xl: "20px",
              "2xl": "24px",
              "3xl": "32px",
              full: "9999px",
              button: "8px",
            },
          },
        },
      };
    </script>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(function() {  // 상세페이지가 로딩되면
      // 페이지 로딩 시 문의 목록 호출
      question_list(1);
      // 문의 작성 버튼 클릭시 question_add함수 호출
      $('#SaveQuestion').click(function() {
    	  question_add();
      });
   });
   
   // [작성 버튼 클릭 시 호출]
   function question_add() {
      // 문의 데이터 검사
		const fields = [
			//1)각 항목별로 데이터가 들어있지 않다면 --...
		    { id: "#q_category", msg: "유형를 선택해주세요." },
		    { id: "#q_title", msg: "제목을 입력해주세요." },
		    { id: "#q_content", msg: "문의내용을 입력해주세요.", trim: true }
		  ];

		  for (const f of fields) {
		    const value = f.trim ? $.trim($(f.id).val()) : $(f.id).val();
		    //2) ...--> msg의 문구를 alert로 띄우기
		    if (value === "") {
		      alert(f.msg);
		      $(f.id).focus();
		      return false;
		    }
		  }
      
		// 문의 내용을 파라미터로 넘김 
      let param = {	//문의자는 session이므로 controller에서 request로 직접받음.
         "pd_id" : ${param.pd_id}, //상품 상세페이지에서 받은 삼품번호 파라미터로 넘기기
         "q_title" : $('#q_title').val(),		//문의 제목
         "q_content" : $('#q_content').val(),	//문의 내용
         "q_secret" : $('#q_secret').val(),
         "q_category" : $('#q_category').val(),
      }
      $.ajax({
         url: '${path}/question_insert.qa',  // 컨트롤러 이동(3)
         type: 'POST',
         data: param,
         success: function() {  // 콜백함수(6) => 문의작성이 완료되면 서버에서 콜백함수 호출
            $('#q_writer').val("");
            $('#q_title').val("");
            $('#q_content').val("");
            question_list();   // 문의목록 새로고침(7)
         },
         error: function() {
            alert('문의가 등록되지 않았습니다.');
         }
      });
   }
   
	// 문의목록 불러오기
   function question_list(pageNum) {
      $.ajax({
         url: '${path}/quest_list.qa',  // 컨트롤러 이동
         type: 'POST',
         data: {
        	pd_id: '${param.pd_id}',
         	pageNum: pageNum
      	 },
         success: function(result) {
            $('#quest_list').html(result);   // 콜백함수
         },
         error: function() {
            alert('문의 목록 불러오기를 실패하였습니다.');
         }
      });
   }
</script>

<body>
	<!-- 문의 목록 코드 -->
	<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div class="bg-white rounded-lg shadow-sm border">
		<div id="quest_list" align="center">
				<!-- 문의목록 불러오기 -->
		</div>
		
        <div class="p-8">
          <div class="border-t pt-8">
            <h3 class="text-lg font-bold text-gray-900 mb-6">문의 작성</h3>

            <div class="bg-gray-50 rounded-lg p-6">
              <table class="w-full">
                <tbody>
                  <tr>
                    <th class="bg-gray-100 px-4 py-3 text-left font-medium text-gray-700 w-32 border border-gray-200">
                      글제목
                    </th>
                    <td class="px-4 py-3 border border-gray-200">
                      <input
                        type="text"
                        id="q_title"
                        name="q_title"
                        maxlength="50"
                        class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                        placeholder="문의 제목을 입력하세요"
                      />
                    </td>
                    <td class="px-4 py-3 border border-gray-200">
                      <div class="flex items-center space-x-2">
                        <input
                          type="checkbox"
                          name="q_secret"
                          id="q_secret"
                          class="w-4 h-4 text-primary bg-gray-100 border-gray-300 rounded focus:ring-primary"
                          value="Y"/>
                        <label for="q_secret" class="text-sm text-gray-700">비밀글 여부</label>
                      </div>
                    </td>
                    <td class="px-4 py-3 border border-gray-200">
                      <select name="q_category" id="q_category" class="px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent pr-8">
                        <option value="">문의 유형</option>
                        <option value="교환">교환</option>
                        <option value="환불">환불</option>
                        <option value="배송">배송</option>
                        <option value="가격">가격</option>
                        <option value="품절">품절</option>
                        <option value="입고">입고</option>
                        <option value="기타">기타</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th class="bg-gray-100 px-4 py-3 text-left font-medium text-gray-700 w-32 border border-gray-200 align-top">
                      문의 내용
                    </th>
                    <td class="px-4 py-3 border border-gray-200" colspan="2">
                      <textarea
                        rows="5"
                        name="q_content"
                        id="q_content"
                        placeholder="문의사항을 자세히 입력해주세요"
                        class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 
                        focus:ring-primary focus:border-transparent resize-vertical"></textarea>
                    </td>
                    <td class="px-4 py-3 border border-gray-200 text-center align-middle">
                      <button
                        type="button"
                        id="SaveQuestion"
                        class="bg-primary text-white px-6 py-2 !rounded-button font-medium hover:bg-orange-600 transition-colors whitespace-nowrap">
                        작성
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </main>
</body>
</html>