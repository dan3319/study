<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.Exception "%>
<%@ page import="java.net.http.* "%>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>제품 관리</title>
  <link rel="stylesheet" href="/resources/css/product_list.css">
  <link rel="icon" href="/resources/image/favicon.ico" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,600,0,200" />
  <script src="/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@ include file="./includes/header.jsp" %>
<div class="body_header">
<!-- 검색창 -->
  <div class="search">
  	<div style="display: inline-block;">
		<input type="search" name="search_pro" id="search_pro" class="search_pro" placeholder="제품명을 입력하세요" value='<c:out value="${criteria.search}" />'autocomplete="off">
	</div>
	<div style="display: inline-block;">
		<a class="search_a" href="javascript: searchText();">
			<button class="search_button" type="button">
				<span class="material-symbols-outlined">search</span>
			</button>
		</a>	
	</div>
  </div>

	<!-- 온체인지 -->
	<div>
		 <select id="onchange" name="onchange" class="onchange" onchange="changeSelect();">
		    <option value="rownum" <c:out value="${criteria.type == 'rownum' ? 'selected' : ''}" />>---</option>
			<option value="item_num" <c:out value="${criteria.type == 'item_num' ? 'selected' : ''}" />>제품번호</option>
			<option value="gender" <c:out value="${criteria.type == 'gender' ? 'selected' : ''}" />>성별</option>
			<option value="category" <c:out value="${criteria.type == 'category' ? 'selected' : ''}" />>카테고리</option>
			<option value="item_type" <c:out value="${criteria.type == 'item_type' ? 'selected' : ''}" />>종류</option>
			<option value="item_name" <c:out value="${criteria.type == 'item_name' ? 'selected' : ''}" />>제품이름</option>
			<option value="item_size" <c:out value="${criteria.type == 'item_size' ? 'selected' : ''}" />>사이즈</option>
			<option value="color" <c:out value="${criteria.type == 'color' ? 'selected' : ''}" />>색상</option>
			<option value="price" <c:out value="${criteria.type == 'price' ? 'selected' : ''}" />>가격</option>
		</select>
	</div>

<!-- 제품 추가-->
  <div class="add_btn">
      <a href="./productInsertForm">제품 등록</a>
  </div>
</div>
</div>

<!-- 제품 목록 -->
<div class="product_header">
	<table>
		<tr>
		  <th class="rnum">목차</th>
		  <th class="num">제품번호</th>
		  <th class="gender">성별</th>
		  <th class="category">카테고리</th>
		  <th class="type">종류</th>
		  <th class="name">제품이름</th>
		  <th class="size">사이즈</th>
		  <th class="color">색상</th>
		  <th class="price">가격</th>
		  <th class="delete">삭제</th>
		</tr>
	</table>
</div>

<!-- 제품 내용 -->
<div class="product_list" >
	<table>
    <c:forEach items="${productListVOList}" var="productList">
		<tr>
			<td class="list_rnum"><c:out value="${productList.rownum}" /></td>
			<td class="list_num"><c:out value="${productList.item_num}" /></td>
			<td class="list_gender"><c:out value="${productList.gender}" /></td>
			<td class="list_category"><c:out value="${productList.category}" /></td>
			<td class="list_type"><c:out value="${productList.item_type}" /></td>
			<td class="list_name"><c:out value="${productList.item_name}" /></td>
			<td class="list_size"><c:out value="${productList.item_size}" /></td>
			<td class="list_color"><c:out value="${productList.color}" /></td>
			<td class="list_price"><c:out value="${productList.price}" /></td>
			<td class=list_delete><button style="cursor: pointer;" onClick="javascript: productDelete(<c:out value="${productList.item_num}" />);">X</button></td>
		</tr>
    </c:forEach>
	</table>
</div>

    <!-- 페이지네이션 -->
    <ul class="pagination">
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li
                class='paginate_button ${pageMaker.cri.pageNum == num ? "active":""} '>
                <a href="/productList?&type=<c:out value= "${criteria.type}" />&pageNum=<c:out value= "${num}" />"
                style="color: black;" class="pagenum">${num}</a>
            </li>
        </c:forEach>

        <!-- <li class="pagination_button next"><a href="#" style="color: black;">Next</a></li> -->
    </ul>

<script>
    <!-- 검색 -->
  	function searchText() {
  		location.href = "./productList?search=" + $('#search_pro').val();
  	}

  	<!-- 삭제 -->
	function productDelete(item_num) {
		if (confirm('정말 삭제하시겠습니까?')) {
			 // POST method
            var newForm = $('<form name="newForm" method="post" action="/productDelete"></form>');
            newForm.append($('<input/>', {type: 'hidden', name: 'num', value: item_num }));
            newForm.appendTo('body');

            // submit form
            newForm.submit();

            alert('글이 성공적으로 삭제되었습니다.');
		}
	}

	<!-- 온체인지 -->
    function changeSelect(){
        var select  = document.getElementById("onchange");
        var selectValue = select.options[select.selectedIndex].value;

        if($('#search_pro').val()== '') {
        location.href = "./productList?type=" + selectValue
        } else {location.href = "./productList?type=" + selectValue + "&search=" + $('#search_pro').val();}
    }

</script>

<%@ include file="./includes/footer.jsp" %>
</body>
</html>