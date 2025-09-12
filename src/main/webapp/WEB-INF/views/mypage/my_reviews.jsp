<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>마이페이지 - 내가 쓴 리뷰</title>

  <!-- 컨텍스트 루트를 기준 경로로 고정 -->
  <base href="${path}/">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
<style type="text/css">

.hero-section1 {
	width: 100%;
	background: white;
	padding: .5rem 0;
	padding-top: 5rem;
}
</style>
</head>
<body class="bg-gray-100">
  <%@ include file="/WEB-INF/views/setting/header.jsp" %>

	<!-- 헤더 높이만큼 간격 (헤더 수정 못하니 여기에 스페이서) -->
 <!--  <div style="height:96px"></div> -->

	<section class="hero-section1"></section>

  <!-- 전체 컨테이너 -->
  <div class="min-h-screen flex justify-center py-8">
    <!-- 메인 래퍼 -->
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <!-- 프로필 -->
        <form id="avatarForm" action="<c:url value='/mypage_imgUpload.do'/>"
              method="post" enctype="multipart/form-data">
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

        <div class="relative inline-block">
          <img id="profileImg" src="${imgUrl}" alt="Profile"
               class="rounded-full w-28 h-28 object-cover mb-4 cursor-pointer border" />
          <label for="u_image"
                 class="absolute bottom-2 right-2 w-9 h-9 rounded-full bg-white border shadow
                        flex items-center justify-center cursor-pointer hover:shadow-md"
                 title="프로필 사진 변경">
            <i class="ri-pencil-fill text-gray-700 text-base"></i>
            <span class="sr-only">프로필 사진 변경</span>
          </label>
        </div>

        <h2 class="text-lg font-semibold">${sessionScope.sessionid}</h2>
        <h2 class="text-lg font-semibold">${sessionScope.session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${sessionScope.session_u_email}</p>
        <button class="px-4 py-2 bg-black text-white rounded-lg mb-6 hover:bg-blue-600"
                onclick="window.location='<c:url value="/mypage_pwdcheck.do"/>'">정보수정</button>

       <!-- 네비게이션 -->
		<nav class="w-full space-y-2 text-sm">
               <a href="${pageContext.request.contextPath}/mypage_editPet.do" class="block py-2 px-3 rounded hover:bg-gray-100">내 반려동물</a> 
               <a href="./orderList" class="block py-2 px-3 rounded hover:bg-gray-100">주문내역</a> 
               <a href="./wishList.do" class="block py-2 px-3 rounded hover:bg-gray-100">관심상품</a>
               <a href="./cartList" class="block py-2 px-3 rounded hover:bg-gray-100">장바구니</a> 
               <a href="./mypage_qna.do" class="block py-2 px-3 rounded hover:bg-gray-100">Q&A</a> 
               <a href="./mypage/my_reviews.do" class="block py-2 px-3 rounded hover:bg-gray-100">상품리뷰</a>
               <a href="#" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 p-8 bg-gray-50">
        <h1 class="text-3xl font-bold text-gray-900 mb-6">내가 쓴 리뷰</h1>

        <c:choose>
          <c:when test="${empty list}">
            <div class="p-6 bg-white rounded-xl shadow text-center text-gray-500">
              아직 작성한 리뷰가 없습니다.
            </div>
          </c:when>
          <c:otherwise>
            <div class="bg-white rounded-xl shadow overflow-hidden">
              <table class="min-w-full">
                <thead class="bg-gray-100">
                  <tr>
                    <th class="px-4 py-3 text-left">상품</th>
                    <th class="px-4 py-3 text-left">내용</th>
                    <th class="px-4 py-3 text-center">평점</th>
                    <th class="px-4 py-3 text-center">작성일</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="r" items="${list}">
				  <tr class="border-t hover:bg-gray-50">
				  <td class="px-4 py-3">
					  <a class="flex items-center gap-3"
					     href="<c:url value='/review_detailAction.bc'>
					             <c:param name='r_num' value='${r["R_NUM"]}'/>
					           </c:url>">
					    <%-- 썸네일 --%>
					    <c:set var="imgPath" value='${r["PD_IMAGE_URL"]}'/>
					    <c:choose>
					      <c:when test='${not empty imgPath && fn:startsWith(imgPath, "/")}'>
					        <img src="<c:url value='${imgPath}'/>" class="w-12 h-12 object-cover rounded" alt="">
					      </c:when>
					      <c:otherwise>
					        <img src="<c:url value='/${imgPath}'/>" class="w-12 h-12 object-cover rounded" alt="">
					      </c:otherwise>
					    </c:choose>
					
					    <div class="font-medium"><c:out value='${r["PD_NAME"]}'/></div>
					  </a>
					</td>

				    <td class="px-4 py-3"><c:out value="${r['R_CONTENT']}"/></td>
				    <td class="px-4 py-3 text-center"><c:out value="${r['R_SCORE']}"/></td>
				    <td class="px-4 py-3 text-center">
				      <fmt:formatDate value="${r['R_REGDATE']}" pattern="yyyy-MM-dd"/>
				    </td>
				  </tr>
				</c:forEach>


                </tbody>
              </table>
            </div>

            <!-- 페이징 -->
            <div class="mt-6 flex justify-center gap-2">
              <c:set var="totalPages" value="${(total + pageSize - 1) / pageSize}" />
              <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="<c:url value='/mypage/my_reviews.bc'><c:param name='page' value='${i}'/></c:url>"
                   class="px-3 py-1 rounded border <c:if test='${i == page}'> bg-blue-600 text-white border-blue-600</c:if>">
                  ${i}
                </a>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>
      </main>
    </div>
  </div>

  <%@ include file="/WEB-INF/views/setting/footer.jsp" %>

  <script>
    // 프로필 이미지 업로드 트리거
    document.addEventListener('DOMContentLoaded', function(){
      const img  = document.getElementById('profileImg');
      const file = document.getElementById('u_image');
      const form = document.getElementById('avatarForm');
      if (!img || !file || !form) return;
      img.addEventListener('click', () => file.click());
      file.addEventListener('change', () => {
        if(!file.files || !file.files[0]) return;
        form.submit();
      });
    });
  </script>
</body>
</html>
