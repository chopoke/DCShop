<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
  </style>
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>
  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
    <div class="w-full max-w-4xl bg-white shadow rounded-xl overflow-hidden">
      <!-- 헤더 -->
      <div class="p-6 border-b">
        <h1 class="text-2xl font-bold">상품수정</h1>
        <p class="text-gray-500 mt-1">상품 정보를 수정하세요.</p>

        <!-- 서버 메시지 -->
        <c:if test="${not empty error}">
          <div class="mt-3 p-3 bg-red-50 text-red-600 rounded-lg border border-red-200">${error}</div>
        </c:if>
        <c:if test="${not empty result}">
          <div class="mt-3 p-3 bg-green-50 text-green-700 rounded-lg border border-green-200">${result}</div>
        </c:if>
      </div>

      <!-- 수정 폼 -->
      <!-- 컨트롤러: GET /admin_product_update 에서 model.addAttribute("dto", ...) 세팅되어 있어야 합니다 -->
      <form action="${path}/admin_product_updateAction" method="post" class="p-6 space-y-6">
        <!-- PK 필수 -->
        <input type="hidden" name="pd_id" value="${dto.pd_id}"/>

        <!-- 상단 요약/미리보기 -->
        <div class="flex items-center gap-4">
          <div class="w-20 h-20 rounded overflow-hidden bg-gray-100 border grid place-items-center">
            <c:choose>
              <c:when test="${not empty dto.pd_image_url}">
                <img src="${dto.pd_image_url}" alt="thumb" class="w-full h-full object-cover"
                     onerror="this.src='${path}/resources/img_main/mypage_default.png'">
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
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
            <!-- DB 제약: '판매중','품절','재입고대기' -->
            <select name="pd_status" class="form-input">
              <option value="판매중"    ${dto.pd_status=='판매중'?'selected':''}>판매중</option>
              <option value="품절"      ${dto.pd_status=='품절'?'selected':''}>품절</option>
              <option value="재입고대기" ${dto.pd_status=='재입고대기'?'selected':''}>재입고대기</option>
            </select>
          </div>

          <div>
            <label class="form-label">옵션</label>
            <input name="pd_option" value="${dto.pd_option}" class="form-input" />
          </div>

          <!-- 순서: 카테고리 → 서브카테고리 -->
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

        <div>
          <label class="form-label">이미지 URL</label>
          <input id="imgUrlInput" name="pd_image_url" value="${dto.pd_image_url}" class="form-input" placeholder="https:// 또는 /resources/..."/>
          <p class="text-xs text-gray-400 mt-1">이미지 URL을 변경하면 아래 미리보기에도 반영됩니다.</p>
          <div class="mt-2 w-32 h-32 rounded overflow-hidden bg-gray-100 border grid place-items-center">
            <img id="imgPreview" src="${dto.pd_image_url}" alt="preview" class="w-full h-full object-cover"
                 onerror="this.src='${path}/resources/img_main/mypage_default.png'">
          </div>
        </div>

        <div class="flex items-center gap-2 pt-2">
          <a href="${path}/admin_product" class="px-4 py-2 border rounded-lg hover:bg-gray-50">목록</a>
          <button type="submit" class="px-4 py-2 bg-gray-900 text-white rounded-lg hover:bg-black">저장</button>
        </div>
      </form>
    </div>
  </div>

  <%@ include file="../setting/footer.jsp" %>

  <script>
    // 이미지 URL 변경 시 미리보기 갱신
    document.getElementById('imgUrlInput')?.addEventListener('input', function() {
      const v = this.value || '';
      const img = document.getElementById('imgPreview');
      if (img) img.src = v;
    });
  </script>
</body>
</html>
