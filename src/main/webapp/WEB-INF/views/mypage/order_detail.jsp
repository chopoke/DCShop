<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - 독캣배송</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>

<style type="text/css">
.hero-section1 {
	width: 100%;
	background: white;
	padding: .5rem 0;
	padding-top: 5rem;
}
:where([class^="ri-"])::before { content: "\f3c2"; }
.custom-scrollbar::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}
.custom-scrollbar::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 3px;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
    background: #c1c1c1;
    border-radius: 3px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
    background: #a8a8a8;
}
</style>
<script>
tailwind.config = {
  theme: {
    extend: {
      colors: {
        primary: "#0066FF",
        secondary: "#6B7280",
      },
      borderRadius: {
        none: "0px",
        sm: "4px",
        DEFAULT: "8px",
        md: "12px",
        lg: "0.5rem",
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
				<img src="resources/img_main/mypage_default.png" alt="Profile"
					class="rounded-full w-28 h-28 object-cover mb-4">
				<h2 class="text-lg font-semibold">Sarah Johnson</h2>
				<p class="text-gray-500 text-sm mb-4">sarah@example.com</p>
				<button
					class="px-4 py-2 bg-stone-950 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>
				

				<!-- 네비게이션 -->
				<nav class="w-full space-y-2 text-sm">
                  <a href="${pageContext.request.contextPath}/mypage_editPet.do" class="block py-2 px-3 rounded hover:bg-gray-100">내 반려동물</a> 
                  <a href="./orderList" class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a> 
                  <a href="./cartList" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a> 
                  <a href="./mypage/my_reviews.do" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a>
                  <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
               </nav>
			</aside>

			<!-- 메인 콘텐츠 -->
			<div class="max-w-7xl mx-auto p-6">
		      <div class="flex items-center justify-between mb-6">
		        <h1 class="text-2xl font-bold text-gray-900">주문 상세</h1>
		        <button
		          class="px-4 py-2 text-sm text-gray-600 hover:text-gray-900 flex items-center gap-2 !rounded-button"
		        >
		          <i class="ri-arrow-left-line"></i>
		          목록으로
		        </button>
		      </div>
		
		      <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
		        <div class="flex justify-between items-start mb-6">
		          <div>
		            <div class="text-sm text-gray-500">주문번호</div>
		            <div class="text-lg font-medium">ORD20250909001</div>
		          </div>
		          <div class="px-3 py-1 bg-gray-300 text-black rounded-full text-sm">
		            배송 준비중
		          </div>
		        </div>
		
		        <div class="grid grid-cols-2 gap-6">
		          <div>
		            <h3 class="text-sm font-medium text-gray-900 mb-4">주문자 정보</h3>
		            <div class="space-y-3">
		              <div class="flex">
		                <span class="w-24 text-sm text-gray-500">주문자</span>
		                <span class="text-sm">김민수</span>
		              </div>
		              <div class="flex">
		                <span class="w-24 text-sm text-gray-500">연락처</span>
		                <span class="text-sm">010-1234-5678</span>
		              </div>
		              <div class="flex">
		                <span class="w-24 text-sm text-gray-500">회원 ID</span>
		                <span class="text-sm">minsu.kim</span>
		              </div>
		            </div>
		          </div>
		
		          <div>
		            <h3 class="text-sm font-medium text-gray-900 mb-4">배송 정보</h3>
		            <div class="space-y-3">
		              <div class="flex">
		                <span class="w-24 text-sm text-gray-500">배송주소</span>
		                <span class="text-sm"
		                  >서울특별시 강남구 테헤란로 123 (06234)</span
		                >
		              </div>
		              <div class="flex">
		                <span class="w-24 text-sm text-gray-500">배송요청</span>
		                <span class="text-sm">부재시 경비실에 맡겨주세요</span>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		
		      <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
		        <h3 class="text-sm font-medium text-gray-900 mb-4">상품 정보</h3>
		        <div class="border rounded-lg overflow-hidden">
		          <table class="min-w-full divide-y divide-gray-200">
		            <thead class="bg-gray-50">
		              <tr>
		                <th
		                  class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
		                >
		                  상품정보
		                </th>
		                <th
		                  class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase"
		                >
		                  수량
		                </th>
		                <th
		                  class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase"
		                >
		                  주문금액
		                </th>
		              </tr>
		            </thead>
		            <tbody class="bg-white divide-y divide-gray-200">
		              <!-- 상품 리스트 영역 -->
		              
		              <tr>
		                <td class="px-6 py-4">
		                  <div class="flex items-center">
		                    <div
		                      class="h-16 w-16 flex-shrink-0 rounded-lg bg-gray-100"
		                    ><img alt="" src=""></div>
		                    <div class="ml-4">
		                      <div class="text-sm font-medium text-gray-900">
		                        스마트폰 케이스
		                      </div>
		                      <div class="text-sm text-gray-500">PD_ID: PRD001</div>
		                    </div>
		                  </div>
		                </td>
		                <td class="px-6 py-4 text-sm text-gray-500 text-center">2개</td>
		                <td class="px-6 py-4 text-sm text-gray-900 text-right">
		                  39,800원
		                </td>
		              </tr>
		              
		              <!-- 상품 리스트 영역 끝 -->
		            </tbody>
		            <tfoot class="bg-gray-50">
		              <tr>
		                <td
		                  colspan="2"
		                  class="px-6 py-4 text-sm text-gray-500 text-right"
		                >
		                  총 결제금액
		                </td>
		                <td class="px-6 py-4 text-right">
		                  <span class="text-lg font-bold text-black">39,800원</span>
		                </td>
		              </tr>
		            </tfoot>
		          </table>
		        </div>
		      </div>
		
		      <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
		        <h3 class="text-sm font-medium text-gray-900 mb-4">배송 현황</h3>
		        <!-- <div class="relative flex justify-center">
  				<div class="flex items-center justify-between mb-8 w-3/4">
		            <div class="w-full flex items-center">
		              <div class="relative flex items-center justify-center">
		                <div
		                  class="w-10 h-10 bg-primary rounded-full flex items-center justify-center"
		                >
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">주문완료</div>
		                </div>
		              </div>
		              <div class="flex-1 h-1 bg-primary"></div>
		            </div>
		
		            <div class="w-full flex items-center">
		              <div class="relative flex items-center justify-center">
		                <div
		                  class="w-10 h-10 bg-primary rounded-full flex items-center justify-center"
		                >
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">배송준비</div>
		                </div>
		              </div>
		              <div class="flex-1 h-1 bg-primary"></div>
		            </div>
		
		            <div class="w-full flex items-center">
		              <div class="relative flex items-center justify-center">
		                <div
		                  class="w-10 h-10 bg-primary rounded-full flex items-center justify-center"
		                >
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">배송중</div>
		                </div>
		              </div>
		              <div class="flex-1 h-1 bg-primary"></div>
		            </div>
		
		            <div class="w-120 flex items-center ">
		              <div class="relative flex items-center justify-center">
		                <div
		                  class="w-10 h-10 bg-primary rounded-full flex items-center justify-center"
		                >
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">배송완료</div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div> -->
		        <div class="relative flex justify-center">
  				<div class="flex items-center justify-between mb-8 w-3/4">
		            <div class="w-full flex items-center">
		              <div class="relative flex items-center justify-center">
		                <div
		                  class="w-10 h-10 bg-black rounded-full flex items-center justify-center"
		                >
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">주문완료</div>
		                </div>
		              </div>
		              <div id="statusCircle1" class="flex-1 h-1 bg-gray-300"></div>
		            </div>
		
		            <div class="w-full flex items-center">
		              <div class="relative flex items-center justify-center">
		                <div id="statusCircle2"
		                  class="w-10 h-10 rounded-full flex items-center justify-center"
		                >
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">배송준비</div>
		                </div>
		              </div>
		              <div id="statusCircle3" class="flex-1 h-1"></div>
		            </div>
		
		            <div class="w-full flex items-center">
		              <div class="relative flex items-center justify-center">
		                <div id="statusCircle4" class="w-10 h-10 rounded-full flex items-center justify-center">
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">배송중</div>
		                </div>
		              </div>
		              <div id="statusCircle5" class="flex-1 h-1"></div>
		            </div>
		
		            <div class="w-120 flex items-center ">
		              <div class="relative flex items-center justify-center">
		                <div id="statusCircle6" class="w-10 h-10 rounded-full flex items-center justify-center">
		                  <i class="ri-check-line text-white"></i>
		                </div>
		                <div class="absolute top-full mt-2 text-sm text-center w-24">
		                  <div class="font-medium text-gray-900">배송완료</div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		
		      <div class="bg-white rounded-lg shadow-sm p-6">
		        <h3 class="text-sm font-medium text-gray-900 mb-4">결제 정보</h3>
		        <div class="space-y-3">
		          <div class="flex justify-between">
		            <span class="text-sm text-gray-500">결제방법</span>
		            <span class="text-sm">신용카드</span>
		          </div>
		          <div class="flex justify-between">
		            <span class="text-sm text-gray-500">결제일시</span>
		            <span class="text-sm">2025.09.07 14:30:22</span>
		          </div>
		          <div class="flex justify-between">
		            <span class="text-sm text-gray-500">결제번호</span>
		            <span class="text-sm">PAY20250907001</span>
		          </div>
		        </div>
		      </div>
		    </div>
					
		</div>
	</div>

	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp"%>
	<!-- 푸터 끝 -->
	<script type="text/javascript">
	const dil = '배송중';

	const statusCircle1 = document.getElementById('statusCircle1');
	const statusCircle2 = document.getElementById('statusCircle2');
	const statusCircle3 = document.getElementById('statusCircle3');
	const statusCircle4 = document.getElementById('statusCircle4');
	const statusCircle5 = document.getElementById('statusCircle5');
	const statusCircle6 = document.getElementById('statusCircle6');

	if (dil === '배송완료') {
	  statusCircle1.classList.add('bg-black');
	  statusCircle2.classList.add('bg-black');
	  statusCircle3.classList.add('bg-black');
	  statusCircle4.classList.add('bg-black');
	  statusCircle5.classList.add('bg-black');
	  statusCircle6.classList.add('bg-black');
	} else if(dil === '배송중') {
		statusCircle1.classList.add('bg-black');
		statusCircle2.classList.add('bg-black');
		statusCircle3.classList.add('bg-black');
		statusCircle4.classList.add('bg-black');
		statusCircle5.classList.add('bg-gray-300');
		statusCircle6.classList.add('bg-gray-300');
	} else if(dil === '배송준비') {
		statusCircle1.classList.add('bg-black');
		statusCircle2.classList.add('bg-black');
		statusCircle3.classList.add('bg-gray-300');
		statusCircle4.classList.add('bg-gray-300');
		statusCircle5.classList.add('bg-gray-300');
		statusCircle6.classList.add('bg-gray-300');
	} else if(dil === '주문완료') {
		statusCircle1.classList.add('bg-gray-300');
		statusCircle2.classList.add('bg-gray-300');
		statusCircle3.classList.add('bg-gray-300');
		statusCircle4.classList.add('bg-gray-300');
		statusCircle5.classList.add('bg-gray-300');
		statusCircle6.classList.add('bg-gray-300');
	}
	</script>
</body>
</html>