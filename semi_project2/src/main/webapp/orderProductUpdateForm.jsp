<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.lang.Exception, java.sql.SQLException" %>  

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
   <title>주문 의뢰서 수정</title>
</head>

<body>
<%
	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "semi_project2";
	String PASSWORD = "123452";
  
  String ordernum = request.getParameter("ordernum");
	
  Connection conn = null; //디비 접속 성공시 접속 정보 저장
	Statement stmt = null; //쿼리를 실행하기 객체 정보
	ResultSet rs = null;
	
	Exception exception = null;
	
	String requester = ""; //의뢰자
	String brandname = ""; //브랜드
	String itemtype = "";//종류
	String orderplace = "";//의뢰처
	String itemname = "";//제품이름
	String itemsize = "";//사이즈
	
	Integer quantity = null;//수량
	Integer chest = null;
	Integer frontlength = null;
	Integer sleevelength = null;
	Integer backwidth = null;
	Integer armwidth = null;

	String requirements = "" ;
	String productdetails = "";
	
	String filename = "";
	
  try {
	  // 0.
	  Class.forName("oracle.jdbc.driver.OracleDriver");
	  
		// 1. JDBC로 Oracle연결
	  conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
	  // System.out.println("오라클 접속 성공");
	  
		// 2. BO_FREE 테이블에서 SQL로 데이터 가져오기
	 	stmt = conn.createStatement();	// 2-1. Statement 생성
	 	rs = stmt.executeQuery("SELECT REQUESTER, BRAND_NAME, ITEM_TYPE, ORDER_PLACE, ITEM_NAME, ITEM_SIZE, QUANTITY, CHEST, FRONT_LENGTH, SLEEVE_LENGTH, BACK_WIDTH, ARM_WIDTH, REQUIREMENTS, PRODUCT_DETAILS, FILE_PATH FROM ORDER_PRODUCT WHERE ORDER_NUM = " + ordernum); // 2-2. SQL 쿼리 실행
	 	
	 	if (rs.next()) {
	 		requester = rs.getString("REQUESTER");
	 		brandname = rs.getString("BRAND_NAME");
	 		itemtype = rs.getString("ITEM_TYPE");
	 		orderplace = rs.getString("ORDER_PLACE");
	 		itemname = rs.getString("ITEM_NAME");
	 		itemsize = rs.getString("ITEM_SIZE");
	 		
	 		quantity = rs.getInt("QUANTITY");
	 		chest = rs.getInt("CHEST");
	 		frontlength = rs.getInt("FRONT_LENGTH");
	 		sleevelength = rs.getInt("SLEEVE_LENGTH");
	 		backwidth = rs.getInt("BACK_WIDTH");
	 		armwidth = rs.getInt("ARM_WIDTH");
	 		
	 		requirements = rs.getString("REQUIREMENTS");
	 		productdetails = rs.getString("PRODUCT_DETAILS");
	 		
	 		filename = rs.getString("FILE_PATH");
	 		
	 	}
  } catch(Exception e) {
	  System.out.println("오라클 접속 오류: " + e);
  } finally {
	  if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
	  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  }
%>

<%@ include file="login_header.jsp" %>

    <div class="inner"> 
      <!-- 검색어 입력 -->
      <div class="top">
        <div class="serach-bar"><a href="./orderList.jsp">
         <span class="material-symbols-outlined">arrow_back</span></a>
         <h2>관리자 주문 목록</h2>
         		<span id=print class="material-symbols-outlined">print</span>
        </div>
      </div>
      <!-- 주문내용 -->
      <div class="wrapper">
        <div class="title">
        <h2>주문 의뢰서</h2>
        </div>

        <!-- 폼 구현 -->
        <form action="./orderProductUpdate.jsp" method="post" id="form1" onSubmit="return false" enctype="multipart/form-data">
        	<input type="hidden" name="ordernum" value="<%= ordernum %>">
        	<input type="hidden" name="filePrev" value="<%= filename == null ? "" : filename %>">
            <div class="wrapper-content">
            <!--이미지 업로더-->
              <div class="firstline">
                <div class="img-file">
                  <div><input type="file" class="btn file-input" name="filecontent" id="filecontent">등록된 첨부파일1 -> <a href="./fileDownload.jsp?filename=/<%= filename %>"><%= filename %></a></div>
                  <label class="img-file-label" for="img-file" style="width:30px"></label>
                </div>
                <div class="requester">
                  의뢰자: <input type="text" name="requester" id="requester" value="<%= requester %>">
                </div>
              </div>

      
              <div class="item primary-info">
                <div class="brand-name">
                브랜드: <input type="text" name="brandname" id="brandname" value="<%= brandname %>">
                </div>
                <div class="item-type">
                종류: <input type="text" name="itemtype" id="itemtype" value="<%= itemtype %>">
                </div>
                <div class="order-place">
                의뢰처: <input type="text" name="orderplace" id="orderplace" value="<%= orderplace %>">
                </div>
              </div>

              <div class="item second-info">
                <div class="itemname">
                  제품 이름: <input type="text" name="itemname" id="itemname" value="<%= itemname %>">
                </div>
                <div class="item-size">
                  사이즈: <input type="text" name="itemsize" id="itemsize" value="<%= itemsize %>">
                </div>
                <div class="quantity">
                  주문수량: <input type="text" name="quantity" id="quantity" value="<%= quantity %>">
                </div>
              </div>

              <div class="item last-info">
                <div>가슴: <input type="text" name="chest" id="chest" value="<%= chest %>"></div>
                <div>총장: <input type="text" name="frontlength" id="frontlength" value="<%= frontlength %>"></div>
                <div>소매길이: <input type="text" name="sleevelength" id="sleevelength" value="<%= sleevelength %>"></div>
                <div>어깨단면: <input type="text" name="backwidth" id="backwidth" value="<%= backwidth %>"></div>
                <div>소매단면: <input type="text" name="armwidth" id="armwidth" value="<%= armwidth %>"></div>
              </div>

              <div class="comment">
                <div class="item-request">
                  <div class="comment-text">작업시 요청사항(100자 내외): </div>
                  <textarea name="requirements" id="requirements" cols="30" rows="10"><%= requirements %></textarea>
                </div>
                <div class="product-details">
                  <div class="comment-text">옷 소재(100자 내외): </div>
                  <textarea name="productdetails" id="productdetails" cols="30" rows="10"><%= productdetails %></textarea>
                </div>
              </div>
              <div class="submit-button"> 
                <div class="btn btn-w">
                  <input type="submit" value="수정" class="btn btn-w" onClick="prevCheckTextBox()" />
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