<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SHOP-main</title>
<script src="https://cdn.tailwindcss.com/3.4.16"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
<style type="text/css">
.hero-section1 {
	width: 100%;
	background: white;
	padding: .5rem 0;
	padding-top: 5rem;
}
#payment-button1 {
	background-color: black; 
}
</style>
<script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              primary: "#3b82f6",
              secondary: "#10b981",
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
<script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<link rel="stylesheet" href="${path}/resources/css/footer.css">
<link rel="stylesheet" href="${path}/resources/css/header.css">
<link rel="stylesheet" href="${path}/resources/css/main.css">
<link rel="stylesheet" href="${path}/resources/css/shop_main.css">
<body>
	<!-- 헤더 시작 -->
	<%@ include file="../setting/header.jsp" %>
	<!-- 헤더 끝 -->
	
	<section class="hero-section1">
	</section>
	<div class="max-w-6xl mx-auto px-2">
	<div>
      <input type="checkbox" id="coupon-box" /> <label for="coupon-box">
         5,000원 쿠폰 적용 </label>
   </div>
   <!-- 결제 UI -->
   <div id="payment-method"></div>
   <!-- 이용약관 UI -->
   <div id="agreement"></div>
   <!-- 결제하기 버튼 -->
   <button class="block mx-auto w-full max-w-sm text-white py-3 rounded-button hover:bg-blue-600 transition mt-8" id="payment-button1" style="margin-top: 30px">결제하기</button>
	<br>


   <script>
      main();

      async function main() {
        const button = document.getElementById("payment-button1");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "_FXmMRqIw2EnuAnChrCuk";
        const widgets = tossPayments.widgets({
          customerKey,
        });

        // ------ 주문의 결제 금액 설정 ------
        await widgets.setAmount({
          currency: "KRW",
          value: 50000,
        });

        await Promise.all([
          // ------  결제 UI 렌더링 ------
          widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
          }),
          // ------  이용약관 UI 렌더링 ------
          widgets.renderAgreement({ 
             selector: "#agreement", 
             variantKey: "AGREEMENT" 
           }),
        ]);

        // ------  주문서의 결제 금액이 변경되었을 경우 결제 금액 업데이트 ------
        coupon.addEventListener("change", async function () {
          if (coupon.checked) {
            await widgets.setAmount({
              currency: "KRW",
              value: 50000 - 5000,
            });

            return;
          }

          await widgets.setAmount({
            currency: "KRW",
            value: 50000,
          });
        });

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        button.addEventListener("click", async function () {
          await widgets.requestPayment({
            orderId: "w19rNavZysFTnUo1VttGy",
            orderName: "토스 티셔츠 외 2건",
            successUrl: window.location.origin + "/success.html",
            failUrl: window.location.origin + "/fail.html",
            customerEmail: "customer123@gmail.com",
            customerName: "김토스",
            customerMobilePhone: "01012341234",
          });
        });
      }
    </script>
	</div>
	<!-- 푸터 시작 -->
	<%@ include file="../setting/footer.jsp" %>
	<!-- 푸터 끝 -->
</body>
</html>