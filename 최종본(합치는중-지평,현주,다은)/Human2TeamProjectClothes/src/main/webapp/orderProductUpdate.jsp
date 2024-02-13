<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.Exception" %>    
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	String requester = ""; //작성자
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
	
	String ordernum = "";
	
	
	String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	String USER = "semi_project2";
	String PASSWORD = "123452";
	
	 Connection conn = null; //디비 접속 성공시 접속 정보 저장
	 PreparedStatement pstmt = null; // 쿼리 실행문
	 Exception exception = null;
	 
	 String savePath = "C:\\Users\\human-12\\Desktop\\project\\STS\\semi-project\\src\\main\\webapp\\upload-files";
	 
	 try {
		  MultipartRequest multi = new MultipartRequest(
			  request,
			  savePath,			// 실제 파일을 저장할 서버의 디렉토리
			  1024 * 1024 * 5,  // 업로드 제한 파일 크기(단위 byte) -> 5MB
			  "utf-8",
			  new DefaultFileRenamePolicy()
		  );
		  
		  requester = multi.getParameter("requester");
			brandname = multi.getParameter("brandname"); //브랜드
			
			itemtype = multi.getParameter("itemtype");//종류
			orderplace = multi.getParameter("orderplace");//의뢰처
			itemname = multi.getParameter("itemname");//제품이름
			itemsize = multi.getParameter("itemsize");//사이즈
			
			quantity = Integer.parseInt(multi.getParameter("quantity"));//수량
			
			chest = Integer.parseInt(multi.getParameter("chest"));
			frontlength = Integer.parseInt(multi.getParameter("frontlength"));
			sleevelength = Integer.parseInt(multi.getParameter("sleevelength"));
			backwidth = Integer.parseInt(multi.getParameter("backwidth"));
			armwidth = Integer.parseInt(multi.getParameter("armwidth"));

			requirements = multi.getParameter("requirements") ;
			productdetails = multi.getParameter("productdetails");
			
			ordernum = multi.getParameter("ordernum");
					
			String filePrev = multi.getParameter("filePrev");
			String filename = multi.getFilesystemName("filecontent");	
		  
			// 0.
			 Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 1. JDBC로 Oracle연결
		  conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
		  
			String fileQueryName = "";
			
			if (filename != null) {
				// 실제 첨부파일1 삭제
				File file = new File(savePath + "\\" + filePrev);
				if (file.exists()) {
					file.delete();
				}
				
				fileQueryName = ", FILE_PATH = '" + filename + "' ";
			}
			
			
			String updateQuery = "UPDATE ORDER_PRODUCT SET REQUESTER = ?, BRAND_NAME = ?, ITEM_TYPE = ?, ORDER_PLACE = ?, ITEM_NAME = ?, ITEM_SIZE = ?, QUANTITY = ?, CHEST = ?, FRONT_LENGTH = ?, SLEEVE_LENGTH = ?, BACK_WIDTH = ?, ARM_WIDTH = ?, REQUIREMENTS = ?, PRODUCT_DETAILS = ?"
					+ fileQueryName + "WHERE ORDER_NUM = ?";
			
			pstmt = conn.prepareStatement(updateQuery);
			
			pstmt.setString(1, requester);
			pstmt.setString(2, brandname);
			pstmt.setString(3, itemtype);
			pstmt.setString(4, orderplace);
			pstmt.setString(5, itemname);
			pstmt.setString(6, itemsize);
			
			pstmt.setInt(7, quantity);
			
			pstmt.setInt(8, chest);
			pstmt.setInt(9, frontlength);
			pstmt.setInt(10, sleevelength);
			pstmt.setInt(11, backwidth);
			pstmt.setInt(12, armwidth);
			
			pstmt.setString(13, requirements);
			pstmt.setString(14, productdetails);
			
			pstmt.setInt(15, Integer.parseInt(ordernum));
			
			pstmt.executeUpdate();
	  } catch(Exception e) {
		  exception = e;
		  e.printStackTrace();
	  } finally {
		  if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
		  if (conn != null) try { conn.close(); } catch (SQLException ex) {}
	  }
	%>

	<%
		if (exception == null) {	// 공지사항 글 수정이 성공할 경우
			// 1. 성공 팝업 생성
			// 2. 공지사항 리스트로 이동
	%>		
	<!-- 성공 케이스 html/css/js -->
	<script>
		alert('공지사항 글이 성공적으로 수정되었습니다.');	// 1
		location.href = '<%= request.getContextPath() %>/orderList.jsp';
	</script>
	<%
		} else {									// 공지사항 글 수정이 실패할 경우
			// 1. 실패글
			// 2. 오류내용 표시
	%>
	<!-- 실패 케이스 html/css/js -->
	공지사항 글 수정이 실패하였습니다. 시스템 관리자에게 문의하세요.<br>
	오류내용: <%= exception.getMessage() %>
	<%	
		}
	%>








