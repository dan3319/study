<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/find_result.css">
<script defer src="./js/find_pw.js"></script>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");

	String find_pw_id = request.getParameter("find_pw_id");
	String find_pw_name = request.getParameter("find_pw_name");
	String find_pw_email = request.getParameter("find_pw_email");

	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "SEMI_PROJECT2";
	String PASSWORD = "123452";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	
	try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
			conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
		
			String sql = "SELECT PW FROM MANAGER WHERE ID=? AND NAME=? AND EMAIL=?";
			
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, find_pw_id);
	        pstmt.setString(2, find_pw_name);
	        pstmt.setString(3, find_pw_email);
	        
	        rs = pstmt.executeQuery();
				
	        
	        if (rs.next()) {
	            // 회원 정보가 일치하는 경우, 비밀번호 변경 로직 수행
	            
	        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+";
            StringBuilder sb = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < 8; i++) {
                int index = random.nextInt(characters.length());
                sb.append(characters.charAt(index));
            }
            String newPassword = sb.toString();
             
            
	            // 비밀번호 변경 SQL 작성 및 실행
	            String updateSql = "UPDATE MANAGER SET pw=? WHERE id=?";
	            pstmt = conn.prepareStatement(updateSql);
	            pstmt.setString(1, newPassword);
	            pstmt.setString(2, find_pw_id);
	            int updateResult = pstmt.executeUpdate();

	            if (updateResult > 0) {
	                // 비밀번호 변경이 성공했다면 성공 메시지 출력
	            %>    
	             <div class="pw_find">   
	                <p>회원정보 확인 완료했습니다.</p>
	                <p>임시 패스워드: <%= newPassword %>
	                <br>
	                <button onclick="location.href='login.jsp'" class="pw_find_but">로그인</button>
	             </div>   
	        <%    
	            } else {
	                // 비밀번호 변경이 실패한 경우
	                out.println("<p>비밀번호 변경에 실패했습니다.</p>");
	            } 			
	        } else {
	            // 회원 정보가 일치하지 않는 경우
	            out.println("<p>입력한 정보와 일치하는 회원이 없습니다.</p>");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        // 에러 처리 코드 추가
	    } finally {
	        // 자원 해제
	        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
	    }
	
%>
</body>
</html>