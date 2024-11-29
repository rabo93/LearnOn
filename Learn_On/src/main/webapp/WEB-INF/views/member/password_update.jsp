<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>런 온 - 온라인 No.1 교육 플랫폼</title>
<link rel="SHORTCUT ICON" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
</head>
<body>

<form action="UpdatePassword" method="post">
	<input type="password" name="mem_passwd" placeholder="새로운 비밀번호를 입력해주세요">
	<input type="submit" value="비밀번호 변경하기">
</form>


<script>src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
	$.ajax({
		type:"post",
		url:"UpdatePassword",
		data: {
			mem_passwd : $("#mem_passwd").val()
		},
	}).done(function (data) {
		 alert(data.msg);
	}).fail(function (data) {
		 alert(data.msg);
	});
	


</script>
</body>
</html>