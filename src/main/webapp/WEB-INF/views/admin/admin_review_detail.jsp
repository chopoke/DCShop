<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - 리뷰관리 | 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  
  <style>
  .hero-section1{width:100%;background:#fff;padding:.5rem 0;padding-top:5rem;}
  .tbl-fixed{table-layout:fixed;}
  .ellipsis{overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
  .row-nowrap td{white-space:nowrap;vertical-align:middle;height:52px;}

  /* === 폼 공통 === */
  .label      { font-size:16px; color:#374151; margin-bottom:6px; display:block; }
  .form-ctl   {
    width:100%; height:46px;      
    font-size:16px; border-radius:10px;
    padding:0 .75rem; border:1px solid #d1d5db; background:#fff;
  }
  .btn-primary{
    width:100%; height:44px;           
    font-size:16px; border-radius:10px;
    padding:0 1rem; color:#fff; background:#2563eb;
  }
  .btn-primary:hover{ background:#1e4fd7; }
 </style>
  
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>
  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 -->
      <aside class="w-72 shrink-0 bg-white border-r p-6 flex flex-col items-center">
        <img src="resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>
        
        <!-- 네비게이션(수정금지) -->
        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded hover:bg-gray-100">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded bg-gray-900 text-white">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 -->
      <main class="flex-1 p-8 bg-gray-50 text-[16px] leading-6">
        <h1 class="text-2xl font-bold mb-6">리뷰관리</h1>

		<!--  -->
        <div class="max-w-5xl mx-auto p-6">
		  <div class="bg-white rounded-xl shadow border p-6">
		    <div class="flex items-center justify-between mb-4">
		      <h1 class="text-3xl font-bold">리뷰 상세</h1>
		      <a href="${path}/admin_review" class="px-3 py-2 border rounded-lg hover:bg-gray-50">목록으로</a>
		    </div>
		
		    <div class="grid grid-cols-2 gap-4 text-base">
		      <div class="p-3 bg-gray-50 rounded">
		        <div class="mb-1 text-gray-500">리뷰번호</div>
		        <div class="font-semibold"><c:out value="${detail.r_num}"/></div>
		      </div>
		      <div class="p-3 bg-gray-50 rounded">
		        <div class="mb-1 text-gray-500">상품번호</div>
		        <div class="font-semibold"><c:out value="${detail.pd_id}"/></div>
		      </div>
		      <div class="p-3 bg-gray-50 rounded">
		        <div class="mb-1 text-gray-500">상품명</div>
		        <div class="font-semibold"><c:out value="${detail.pd_name}"/></div>
		      </div>
		      <div class="p-3 bg-gray-50 rounded">
		        <div class="mb-1 text-gray-500">작성자(ID)</div>
		        <div class="font-semibold">
		          <c:out value="${detail.u_id}"/> (<c:out value="${detail.u_nickname}"/>)
		        </div>
		      </div>
		      <div class="p-3 bg-gray-50 rounded">
		        <div class="mb-1 text-gray-500">평점</div>
		        <div class="font-semibold"><c:out value="${detail.r_rate}"/> 점</div>
		      </div>
		      <div class="p-3 bg-gray-50 rounded">
		        <div class="mb-1 text-gray-500">작성일</div>
		        <div class="font-semibold">
		          <fmt:formatDate value="${detail.r_regdate}" pattern="yyyy-MM-dd"/>
		        </div>
		      </div>
		    </div>
		
		    <div class="mt-6">
		      <div class="mb-2 font-semibold">내용</div>
		      <div class="p-4 border rounded bg-white whitespace-pre-wrap">
		        <c:out value="${detail.r_content}"/>
		      </div>
		    </div>
		
		    <c:if test="${not empty detail.r_img}">
		      <div class="mt-6">
		        <div class="mb-2 font-semibold">이미지</div>
		        <img src="${pageContext.request.contextPath}${detail.r_img}" alt="리뷰 이미지" class="mx-auto max-w-full h-auto rounded-lg shadow">
		      </div>
		    </c:if>
		  </div>
		</div>

        
      </main>
    </div>
  </div>

  <%@ include file="../setting/footer.jsp" %>

</body>
</html>
