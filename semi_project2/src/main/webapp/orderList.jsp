<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.lang.Exception, java.sql.SQLException" %>    
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 목록</title>
    <link rel="icon" href="./img/favicon.ico" />
    <!-- 구글 아이콘 -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
     <!-- reset.css -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" />
   <link rel="stylesheet" href="./css/orderList.css" />
   <script src="./js/jquery-3.7.1.min.js"></script>
   <script defer src="./js/order.js"></script>
   <link rel="icon" href="./image/favicon.ico" />
</head>

<body>
<%@ include file="login_header.jsp" %>

<%
	String searchText = request.getParameter("search");
	if (searchText == null) {
		searchText = "";
	}
	
	String searchDate = request.getParameter("search-date");
	if (searchDate == null) {
		searchDate = "";
	}
%>

    <div class="inner"> 
      <!-- 검색어 입력 -->
      <div class="top">
       	<!-- 제품 이름 검색 -->
        <div class="serach-product">
          <input type="search" name="search-text" id="search-text" placeholder="제품이름을 검색하세요." value="<%= searchText %>"><a class="search" href="javascript: searchText();">
          <span class="material-symbols-outlined" id="search">search</span>
          </a>
        </div>
        <!-- 날짜 검색 -->
		    <div class="search-date">
		    주문일자: <input type="date" name="search-date" id="search-date">
        <a class="search" href="javascript: searchDate();">
            <span class="material-symbols-outlined" id="searchDate">search</span>
        </a>
		    </div>
        <span class="material-symbols-outlined" id="help">help</span>
        <div class="tip">
        	<div>tip</div>
        	<div>- 제품이름으로 검색할 수 있어요!</div>
        	<div>- 주문번호,일자, 제품이름으로 의뢰서를 확인 및 수정 할 수 있어요.</div>
        	<div>- 각 주문된 상태를 더블클릭해보세요!</div>
      	</div>
       </div>
      
 			<div class="wrapper">
        <div class="header">관리자 주문 목록</div>
        
        
        <div class="content-name">
            <div class="content_no">주문번호</div>
            <div>상태</div>
            <div>주문일자</div>
            <div>제품 이름</div>
            <div>주문수량</div>        
            <div class="delete">삭제</div>
        </div>
<%
 
	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "semi_project2";
 	String PASSWORD = "123452";
	
 	PreparedStatement pstmt = null; // pstmt 변수 선언 및 초기화 추가
  Connection conn = null; //디비 접속 성공시 접속 정보 저장
	Statement stmt = null; //쿼리를 실행하기 객체 정보
	ResultSet rs = null;
	
	Exception exception = null;

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	
	int countList = 5; // 한 페이지에 출력될 게시물 수
	int currPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1; // 현재 페이지 번호
	int totalCount = 21; // 전체 행의 개수
	
	// 총 페이지 수 계산
	int totalPage = totalCount / countList;
	if (totalCount % countList > 0) {
	    totalPage++;
	}
	
	// 현재 페이지가 총 페이지보다 크면 현재 페이지를 총 페이지로 설정
	if (currPage > totalPage) {
	    currPage = totalPage;
	}
	
	int countPage = 5; // 한 번에 표시될 페이지 수
	int startPage = ((currPage - 1) / countPage) * countPage + 1; // 시작 페이지 번호
	int endPage = startPage + countPage - 1; // 끝 페이지 번호
	
	// 끝 페이지 번호가 총 페이지 수보다 크면 끝 페이지 번호를 총 페이지 수로 설정
	if (endPage > totalPage) {
	    endPage = totalPage;
	}
	
	// 시작 행 번호와 끝 행 번호 계산
	int startRow = (currPage - 1) * countList + 1; // 시작 행 번호
	int endRow = currPage * countList; // 끝 행 번호
	
	// 끝 행 번호가 총 행 수보다 클 경우 총 행 수로 설정
	if (endRow > totalCount) {
	    endRow = totalCount;
	}
	
  try {
	  
		// 1. JDBC로 Oracle연결
	  conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
	  // System.out.println("오라클 접속 성공");
	  
	 	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE); 
	 	 rs = stmt.executeQuery("SELECT * FROM ORDER_PRODUCT");
	      rs.last();
	      totalCount = rs.getRow();   
	      rs.beforeFirst();

	      String secondQuery;
	      if (searchDate != null && !searchDate.isEmpty()) {
	          secondQuery = "SELECT * FROM (SELECT ROWNUM AS rnum, ORDER_NUM, STATUS, ORDER_DATE, ITEM_NAME, QUANTITY, REQUESTER " +
	                        "FROM (SELECT * FROM ORDER_PRODUCT WHERE ITEM_NAME LIKE '%" + searchText + "%' AND TRUNC(ORDER_DATE) = '" + searchDate + "' ORDER BY ORDER_DATE DESC) A " +
	                        "WHERE ROWNUM <= " + endRow + ") " +
	                        "WHERE rnum >= " + startRow;
	      } else {
	          secondQuery = "SELECT * FROM (SELECT ROWNUM AS rnum, ORDER_NUM, STATUS, ORDER_DATE, ITEM_NAME, QUANTITY, REQUESTER " +
	                        "FROM (SELECT * FROM ORDER_PRODUCT WHERE ITEM_NAME LIKE '%" + searchText + "%' OR TRUNC(ORDER_DATE) = '" + searchDate + "' ORDER BY ORDER_DATE DESC) A " +
	                        "WHERE ROWNUM <= " + endRow + ") " +
	                        "WHERE rnum >= " + startRow;
	      }
          
	  rs = stmt.executeQuery(secondQuery);

	  /*
			searchText = rs.getString(1); // 검색어 바인딩
			searchDate = rs.getString(2);
			endRow = rs.getInt(3);  // 끝 행 번호 바인딩
			startRow = rs.getInt(4);// 시작 행 번호 바인딩
		  */ 
		   //rs = pstmt.executeQuery();
		
	 	int i = 0;
	 	// 3. rs로 데이터 가져온 걸 웹에 보여주기 -> 쿼리 실행 결과 출력
	 	while(rs.next()) {
	 		i++;
%>     
       
        <div class="content-box">
        	<div>
            <div class="content_no"><a href="./orderProductUpdateForm.jsp?ordernum=<%= rs.getInt("ORDER_NUM") %>" style="color: black;"><%= rs.getInt("ORDER_NUM") %></a></div>
            <div class="status"><%= rs.getString("STATUS") %></div>
            <div class="content_date"><a href="./orderProductUpdateForm.jsp?ordernum=<%= rs.getInt("ORDER_NUM") %>" style="color: black;"><%= rs.getDate("ORDER_DATE") %></a></div>
            <div class="content_name"><a href="./orderProductUpdateForm.jsp?ordernum=<%= rs.getInt("ORDER_NUM") %>" style="color: black;"><%= rs.getString("ITEM_NAME") %></a></div>
            <div class="quantity"><%= rs.getInt("QUANTITY") %></div>                 
            <div class="delete"><button style="cursor: pointer; font-size: 10px;" onClick="javascript: noticeDelete(<%= rs.getInt("ORDER_NUM") %>);">X</button></div>
        		
        		<div class="requester" style="display:none"><%= rs.getString("REQUESTER") %></div>
	         	<div class="ordernum" style="display:none"><%= rs.getInt("ORDER_NUM") %></div>
        	</div>
       </div>
<% 		 		
	 	}
  } catch(Exception e) {
	  System.out.println("오라클 접속 오류: " + e);
  } finally {
	  if (rs != null) try { rs.close(); } catch (SQLException ex) {}
	  
	  if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
	  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  }
%>
     <!-- 1-3. 글쓰기 버튼은 class="btn"로 <div>로 구역 설정 -->
        <div class="btn">
            <a href="./orderProductInsertForm.jsp">주문하기</a>
        </div>

			<!-- 페이지네이션 -->
		<div class="pagination">
	    <!-- 처음 버튼 -->
	    <a href="./orderList.jsp?page=1" class="startPage">
	        <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
	    </a>
	            
	    <!-- 페이지 버튼 목록 -->
	  
	    <% for (int i = startPage; i <= endPage; i++) { %>
	        <a href="./orderList.jsp?page=<%= i %>" id="pageNum" class="<%= (i == currPage) ? "boldPage" : "listPage" %>"><%= i %></a>
	    <% } %>
    
    
	    <!-- 마지막 버튼 -->
	    <a href="./orderList.jsp?page=<%= totalPage %>&search=<%= searchText %>" class="lastPage">
	        <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
	    </a>
		</div>
				
				
      </div>
    </div>
 	
 <!-- comments -->
 
	<nav id="nav">
		<div class="wrap">
			<div class="orderInfo">
				<div class="status-info">
				 <form action="./update_status.jsp" method="post" id="form1">
						<div>진행상태: <select name="status" id="status">
	                  <option value="진행중">진행중</option>
	                  <option value="완료">완료</option>
	                  <option value="중지">중지</option>
	                </select>
	             <div class="tip">tip 진행상태를 클릭해 변경할 수 있어요!</div>   
	          </div>
	       
	          <input type="text" name="ordernum" id="ordernum" value="" style="display:none;" />
	        	<button type="submit" value="update"><span class="material-symbols-outlined">done
						</span></button>	        
          </form>
        	<div class="requester">
        	의뢰자 <input type="text" name="requester" id="requester" value="" />
        	</div>
				</div>
			</div>
			
			
				<div class="content-info">
					<div class="content">내용 follow-up</div>
					<div class="commenter">작성자</div>
					<div class="comment_date">시간</div>
					<div class="ftip">tip 주문처리 현황을 볼 수 있어요!</div>
				</div>
			
<%
 try {
	  
		// 1. JDBC로 Oracle연결
	  conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
	  // System.out.println("오라클 접속 성공");
	  
		// 2. BO_FREE 테이블에서 SQL로 데이터 가져오기
	 	stmt = conn.createStatement();	// 2-1. Statement 생성
	 	rs = stmt.executeQuery("SELECT a.ORDER_NUM, b.COMMENTER, b.CONTENT, b.COMMENT_DATE FROM ORDER_PRODUCT a, ORDER_COMMENT b WHERE a.ORDER_NUM = b.ORDER_NUM ORDER BY COMMENT_DATE "); // 2-2. SQL 쿼리 실행
	 	
	 	// 3. rs로 데이터 가져온 걸 웹에 보여주기 -> 쿼리 실행 결과 출력
	 	while(rs.next()) {
%>    		
				<div class="content-info-box">
        	<div>
        	  <div class="ordernum" style="display: none;"><%= rs.getInt("ORDER_NUM") %></div>
            <div class="content"><%= rs.getString("CONTENT") %></div>
            <div class="commenter"><%= rs.getString("COMMENTER") %></div>
            <div class="comment_date"><%= rs.getDate("COMMENT_DATE") %></div>                 
        	</div>
       </div>
<% 		 		
	 	}
  } catch(Exception e) {
	  System.out.println("오라클 접속 오류: " + e);
  } finally {
	  if (rs != null) try { rs.close(); } catch (SQLException ex) {}
	  if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
	  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  }
%>

				<div class="follow-wrap">
					<form action="./commentInsert.jsp" method="post" id="form2" onSubmit="return false">
						<div class="followup">
							<div class="followup-right">
								<div class="ordernum">
					        	주문번호 <input type="text" name="fordernum" id="fordernum" style="width: 80px; height:25px;">
								</div>
								<div class="commenter">
					        	작성자 <input type="text" name="fcommenter" id="fcommenter" style="width: 100px; height:25px;">
								</div>
								<button type="submit" value="" class="ok" onClick="javascript: prevOkTextBox();">OK</button>
							</div>
							<div class="content">
			         <textarea name="fcontent" id="fcontent" cols="61" rows="5" placeholder="15자 내외로 입력해주세요."></textarea>
			        </div>			        
						</div>
					</form>
				</div>
				<div><span id="toggleButton" class="material-symbols-outlined">keyboard_tab_rtl</span></div>
		</div>
  </nav>  
  
  <%@ include file="footer.jsp" %>
  
		<script>
		
		  console.log(<%= currPage %>);
		
    	function searchText() {
    		location.href = "./orderList.jsp?search=" + $('#search-text').val();
    	}
    	
    	function searchDate() {
    	    var searchDateValue = document.getElementById("search-date").value;
    	    // URL에 검색한 날짜를 파라미터로 포함하여 리다이렉트
    	    location.href = "./orderList.jsp?search-date=" + searchDateValue;
    	    console.log(searchDateValue);
    	}
    	
    	function noticeDelete(noticeNum) {
    		if (confirm('정말 삭제하시겠습니까?')) {
    			location.href = "./orderProductDelete.jsp?order_num=" + noticeNum;
    		}
    	}
    	
    	
    	function prevOkTextBox() { //console.log('잘 나와?');  			
   			
    		if(!$('#fordernum').val()) {		//이름 관련 dom
   				alert('주문번호를 입력하세요.');		//이름 입력 팝업
   				$('#fordernum').focus();		//이름 입력칸으로 포커스 이동
   				
   				return;
   			}
    		
   			
   			if(!$('#fcommenter').val()) {		//이름 관련 dom
   				alert('작성자를 입력하세요.');		//이름 입력 팝업
   				$('#fcommenter').focus();		//이름 입력칸으로 포커스 이동
   				
   				return;
   			}
   			
   			if(!$('#fcontent').val()) {		//이름 관련 dom
   				alert('내용을 입력하세요.');		//이름 입력 팝업
   				$('#fcontent').focus();		//이름 입력칸으로 포커스 이동
   				
   				return;
   			}
   			
   			
   			// 사용자가 등록을 원하는지 확인하는 창 표시
 		    if (confirm('게시후 삭제할 수 없습니다. 정말 게시하겠습니까?')) {
 		        // 사용자가 확인을 클릭한 경우 폼 제출
 		       document.getElementById('form2').submit()
 		    }
   	
   		}
   
    	$(document).ready(function() {
    	    var clickedPage = <%= currPage %>; // 클릭된 페이지의 초기값을 현재 페이지로 설정

    	    // 페이지네이션 링크에 클릭 이벤트 처리
    	    $('.pagination a').on('click', function() {
    	        // 클릭된 페이지가 다른 페이지로 이동하기 전까지만 유지되도록 클래스 추가/제거
    	        $('.pagination a').removeClass('active'); // 모든 페이지네이션 링크에서 active 클래스 제거
    	        $(this).addClass('active'); // 클릭된 페이지네이션 링크에 active 클래스 추가
    	        clickedPage = $(this).index() + 1; // 클릭된 페이지의 인덱스를 저장
    	    });

    	    // 페이지 로드 시 초기 클릭된 페이지에 대한 스타일 적용
    	    $('.pagination a').eq(clickedPage).addClass('active');
    	});
    	
    </script>
  
</body>
</html>