<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/manageredit.css">
    
    <div class="container">
    	<h2>회원정보</h2>
    		<br>
    	<form action="update_profile" method="post">
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