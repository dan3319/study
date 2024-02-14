<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/manageredit.css">
<title>회원정보 수정</title>
</head>
<body>
<%@ include file="login_header.jsp" %>
    
    <div class="container">
    	<h2>회원정보</h2>
    		<br>
    	<form action="update_profile.jsp" method="post">
	    	<div class="container_in">
	    		<span class="material-symbols-outlined">person</span>
			    <label for="name" class="name"><%= session.getAttribute("name") %></label><br>
			    <label for="email" class="email"><%= session.getAttribute("email") %></label><br>
	        	<label for="id" class="id"><%= session.getAttribute("id") %></label><br>
	        		<br><br><br>
	        	<label for="phone" class="phone"><%= session.getAttribute("phone") %></label><br>
	    	</div>    
    	</form>
    </div>
</body>
</html>