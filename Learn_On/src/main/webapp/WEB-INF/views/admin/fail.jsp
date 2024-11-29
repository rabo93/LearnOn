<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>런 온 - 관리자 페이지</title>
	<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>
	<script type="text/javascript">
		alert("${msg}");
		
		if ("${targetURL}" == "") {
			history.back();
		} else {
			location.href = "${targetURL}";
		}
	</script>

</body>
</html>