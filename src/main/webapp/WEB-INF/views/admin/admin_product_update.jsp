<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>상품수정 - 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style>
    .hero-section1{width:100%;background:white;padding:.5rem 0;padding-top:5rem}
    .form-label{display:block;font-size:.875rem;color:#6b7280;margin-bottom:.25rem}
    .form-input{width:100%;border:1px solid #e5e7eb;border-radius:.5rem;padding:.5rem .75rem}
    .sr-only-input{position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);border:0}
  </style>
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>
  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
    <div class="w-full max-w-6xl bg-white shadow rounded-xl overflow-hidden flex">

      <!-- 사이드바 -->
      <aside class="w-72 bg-white border-r p-6 flex flex-col items-center">
        <img src="${path}/resources/img_main/mypage_default.png" alt="Profile" class="rounded-full w-28 h-28 object-cover mb-4">
        <h2 class="text-lg font-semibold">${session_u_nickname}</h2>
        <p class="text-gray-500 text-sm mb-4">${session_u_email}</p>
        <button class="px-4 py-2 bg-blue-500 text-white rounded-lg mb-6 hover:bg-blue-600">정보수정</button>

        <nav class="w-full space-y-2 text-sm">
          <a href="${path}/admin_board"   class="block py-2 px-3 rounded hover:bg-gray-100">게시판관리</a>
          <a href="${path}/admin_order"   class="block py-2 px-3 rounded hover:bg-gray-100">주문관리</a>
          <a href="${path}/admin_product" class="block py-2 px-3 rounded bg-gray-900 text-white">상품관리</a>
          <a href="${path}/admin_qna"     class="block py-2 px-3 rounded hover:bg-gray-100">문의관리</a>
          <a href="${path}/admin_review"  class="block py-2 px-3 rounded hover:bg-gray-100">리뷰관리</a>
          <a href="${path}/admin_user"    class="block py-2 px-3 rounded hover:bg-gray-100">회원관리</a>
          <a href="${path}/logout.do" class="block py-2 px-3 rounded hover:bg-gray-100 text-red-500">로그아웃</a>
        </nav>
      </aside>

      <!-- 메인 -->
      <main class="flex-1 min-w-0 p-8 bg-gray-50">
        <div class="w-full max-w-4xl bg-white shadow rounded-xl overflow-hidden">

          <!-- 헤더 -->
          <div class="p-6 border-b">
            <h1 class="text-2xl font-bold">상품수정</h1>
            <p class="text-gray-500 mt-1">상품 정보를 수정하세요.</p>

            <c:if test="${not empty error}">
              <div class="mt-3 p-3 bg-red-50 text-red-600 rounded-lg border border-red-200">${error}</div>
            </c:if>
            <c:if test="${not empty result}">
              <div class="mt-3 p-3 bg-green-50 text-green-700 rounded-lg border border-green-200">${result}</div>
            </c:if>
          </div>

          <!-- 기존 이미지 URL을 미리보기용으로 정규화 -->
          <c:choose>
            <c:when test="${not empty dto.pd_image_url}">
              <c:choose>
                <c:when test="${fn:startsWith(dto.pd_image_url,'http://') or fn:startsWith(dto.pd_image_url,'https://') or fn:startsWith(dto.pd_image_url,'//')}">
                  <c:set var="__preview" value="${dto.pd_image_url}" />
                </c:when>
                <c:otherwise>
                  <c:set var="__val" value="${dto.pd_image_url}" />
                  <c:if test="${not fn:startsWith(__val,'/')}">
                    <c:set var="__val" value='/${__val}' />
                  </c:if>
                  <c:url var="__preview" value="${__val}" />
                </c:otherwise>
              </c:choose>
            </c:when>
            <c:otherwise>
              <c:set var="__preview" value="${path}/resources/img_main/mypage_default.png" />
            </c:otherwise>
          </c:choose>

          <!-- 폼: insert와 동일하게 multipart 사용 -->
          <form action="${path}/admin_product_updateAction" method="post" enctype="multipart/form-data" class="p-6 space-y-6">
            <input type="hidden" name="pd_id" value="${dto.pd_id}"/>
            <!-- 새 파일을 선택하지 않는 경우를 대비해, 기존 URL을 서버에 전달 -->
            <input type="hidden" name="pd_image_url_old" value="${dto.pd_image_url}"/>

            <!-- 상단 요약/미리보기 -->
            <div class="flex items-center gap-4">
              <div class="w-20 h-20 rounded overflow-hidden bg-gray-100 border grid place-items-center">
                <img id="previewImg" src="${__preview}" alt="thumb" class="w-full h-full object-cover"
                     onerror="this.src='${path}/resources/img_main/mypage_default.png'">
              </div>
              <div class="text-sm text-gray-500">
                <div>상품번호: <span class="font-medium text-gray-700">${dto.pd_id}</span></div>
                <div>브랜드: <span class="font-medium text-gray-700">${dto.pd_brand}</span></div>
              </div>
            </div>

            <div class="grid md:grid-cols-2 gap-4">
              <div>
                <label class="form-label">상품명<span class="text-red-500">*</span></label>
                <input name="pd_name" value="${dto.pd_name}" required class="form-input" />
              </div>

              <div>
                <label class="form-label">브랜드</label>
                <input name="pd_brand" value="${dto.pd_brand}" class="form-input" />
              </div>

              <div class="md:col-span-2">
                <label class="form-label">상세 설명</label>
                <textarea name="pd_description" rows="6" class="form-input">${dto.pd_description}</textarea>
              </div>

              <div>
                <label class="form-label">가격(원)<span class="text-red-500">*</span></label>
                <input type="number" name="pd_price" min="0" step="1" value="${dto.pd_price}" required class="form-input" />
              </div>

              <div>
                <label class="form-label">재고 수량</label>
                <input type="number" name="pd_stock" min="0" step="1" value="${dto.pd_stock}" class="form-input" />
              </div>

              <div>
                <label class="form-label">배송비</label>
                <input type="number" name="pd_shipping_fee" min="0" step="1" value="${dto.pd_shipping_fee}" class="form-input" />
              </div>

              <div>
                <label class="form-label">할인율(%)</label>
                <input type="number" name="pd_discount_rate" min="0" max="100" step="1" value="${dto.pd_discount_rate}" class="form-input" />
              </div>

              <div>
                <label class="form-label">상태<span class="text-red-500">*</span></label>
                <select name="pd_status" class="form-input">
                  <option value="판매중"     ${dto.pd_status=='판매중'?'selected':''}>판매중</option>
                  <option value="품절"       ${dto.pd_status=='품절'?'selected':''}>품절</option>
                  <option value="재입고대기"  ${dto.pd_status=='재입고대기'?'selected':''}>재입고대기</option>
                </select>
              </div>

              <div>
                <label class="form-label">옵션</label>
                <input name="pd_option" value="${dto.pd_option}" class="form-input" />
              </div>

              <div>
                <label class="form-label">카테고리 코드<span class="text-red-500">*</span></label>
                <select name="pd_category" class="form-input" required>
                  <optgroup label="강아지">
                    <option value="1100" ${dto.pd_category==1100?'selected':''}>의류(1100)</option>
                    <option value="1200" ${dto.pd_category==1200?'selected':''}>미용/위생(1200)</option>
                    <option value="1300" ${dto.pd_category==1300?'selected':''}>화장실(1300)</option>
                    <option value="1400" ${dto.pd_category==1400?'selected':''}>장난감(1400)</option>
                    <option value="1500" ${dto.pd_category==1500?'selected':''}>목줄/리드줄(1500)</option>
                  </optgroup>
                  <optgroup label="고양이">
                    <option value="2100" ${dto.pd_category==2100?'selected':''}>의류(2100)</option>
                    <option value="2200" ${dto.pd_category==2200?'selected':''}>미용/위생(2200)</option>
                    <option value="2300" ${dto.pd_category==2300?'selected':''}>모래(2300)</option>
                    <option value="2400" ${dto.pd_category==2400?'selected':''}>장난감(2400)</option>
                    <option value="2500" ${dto.pd_category==2500?'selected':''}>스크래쳐(2500)</option>
                  </optgroup>
                </select>
              </div>

              <div>
                <label class="form-label">서브 카테고리 코드<span class="text-red-500">*</span></label>
                <input type="number" name="pd_subcategory" min="0" step="1" value="${dto.pd_subcategory}" class="form-input" required />
              </div>

              <div>
                <label class="form-label">동물 타입<span class="text-red-500">*</span></label>
                <select name="pd_pet_category" class="form-input" required>
                  <option value="1" ${dto.pd_pet_category==1?'selected':''}>강아지(01)</option>
                  <option value="2" ${dto.pd_pet_category==2?'selected':''}>고양이(02)</option>
                </select>
              </div>
            </div>

            <!-- 이미지: insert와 동일한 파일 업로드 UI -->
            <div>
              <label class="form-label">상품 이미지(파일 업로드)</label>

              <input id="pd_image" name="pd_image" type="file" accept="image/*" class="sr-only-input" />
              <div class="flex flex-col gap-3">
                <div class="flex flex-wrap items-center gap-2">
                  <label for="pd_image" class="inline-flex items-center px-4 py-2 bg-gray-900 text-white rounded-lg cursor-pointer hover:bg-black">파일 선택</label>
                  <button type="button" id="btnClearImage" class="px-3 py-2 border rounded-lg hover:bg-gray-50">초기화</button>
                  <span id="fileName" class="text-sm text-gray-600">선택된 파일 없음</span>
                </div>

                <div id="previewWrap">
                  <img id="previewImg2" alt="미리보기" class="mt-2 rounded-lg border max-h-56 object-contain" src="${__preview}"
                       onerror="this.src='${path}/resources/img_main/mypage_default.png'" />
                </div>

                <p class="text-xs text-gray-400">
                  새 파일을 선택하지 않으면 기존 이미지를 그대로 사용합니다. (최대 10MB)
                </p>
              </div>
            </div>

            <div class="flex items-center gap-2 pt-2">
              <a href="${path}/admin_product" class="px-4 py-2 border rounded-lg hover:bg-gray-50">목록</a>
              <button type="submit" class="px-4 py-2 bg-gray-900 text-white rounded-lg hover:bg-black">저장</button>
            </div>
          </form>
        </div>
      </main>
    </div>
  </div>

  <%@ include file="../setting/footer.jsp" %>

  <script>
    (function(){
      const fileInput  = document.getElementById('pd_image');
      const fileNameEl = document.getElementById('fileName');
      const btnClear   = document.getElementById('btnClearImage');
      const preview1   = document.getElementById('previewImg');   // 상단 작은 썸네일
      const preview2   = document.getElementById('previewImg2');  // 아래 큰 미리보기

      function resetPreview() {
        fileInput.value = '';
        fileNameEl.textContent = '선택된 파일 없음';
        // 초기 이미지는 서버에서 내려준 __preview 유지하므로 src를 건드리지 않음
      }

      fileInput.addEventListener('change', function(e){
        const file = e.target.files && e.target.files[0];
        if(!file){ resetPreview(); return; }

        fileNameEl.textContent = file.name;

        const MAX = 10 * 1024 * 1024;
        if (file.size > MAX) {
          alert('파일 크기가 10MB를 초과합니다.');
          resetPreview();
          return;
        }

        const reader = new FileReader();
        reader.onload = function(evt){
          if(preview1) preview1.src = evt.target.result;
          if(preview2) preview2.src = evt.target.result;
        };
        reader.readAsDataURL(file);
      });

      btnClear.addEventListener('click', function(){
        resetPreview();
      });
    })();
  </script>
</body>
</html>