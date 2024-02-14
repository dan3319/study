<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.lang.Exception" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
			request.setCharacterEncoding("UTF-8");
			
			String iputid = request.getParameter("iputid");
			String iputpw = request.getParameter("iputpw");
			
			String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
			String USER = "SEMI_PROJECT2";
			String PASSWORD = "123452";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Exception exception = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
			
			String loginQuery = "SELECT * FROM MANAGER WHERE ID = ? AND PW = ?";
			pstmt = conn.prepareStatement(loginQuery);
			pstmt.setString(1, iputid);
			pstmt.setString(2, iputpw);
			
			rs= pstmt.executeQuery();
	
	
		  
			if (rs.next()) {
				
		        session.setAttribute("id", iputid);
		        session.setAttribute("name", rs.getString("name"));
		        session.setAttribute("email", rs.getString("email"));
		        session.setAttribute("phone", rs.getString("phone"));
		       
		   
		    %> 
		  		<script>
		  			alert("<%= iputid %> 님 로그인에 성공했습니다.");
        			location.href = '<%= request.getContextPath() %>/main.jsp';
    			</script>
		    <%    
			} else {
			%>	
				<script>
					alert('아이디 또는 비밀번호가 잘못되었습니다.');
					location.href = '<%= request.getContextPath() %>/index.jsp';
				</script>
			<%	
				
			  }		
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
		        // 자원 해제
		        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
		        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
		        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
		
			}		
%>
</body>
</html>