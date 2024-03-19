<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 데이터베이스 연결 정보
	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "SEMI_PROJECT2";
	String PASSWORD = "123452";

    // 전송된 사용자 정보 가져오기
    String id = request.getParameter("id");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");

    // 패스워드 확인
    if (!newPassword.equals(confirmPassword)) {
        out.println("비밀번호가 일치하지 않습니다.");
        return;
    }

    // 데이터베이스 연결 및 사용자 정보 업데이트
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);

        // 사용자 정보 업데이트 쿼리 작성
        String sql = "UPDATE MANAGER SET PW=?, NAME=?, PHONE=? WHERE ID=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newPassword);
        pstmt.setString(2, name);
        pstmt.setString(3, phone);
        pstmt.setString(4, id);

        // 쿼리 실행
        int affectedRows = pstmt.executeUpdate();

        if (affectedRows > 0) {
            out.println("회원정보가 성공적으로 수정되었습니다.");
        } else {
            out.println("회원정보 수정에 실패했습니다.");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("오류가 발생했습니다: " + e.getMessage());
    } finally {
        // 자원 해제
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>