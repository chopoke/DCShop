<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/setting/setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index 페이지</title>
</head>
<body>

<script type="text/javascript">
	setTimeout(function() {
		window.location="${path}/main.do";
	}, 1000);
</script>

</body>

</html>