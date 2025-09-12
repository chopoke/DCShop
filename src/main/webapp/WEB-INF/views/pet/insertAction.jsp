<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/setting/setting.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  html, body { height: 100%; margin: 0; }
  .wrap {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  #successImg {
    display: none;
    max-width: 60vw;
    max-height: 60vh;
    object-fit: contain;
  }
</style>
</head>
<body>
  <div class="wrap">
    <c:if test="${joinSuccess}">
      <script type="text/javascript">
        // 이미지 보여주기
        var img = document.getElementById('successImg');
        if (img) img.style.display = 'block';
        // 즉시 이동
        window.location = CTX + "/joinFin.do";
      </script>
    </c:if>

    <c:if test="${!joinSuccess}">
      <script type="text/javascript">
        alert("반려동물 등록 실패!!");
        // 즉시 이동
        window.location = CTX + "/termsAgreement.do";
      </script>
    </c:if>
  </div>
</body>
</html>
