<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 컨텍스트 패스 즉 프로젝트명(spring_pj_ict05 -> 세번째패키지)를 path변수에 설정 -->
<c:set var="path" value="${pageContext.request.contextPath}"></c:set> <!-- value="/jsp_pj_ict05" -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- JS에서 쓸 전역 변수 -->
<script>
  window.CTX = '<c:out value="${pageContext.request.contextPath}"/>';
</script>
