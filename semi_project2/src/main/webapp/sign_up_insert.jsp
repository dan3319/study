<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.lang.Exception" %>
<%@ page import = "java.sql.*" %>    

<% 
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String koname = request.getParameter("koname");
	String pnum = request.getParameter("pnum");
	String email = request.getParameter("email");

	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "SEMI_PROJECT2";
	String PASSWORD = "123452";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Exception exception = null;
	
	try {
		conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
		
		String insertQuery = "INSERT INTO MANAGER(ID, PW, NAME, PHONE, EMAIL) VALUES (?,?,?,?,?)";
		//System.out.println("오라클 접속 성공");
		pstmt = conn.prepareStatement(insertQuery);

		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, koname);
		pstmt.setString(4, pnum);
		pstmt.setString(5, email);
		pstmt.executeUpdate();
		
	} catch(Exception e) {
		exception = e;
		
	} finally {
	  if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
	  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
	  
	}
		
%>

<% 
	if (exception == null) {
%>

	<script>
		alert('가입 완료되었습니다');
		location.href = '<%= request.getContextPath() %>/index.jsp';
	</script>
<%
	} else {
%>
	<script>
		alert('가입 실패하였습니다');
		location.href = '<%= request.getContextPath() %>/sign_up.jsp';
	</script>
<%
	}
%>	