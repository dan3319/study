<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.lang.Exception, java.sql.SQLException" %> 
<%
    String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
    String USER = "semi_project2";
  	String PASSWORD = "123452";
   
    Connection conn = null; //디비 접속 성공시 접속 정보 저장
    Statement stmt = null; //쿼리를 실행하기 객체 정보
    ResultSet rs = null;
   
    Exception exception = null;
    
    try {
	  /*String sql = "SELECT * FROM PRODUCTS";*/
    	
      // 0.
      Class.forName("oracle.jdbc.driver.OracleDriver");
      
      // 1. JDBC로 Oracle연결
      conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
      // System.out.println("오라클 접속 성공");
     
      // 2. PRODUCTS 테이블에서 SQL로 데이터 가져오기
      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
              ResultSet.CONCUR_UPDATABLE); // 2-2. SQL 쿼리 실행);   // 2-1. Statement 생성
      rs = stmt.executeQuery("SELECT * FROM PRODUCTS");
      rs.last();
      int totalCount = rs.getRow();		// 행 수
      rs.beforeFirst();
      
      System.out.println("totalCount= " + totalCount);
	  
      int page = 1;		// 현재 페이지
      int startPage = 1;	// 시작 페이지
      int countList = 10;	// 한 페이지에 보여질 수
      int totalPage = totalCount / countList;	// 총 페이지 수
      if (totalCount % countList > 0) {
    	  totalPage++;
      }
      
      /*if (page > 1){	// 이전 페이지
    	  System.out.print("<a href="'./product_list.jsp?page=" + (page - 1)'">이전페이지</a>");
      }*/
	
      for (int iCount = startPage; iCount <= totalPage; iCount++){	// 연달아서 페이지 번호 출력 
    	  if (iCount == page) {			// 현재 페이지 굵게
    		  System.out.print("<b> "+iCount+"</b>; "); 
    	  } else {
    		  System.out.print(" "+iCount+" ");
    	  }
      }	
      
      /*if(page < totalPage){		// 다음 페이지
    	  System.out.print("<a href="'./product_list.jsp?page=" + (page + 1)'">다음페이지</a>");
      }*/
      
      int startCount = (page-1) * countList +1;		// 현재 페이지에 따라 가져올 첫번째 게시글
      int endCount = page * countList;	// 현재 페이지에 따라 가져올 마지막 게시글
      
      SELECT ronum as rnum, a.ITEM_NUM, a.GENDER, a.CATEGORY, a.ITEM_TYPE, a.ITEM_NAME, a.ITEM_SIZE, a.COLOR, a.PRICE 
      FROM (SELECT ITEM_NUM, GENDER, CATEGORY, ITEM_TYPE, ITEM_NAME, ITEM_SIZE, COLOR, PRICE
    		  form products
    		  order by item_num)a;
      
      
      
      
      System.out.println("contList= " + countList);
      System.out.println("totalPage= " + totalPage);
      
      
      
      
      
      
  	} catch(Exception e) {
    	System.out.println("오라클 접속 오류:" + e);
  	} finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  	}
    
    
%>
