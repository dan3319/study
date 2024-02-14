<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS -->
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/menu.css">
<link rel="icon" href="./image/favicon.ico" />
<!-- 메뉴 아이콘 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<title>의류 생산 관리 시스템</title>
</head>
<body>
	<div id="round">
		<div id="menu">
        <input type="checkbox" id="menubtn">
        <label for="menubtn" id="menubtnlabel"><span class="material-symbols-outlined">menu</span></label>
        <ul id="menuUl">
            <li><a href="orderList.jsp" class="dir"><span class="material-symbols-outlined dir2">menu_book</span> 주문 의뢰서</a></li>
            <li><a href="store.jsp" class="dir"><span class="material-symbols-outlined dir2">inventory_2</span> 입고 등록</a></li>
            <li><a href="inventory.jsp" class="dir"><span class="material-symbols-outlined dir2">inventory_2</span> 재고 관리</a></li>
            <li><a href="product_list.jsp" class="dir"><span class="material-symbols-outlined dir2">inventory_2</span> 제품 관리</a></li>
            <li><a href="nike/button.html" class="dir"><span class="material-symbols-outlined dir2">inventory_2</span> 월별 매출 관리</a></li>
        </ul>
    </div>
	</div>
</body>
</html>