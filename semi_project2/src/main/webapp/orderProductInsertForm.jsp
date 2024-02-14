<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/orderProduct.css">
    <link rel="icon" href="./image/favicon.ico" />
    <!-- 구글 아이콘 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
     <!-- reset.css -->
   	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css">
    <script src="./js/jquery-3.7.1.min.js"></script>
   <title>주문 의뢰서</title>
   
</head>

<body>
<%@ include file="login_header.jsp" %>

    <div class="inner"> 
      <!-- 검색어 입력 -->
      <div class="top">
        <div class="serach-bar"><a href="./orderList.jsp">
         <span class="material-symbols-outlined">
            arrow_back
            </span></a>
         <h2>주문 목록</h2>
        </div>
      </div>
      <!-- 주문내용 -->
      <div class="wrapper">
        <div class="title">
        <h2>주문 의뢰서</h2>
        </div>

        <!-- 폼 구현 -->
        <form action="./orderProductInsert.jsp" method="post" id="form1" onSubmit="return false" enctype="multipart/form-data">
            <div class="wrapper-content">
            <!--이미지 업로더-->
              <div class="firstline">
                <div class="img-file">
                  <input type="file" class="btn file-input" name="filecontent" id="filecontent">
                  <label class="img-file-label" for="img-file" style="width:30px"></label>               
                </div>
                <div class="requester">
                  의뢰자: <input type="text" name="requester" id="requester">
                </div>
              </div>

      
              <div class="item primary-info">
                <div class="brand-name">
                브랜드: <input type="text" name="brandname" id="brandname">
                </div>
                <div class="item-type">
                종류: <select name="itemtype" id="itemtype">
                  <option value="none" selected>=== 선택 ===</option>
                  <option value="셔츠">셔츠</option>
                  <option value="긴팔">긴팔</option>
                  <option value="반팔">반팔</option>
                  <option value="후디">후디</option>
                  <option value="폴로">폴로</option>
                </select>
                </div>
                <div class="order-place">
                의뢰처: <input type="text" name="orderplace" id="orderplace" placeholder="">
                </div>
              </div>

              <div class="item second-info">
                <div class="itemname">
                  제품 이름: <input type="text" name="itemname" id="itemname" placeholder="">
                </div>
                <div class="item-size">
                  사이즈: <select name="itemsize" id="itemsize">
                  <option value="none" selected>=== 선택 ===</option>
                  <option value="xs">XS</option>
                  <option value="s">S</option>
                  <option value="m">M</option>
                  <option value="l">L</option>
                  <option value="xl">XL</option>
                </select>
                </div>
                <div class="quantity">
                  주문수량: <input type="text" name="quantity" id="quantity">
                </div>
              </div>

              <div class="item last-info">
                <div>가슴: <input type="text" name="chest" id="chest" placeholder="cm"></div>
                <div>총장: <input type="text" name="frontlength" id="frontlength" placeholder="cm"></div>
                <div>소매길이: <input type="text" name="sleevelength" id="sleevelength" placeholder="cm"></div>
                <div>어깨단면: <input type="text" name="backwidth" id="backwidth" placeholder="cm"></div>
                <div>소매단면: <input type="text" name="armwidth" id="armwidth" placeholder="cm"></div>
              </div>

              <div class="comment">
                <div class="item-request">
                  <div class="comment-text">작업시 요청사항(100자 내외): </div>
                  <textarea name="requirements" id="requirements" cols="30" rows="10"></textarea>
                </div>
                <div class="product-details">
                  <div class="comment-text">옷 소재(100자 내외): </div>
                  <textarea name="productdetails" id="productdetails" cols="30" rows="10"></textarea>
                </div>
              </div>
              <div class="submit-button"> 
                <div class="btn btn-w">
                  <input type="submit" value="작성" class="btn btn-w" onClick="prevCheckTextBox()" />
                </div>
            </div>
          </div>
          </form>   
        </div>
      </div>
  
  <%@ include file="footer.jsp" %>
    
	<script>
   		function prevCheckTextBox() { //console.log('잘 나와?');  			
   			if(!$('#requester').val()) {		//이름 관련 dom
   				alert('의뢰자를 입력하세요. 모든 정보를 입력해주세요');		//이름 입력 팝업
   				$('#requester').focus();		//이름 입력칸으로 포커스 이동
   				
   				return;
   			}
   			
   			if($('#requester').val().length > 5) {		
   				alert('이름을 5자 내외로 입력해주세요. 모든 정보를 입력해주세요');		
   				$('#requester').focus();		
   				
   				return;
   			}
   			
   			if(!$('#brandname').val()) {		
   				alert('브랜드를 입력하세요. 모든 정보를 입력해주세요');		
   				$('#brandname').focus();		
   				
   				return;
   			}
   			
   			if(!$('#quantity').val()) {		//이름 관련 dom
   				alert('수량을 입력하세요. 모든 정보를 입력해주세요');		//이름 입력 팝업
   				$('#quantity').focus();		//이름 입력칸으로 포커스 이동
   				
   				return;
   			}
   			//실제 form의 action 값으로 전송
   			document.getElementById('form1').submit();
   			//빈 텍스트 박스 처리
   			return;
   		}
   	</script>
   	
</body>
</html>