<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
    // 로그인 여부 확인
    if (session.getAttribute("id") == null) {
        response.sendRedirect("index.jsp"); // 로그인 페이지로 이동
    }
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--css-->
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/header.css">
<link rel="stylesheet" href="/resources/css/menu.css">
<!--파비콘-->
<link rel="icon" href="/resources/image/favicon.ico" />
<!--폰트 설정-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<title>헤더 부분</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="main.jsp" class="logodiv">
				<img src="image/icons.png" alt="icon">
				<div class="logoname">의류 생산 관리</div>
			</a>
		</div>
		<%@ include file="menu.jsp" %>
		<ul class="menu">
			<li class="list">
			<a><%--=session.getAttribute("id")--%>님, 환영합니다.</a>
			<ul class="submenu">
				<li class="list"><a href="manageredit.jsp">회원정보</a></li>
				<li class="list"><a href="logout.jsp">로그아웃</a></li>
			</ul>
			</li>
		</ul>
	</header>