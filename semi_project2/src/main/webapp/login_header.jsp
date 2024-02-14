<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 로그인 여부 확인
    if (session.getAttribute("id") == null) {
        response.sendRedirect("index.jsp"); // 로그인 페이지로 이동
    }
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/header.css">
<title>Insert title here</title>
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
			<a><%=session.getAttribute("id")%>님, 환영합니다.</a>
			<ul class="submenu">
				<li class="list"><a href="manageredit.jsp">회원정보</a></li>
				<li class="list"><a href="logout.jsp">로그아웃</a></li>
			</ul>
			</li>
		</ul>
	</header>
</body>
</html>