<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>상품등록 - 독캣배송</title>
  <script src="https://cdn.tailwindcss.com/3.4.16"></script>
  <style>
    .hero-section1{width:100%;background:white;padding:.5rem 0;padding-top:5rem}
    .form-label{display:block;font-size:.875rem;color:#6b7280;margin-bottom:.25rem}
    .form-input{width:100%;border:1px solid #e5e7eb;border-radius:.5rem;padding:.5rem .75rem}
    /* 숨김 파일 입력을 버튼처럼 쓰기 위한 보조 스타일 */
    .sr-only-input{ position:absolute; width:1px; height:1px; padding:0; margin:-1px; overflow:hidden; clip:rect(0,0,0,0); border:0; }
  </style>
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>
  <section class="hero-section1"></section>

  <!-- 전체 컨테이너: 좌(사이드바) + 우(메인) -->
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

      <!-- 메인 콘텐츠 -->
      <main class="flex-1 min-w-0 p-8 bg-gray-50">
        <div class="w-full max-w-4xl bg-white shadow rounded-xl overflow-hidden">
          <!-- 헤더 -->
          <div class="p-6 border-b">
            <h1 class="text-2xl font-bold">상품등록</h1>
            <p class="text-gray-500 mt-1">상품 정보를 입력하고 저장하세요.</p>

            <!-- 서버에서 전달한 메시지 -->
            <c:if test="${not empty error}">
              <div class="mt-3 p-3 bg-red-50 text-red-600 rounded-lg border border-red-200">${error}</div>
            </c:if>
            <c:if test="${not empty result}">
              <div class="mt-3 p-3 bg-green-50 text-green-700 rounded-lg border border-green-200">${result}</div>
            </c:if>
          </div>

          <!-- 폼 (파일 업로드 위해 enctype 추가) -->
          <form action="${path}/admin_product_insertAction" method="post" enctype="multipart/form-data" class="p-6 space-y-6">
            <!-- 1단 그리드 -->
            <div class="grid md:grid-cols-2 gap-4">
              <div>
                <label class="form-label">상품명<span class="text-red-500">*</span></label>
                <input name="pd_name" required class="form-input" placeholder="예) 프리미엄 캣타워" />
              </div>

              <div>
                <label class="form-label">브랜드</label>
                <input name="pd_brand" class="form-input" placeholder="예) DCDOG&CAT" />
              </div>

              <div class="md:col-span-2">
                <label class="form-label">상세 설명</label>
                <textarea name="pd_description" rows="6" class="form-input" placeholder="상품 상세설명을 입력하세요. (CLOB)"></textarea>
              </div>

              <div>
                <label class="form-label">가격(원)<span class="text-red-500">*</span></label>
                <input type="number" name="pd_price" min="0" step="1" required class="form-input" placeholder="예) 19900" />
              </div>

              <div>
                <label class="form-label">재고 수량</label>
                <input type="number" name="pd_stock" min="0" step="1" value="" class="form-input" placeholder="예) 100" />
              </div>

              <div>
                <label class="form-label">배송비</label>
                <input type="number" name="pd_shipping_fee" min="0" step="1" value="" class="form-input" placeholder="예) 3000" />
              </div>

              <div>
                <label class="form-label">할인율(%)</label>
                <input type="number" name="pd_discount_rate" min="0" max="100" step="1" value="" class="form-input" placeholder="예) 10" />
              </div>

              <div>
                <label class="form-label">상태<span class="text-red-500">*</span></label>
                <!-- product_tbl 제약: '판매중','품절','재입고대기' -->
                <select name="pd_status" class="form-input">
                  <option value="판매중" selected>판매중</option>
                  <option value="품절">품절</option>
                  <option value="재입고대기">재입고대기</option>
                </select>
              </div>

              <div>
                <label class="form-label">옵션</label>
                <input name="pd_option" class="form-input" placeholder="예) S / M / L" />
              </div>

              <!-- 동물 타입 / 카테고리 -->
              <div>
                <label class="form-label">동물 타입<span class="text-red-500">*</span></label>
                <!-- 스키마 주석: 강아지=01 / 고양이=02 -->
                <select name="pd_pet_category" class="form-input" required>
                  <option value="1">강아지(01)</option>
                  <option value="2">고양이(02)</option>
                </select>
              </div>

              <div>
                <label class="form-label">카테고리 코드<span class="text-red-500">*</span></label>
                <select name="pd_category" class="form-input" required>
                  <optgroup label="강아지">
                    <option value="1100">의류(1100)</option>
                    <option value="1200">미용/위생(1200)</option>
                    <option value="1300">화장실(1300)</option>
                    <option value="1400">장난감(1400)</option>
                    <option value="1500">목줄/리드줄(1500)</option>
                  </optgroup>
                  <optgroup label="고양이">
                    <option value="2100">의류(2100)</option>
                    <option value="2200">미용/위생(2200)</option>
                    <option value="2300">모래(2300)</option>
                    <option value="2400">장난감(2400)</option>
                    <option value="2500">스크래쳐(2500)</option>
                  </optgroup>
                </select>
              </div>

              <div>
                <label class="form-label">서브 카테고리 코드<span class="text-red-500">*</span></label>
                <input type="number" name="pd_subcategory" min="0" step="1" class="form-input" placeholder="예) 1101" required />
              </div>
            </div>

            <!-- 이미지: 파일탐색기 버튼 + 미리보기 -->
            <div>
              <label class="form-label">상품 이미지(파일 업로드)</label>

              <!-- 진짜 파일 인풋은 숨기고 라벨을 버튼처럼 사용 -->
              <input id="pd_image" name="pd_image" type="file" accept="image/*" class="sr-only-input" />
              <div class="flex flex-col gap-3">
                <div class="flex flex-wrap items-center gap-2">
                  <label for="pd_image" class="inline-flex items-center px-4 py-2 bg-gray-900 text-white rounded-lg cursor-pointer hover:bg-black">
                    파일 선택
                  </label>
                  <button type="button" id="btnClearImage" class="px-3 py-2 border rounded-lg hover:bg-gray-50">
                    초기화
                  </button>
                  <span id="fileName" class="text-sm text-gray-600">선택된 파일 없음</span>
                </div>

                <!-- 미리보기 영역 -->
                <div id="previewWrap" class="hidden">
                  <img id="previewImg" alt="미리보기" class="mt-2 rounded-lg border max-h-56 object-contain" />
                </div>

                <p class="text-xs text-gray-400">
                </p>
              </div>
            </div>

            <!-- 버튼 -->
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

  <!-- 파일 미리보기/초기화 스크립트 -->
  <script>
    (function(){
      const fileInput = document.getElementById('pd_image');
      const fileName  = document.getElementById('fileName');
      const btnClear  = document.getElementById('btnClearImage');
      const previewWrap = document.getElementById('previewWrap');
      const previewImg  = document.getElementById('previewImg');

      function resetPreview() {
        fileInput.value = '';
        fileName.textContent = '선택된 파일 없음';
        previewWrap.classList.add('hidden');
        previewImg.removeAttribute('src');
      }

      fileInput.addEventListener('change', function(e){
        const file = e.target.files && e.target.files[0];
        if(!file){ resetPreview(); return; }

        // 파일명 표기
        fileName.textContent = file.name;

        // 용량(10MB) 체크
        const MAX = 10 * 1024 * 1024;
        if (file.size > MAX) {
          alert('파일 크기가 10MB를 초과합니다.');
          resetPreview();
          return;
        }

        // 이미지 미리보기
        const reader = new FileReader();
        reader.onload = function(evt){
          previewImg.src = evt.target.result;
          previewWrap.classList.remove('hidden');
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