<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");

	String find_id = request.getParameter("find_id");
	String find_email = request.getParameter("find_email");

	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "SEMI_PROJECT2";
	String PASSWORD = "123452";
	
	Connection conn = null;
	Exception exception = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
		
		String sql = "SELECT ID FROM MANAGER WHERE NAME=? AND EMAIL=?";
		
		//System.out.println("오라클 접속 성공");
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, find_id);
		pstmt.setString(2, find_email);
		
		rs = pstmt.executeQuery();
		
        if (rs.next()) {
            String find_Id = rs.getString("ID");
%>
		<p><strong>아이디 찾기 결과:</strong> <%= find_Id %></p>
		<button onclick="location.href='login.jsp'">로그인</button>
<%				
       } else {
%> 
	   <p>입력하신 정보로 아이디를 찾을 수 없습니다.</p>
<%   	   
      }                  
	} catch(Exception e) {
		
		exception = e;
		
	} finally {
	  if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
	  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
	  
	}
		
%>
</body>
</html>