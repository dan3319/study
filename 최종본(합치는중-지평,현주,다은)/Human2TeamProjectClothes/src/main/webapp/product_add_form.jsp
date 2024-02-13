<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>제품 등록</title>
  <link rel="stylesheet" href="./css/product_add.css">
  <link rel="icon" href="./image/favicon.ico" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,700,0,0" />
  <script src="./js/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
  <div class="pro_add_header">
    <h1><a href="./product_list.jsp" id="form1" class="proList" onSubmit="return false">
    		<span class="material-symbols-outlined">arrow_back</span>제품 목록
    	</a>
    </h1>
    <div class="pro_add">
      <h2>제품 등록 작성란</h2>
      <form action="./product_add.jsp" method="post">
        <div class="proInfo">
          <div class="item_num">
            <strong>제품 번호</strong><br>
              <input type="text" id="proNum" name="proNum" placeholder="제품 번호를 입력해주세요">
          </div>
          <br>
          <br>
          <div class="add_gender">
            <strong>성별</strong><br>
              <input type="radio" id="gender" name="gender" value="M">남자
              <input type="radio" id="gender" name="gender" value="W">여자
          </div>
          <br>
          <br>
          <div class="add_category">
            <strong>카테고리</strong><br>
              <select id="category" name="category">
                <option value="탑&티셔츠</">탑&티셔츠</option>
                <option value="후디&크루">후디&크루</option>
                <option value="재킷&베스트">재킷&베스트</option>
              </select>
          </div>
          <br>
          <br>
          <div class="add_type">
            <strong>종류</strong><br>
              <select id="type" name="type">
                <option value="긴팔">긴팔</option>
                <option value="반팔">반팔</option>
                <option value="후디">후디</option>
                <option value="폴로">폴로</option>
                <option value="셔츠">셔츠</option>
              </select>
          </div>
          <br>
          <br>
          <div class="add_name">
            <strong>제품 이름</strong><br>
              <input type="text" id="proName" name="proName" placeholder="제품 이름을 입력해주세요">
          </div>
          <br>
          <br>
          <div class="add_size">
            <strong>사이즈</strong><br>
              <select id="size" name="size">
                <option value="XS">XS</option>
                <option value="X">X</option>
                <option value="M">M</option>
                <option value="L">L</option>
                <option value="XL">XL</option>
              </select>
          </div>
          <br>
          <br>
          <div class="add_color">
            <strong>색상</strong><br>
              <input type="text" id="color" name="color" placeholder="색상을 입력해주세요">
          </div>
          <br>
          <br>
          <div class="add_price">
            <strong>가격</strong><br>
              <input type="text" id="proPrice" name="proPrice" placeholder="제품의 가격을 입력해주세요">
          </div>
        </div>
        <br>
        <br>
        <div class="btn-w">
          <input type="submit" value="작성" class="input-btn-w" onClick="javascript: prevCheckTextBox();" />
        </div>
      </form>
    </div>
  </div>
  <script>
  	function prevCheckTextBox() {
  		if (!$('#proNum').val()) {	
  			alert('제품 번호를 입력해주세요.');
  			$('#proNum').focus();	
  			
  			return;
  		}
  		if (!$('#proNum').val()) {	
  			alert('제품 번호를 입력해주세요.');
  			$('#proNum').focus();		
  			
  			return;
  		}
  		if (!$('#gender').val()) {	
  			alert('성별을 클릭해주세요.');
  			$('#gender').focus();	
  			
  			return;
  		}
  		if ($('#category').val()) { 	
  			alert('카테고리를 선택해주세요.');
  			$('#category').focus();		
  			
  			return;
  		}
  		if (!$('#type').val()) {	
  			alert('유형을 선택해주세요.');
  			$('#type').focus();	
  			
  			return;
  		}
  		if (!$('#proName').val()) {
  			alert('제품 이름을 입력해주세요.');
  			$('#proName').focus();		
  			
  			return;
  		}
  		if (!$('#size').val()) {	
  			alert('사이즈를 선택해주세요.');
  			$('#size').focus();		
  			
  			return;
  		}
  		if (!$('#color').val()) {	
  			alert('색상을 입력해주세요.');
  			$('#color').focus();	
  			
  			return;
  		}
  		if (!$('#proPrice').val()) {	
  			alert('제품의 가격을 입력해주세요.');
  			$('#proPrice').focus();		
  			
  			return;
  		}
  			
  		// 실제 form의 action의 값으로 전송
 		document.getElementById('form1').submit();
  	}
  </script>
<%@ include file="footer.jsp"%>
</body>
</html>