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
  </style>
</head>
<body class="bg-gray-100">

  <%@ include file="../setting/header.jsp" %>
  <section class="hero-section1"></section>

  <div class="min-h-screen flex justify-center py-8">
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

      <!-- 폼 -->
      <form action="${path}/admin_product_insertAction" method="post" class="p-6 space-y-6">
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
            <input type="number" name="pd_stock" min="0" step="1" value="0" class="form-input" placeholder="예) 100" />
          </div>

          <div>
            <label class="form-label">배송비</label>
            <input type="number" name="pd_shipping_fee" min="0" step="1" value="0" class="form-input" placeholder="예) 3000" />
          </div>

          <div>
            <label class="form-label">할인율(%)</label>
            <input type="number" name="pd_discount_rate" min="0" max="100" step="1" value="0" class="form-input" placeholder="예) 10" />
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

          <!-- 복구: 동물 타입 / 서브 카테고리 -->
          <div>
            <label class="form-label">동물 타입<span class="text-red-500">*</span></label>
            <!-- 스키마 주석: 강아지=01 / 고양이=02 (NUMBER 컬럼이므로 값은 1/2로 저장해도 OK) -->
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

        <!-- 이미지 -->
        <div>
          <label class="form-label">이미지 URL</label>
          <input name="pd_image_url" class="form-input" placeholder="https:// 또는 /resources/..."/>
          <p class="text-xs text-gray-400 mt-1">
            외부 URL 또는 내부 경로(/로 시작) 모두 가능. (파일 업로드로 바꾸려면 알려주세요)
          </p>
        </div>

        <!-- 버튼 -->
        <div class="flex items-center gap-2 pt-2">
          <a href="${path}/admin_product" class="px-4 py-2 border rounded-lg hover:bg-gray-50">목록</a>
          <button type="submit" class="px-4 py-2 bg-gray-900 text-white rounded-lg hover:bg-black">저장</button>
        </div>
      </form>
    </div>
  </div>

  <%@ include file="../setting/footer.jsp" %>
</body>
</html>
