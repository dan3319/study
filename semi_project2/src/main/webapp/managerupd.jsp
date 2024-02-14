<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.lang.Exception, java.sql.SQLException" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/manager.css">
</head>
<body>
<%
				String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
				String USER = "SEMI_PROJECT2";
				String PASSWORD = "123452";
  
			    Connection conn = null; //디비 접속 성공시 접속 정보 저장
				Statement stmt = null; //쿼리를 실행하기 객체 정보
				ResultSet rs = null;
	
				Exception exception = null;
				
				String id = "";
				String name = "";
				String phone = "";
				String email = "";
				String join_date = "";
				
  try {
	  // 0.
				  Class.forName("oracle.jdbc.driver.OracleDriver");
				  
				  // 1. JDBC로 Oracle연결
				  		conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
				  // System.out.println("오라클 접속 성공");
				  
					// 2. BO_FREE 테이블에서 SQL로 데이터 가져오기
						 	stmt = conn.createStatement();	// 2-1. Statement 생성
						 	rs = stmt.executeQuery("SELECT * FROM MANAGER WHERE ID = '?'"); // 2-2. SQL 쿼리 실행
				 	
							 	if (rs.next()) {
							 					id = rs.getString("ID");
							 					name = rs.getString("NAME");
							 					phone = rs.getString("PHONE");
							 					email = rs.getString("EMAIL");
							 					join_date = rs.getString("JOIN_DATE");
								   }
  } catch(Exception e) {
	  						System.out.println("오라클 접속 오류: " + e);
	  
  } finally {
								  if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
								  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  }
%>

<div class="manager_box">
	아이디: <input type="text" value="<%= id %>">
	이름: <input type="text" value="<%= name %>">
	휴대폰번호: <input type="text" value="<%= phone %>">
	이메일: <input type="text" value="<%= email %>">
	가입일: <input type="text" value="<%= join_date %>">
</div>
</body>
</html>