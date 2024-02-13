<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/header.css">
<link rel="icon" href="./image/favicon.ico" />
<title>Insert title here</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="index.jsp" class="logodiv">
				<img src="image/icons.png" alt="icon">
				<div class="logoname">의류 생산 관리</div>
			</a>	
			<div class="login">
				<button>로그인</button>
			</div>
		</div>
		<%@ include file="menu.jsp" %>
	</header>
</body>
</html>