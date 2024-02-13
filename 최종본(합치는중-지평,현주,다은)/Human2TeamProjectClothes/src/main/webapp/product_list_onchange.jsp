<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.lang.Exception, java.sql.SQLException" %> 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>제품 관리</title>
  <link rel="stylesheet" href="./css/product_list.css">
  <link rel="icon" href="./image/favicon.ico" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,600,0,200" />
  <script src="./js/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<%
   //검색
   String searchText = request.getParameter("search");
   if (searchText == null) {
      searchText = "";
   }
   
   // 온체인지
   String onchange = request.getParameter("onchange");
%>
<div class="body_header">


<!-- 검색창 -->
  <div class="search">
  	<div style="display: inline-block;">
		<input type="search" name="search_pro" id="search_pro" class="search_pro" placeholder="제품명을 입력하세요" value="<%= searchText %>" />
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
		<option value="item_num" <%= onchange.equals("item_num") ? "selected" : "" %>>제품번호</option>
		<option value="gender" <%= onchange.equals("gender") ? "selected" : "" %>>성별</option>
		<option value="category" <%= onchange.equals("category") ? "selected" : "" %>>카테고리</option>
		<option value="item_type" <%= onchange.equals("item_type") ? "selected" : "" %>>종류</option>
		<option value="item_name" <%= onchange.equals("item_name") ? "selected" : "" %>>제품이름</option>
		<option value="item_size" <%= onchange.equals("item_size") ? "selected" : "" %>>사이즈</option>
		<option value="color" <%= onchange.equals("color") ? "selected" : "" %>>색상</option>
		<option value="price" <%= onchange.equals("price") ? "selected" : "" %>>가격</option>
	</select>
  </div>

<!-- 제품 추가 -->
  <div class="add_btn">
      <a href="./product_add_form.jsp">제품 등록</a>
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


<%
    String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
    String USER = "semi_project2";
  	String PASSWORD = "123452";
   
    Connection conn = null; //디비 접속 성공시 접속 정보 저장
    PreparedStatement pstmt = null; //쿼리를 실행하기 객체 정보
    Statement stmt = null;
    ResultSet rs = null;
   
    Exception exception = null;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    
    // 현재 페이지
    int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
    int startPage = 1;	// 시작 페이지
    int countList = 10;	// 한 페이지에 보여질 데이터 수
    int startCount = (currentPage-1) * countList +1;		// 현재 페이지에 따라 가져올 첫번째 게시글
    int endCount = currentPage * countList;					// 현재 페이지에 따라 가져올 마지막 게시글
    int totalCount = 0;	// 총 행 수
    int totalPage = 0;	// 총 페이지 수
    
    try {
      
      // 1. JDBC로 Oracle연결
      conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);

      // 행 수 찾기 쿼리
      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
             ResultSet.CONCUR_UPDATABLE); // 2-2. SQL 쿼리 실행);
      rs = stmt.executeQuery("SELECT * FROM PRODUCTS");
      rs.last();
      totalCount = rs.getRow();	
      rs.beforeFirst();
  	  
      // 총 페이지 수
	  totalPage = totalCount / countList;	
	  if (totalCount % countList > 0) {
	   	  totalPage++;
     }
	  
      // 데이터 가져오기
      pstmt = conn.prepareStatement("SELECT rnum, ITEM_NUM, GENDER, CATEGORY, ITEM_TYPE, ITEM_NAME, ITEM_SIZE, COLOR, PRICE FROM	(SELECT ROWNUM AS rnum, A.* FROM (SELECT * FROM PRODUCTS WHERE ITEM_NAME LIKE '%" + searchText + "%'  ORDER BY " + onchange + ") A WHERE ROWNUM <= ?) WHERE rnum >= ?"); // 2-2. SQL 쿼리 실행);
      pstmt.setInt(1, endCount);
      pstmt.setInt(2, startCount);
      rs = pstmt.executeQuery();
      
      
      // 3. rs로 데이터 가져온 걸 웹에 보여주기 -> 쿼리 실행 결과 출력
      while(rs.next()) {
%>
<!-- 제품 내용 -->
<div class="product_list" >
	<table>
		<tr>
			<td class="list_rnum"><%= rs.getInt("rnum") %></td>
			<td class="list_num"><%= rs.getInt("item_num") %></td>
			<td class="list_gender"><%= rs.getString("gender") %></td>
			<td class="list_category"><%= rs.getString("category") %></td>
			<td class="list_type"><%= rs.getString("item_type") %></td>
			<td class="list_name"><%= rs.getString("item_name") %></td>
			<td class="list_size"><%= rs.getString("item_size") %></td>
			<td class="list_color"><%= rs.getString("color") %></td>
			<td class="list_price"><%= rs.getInt("price") %></td>
			<td class=list_delete><button style="cursor: pointer;" onClick="javascript: productDelete(<%= rs.getInt("item_num") %>);">X</button></td>
		</tr>
	</table>
</div>	  
<%              
      }
  	} catch(Exception e) {
    	System.out.println("오라클 접속 오류:" + e);
  	} finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  	}
%>

<!-- 페이지네이션 -->
<div class="pagination">
   
    <!-- 처음 버튼 -->
    <a class="startPage" href="./product_list_onchange.jsp?page=1&search=<%= searchText %>&onchange=<%= onchange %>" class="startPage">
		<span class="material-symbols-outlined">keyboard_double_arrow_left</span>
    </a>
 
    <!-- 이전 버튼 -->
    <% if (currentPage > 1) { %>
    	<a href="./product_list_onchange.jsp?page=<%= currentPage - 1 %>&search=<%= searchText %>&onchange=<%= onchange %>" class="beforePage">
		    <span class="material-symbols-outlined">arrow_left</span>
    	</a>
	<% } else { %>
    	<button class="beforePage" type="button">
		    <span class="material-symbols-outlined">arrow_left</span>
		</button>
	<% } %>
	
	<!-- 버튼 목록 -->
	<% 
		for (int iCount = startPage; iCount <= totalPage; iCount++) {	// 연달아서 페이지 번호 출력 
			if (iCount == currentPage ){
	%>
				<a href="./product_list_onchange.jsp?page=<%= iCount %>&search=<%= searchText %>&onchange=<%= onchange %>" class="boldPage"><%= " " + iCount %></a>
	<%		} else {
	%>		
				<a href="./product_list_onchange.jsp?page=<%= iCount %>&search=<%= searchText %>&onchange=<%= onchange %>" class="listPage"><%= " " + iCount %></a> 
	<% 
				}
		}
  	%>	 
  	     
	<!-- 다음 버튼 -->
	<% if (currentPage < totalPage) { %>
	        <a href="./product_list_onchange.jsp?page=<%= currentPage + 1 %>&search=<%= searchText %>&onchange=<%= onchange %>" class="nextpage">
		    	<span class="material-symbols-outlined">arrow_right</span>
			</a>
	    <% } else { %>
		    <button class="nextpage" type="button">
		    	<span class="material-symbols-outlined">arrow_right</span>
			</button>
	    <% } %>
   
   <!-- 마지막 버튼 -->
   <a href="./product_list_onchange.jsp?page=<%= totalPage %>&search=<%= searchText %>&onchange=<%= onchange %>" class="lastPage">
	    <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
   </a>

</div>
</div>
<script>
  	function searchText() {
  		location.href = "./product_list_onchange.jsp?onchange=<%= onchange %>&search=" + $('#search_pro').val();
  	}
  	
	function productDelete(item_num) {
		if (confirm('정말 삭제하시겠습니까?')) {
			location.href = "./product_delete.jsp?item_num=" + item_num;
		}
	}
	
	function changeSelect(){
		var select  = document.getElementById("onchange");
	    var selectValue = select.options[select.selectedIndex].value;   // select element에서 선택된 option의 value가 저장된다.
	    location.href = "./product_list_onchange.jsp?onchange=" + selectValue;  // 페이지의 주소를 material = 선택된데이터(즉 WHERE 원재자명 = selectValue 이런느낌)
	}
</script>

<%@ include file="footer.jsp"%>
</body>
</html>