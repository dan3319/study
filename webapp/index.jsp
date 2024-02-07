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
   
    Connection conn = null; //��� ���� ������ ���� ���� ����
    Statement stmt = null; //������ �����ϱ� ��ü ����
    ResultSet rs = null;
   
    Exception exception = null;
    
    try {
	  /*String sql = "SELECT * FROM PRODUCTS";*/
    	
      // 0.
      Class.forName("oracle.jdbc.driver.OracleDriver");
      
      // 1. JDBC�� Oracle����
      conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
      // System.out.println("����Ŭ ���� ����");
     
      // 2. PRODUCTS ���̺��� SQL�� ������ ��������
      stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
              ResultSet.CONCUR_UPDATABLE); // 2-2. SQL ���� ����);   // 2-1. Statement ����
      rs = stmt.executeQuery("SELECT * FROM PRODUCTS");
      rs.last();
      int totalCount = rs.getRow();		// �� ��
      rs.beforeFirst();
      
      System.out.println("totalCount= " + totalCount);
	  
      int page = 1;		// ���� ������
      int startPage = 1;	// ���� ������
      int countList = 10;	// �� �������� ������ ��
      int totalPage = totalCount / countList;	// �� ������ ��
      if (totalCount % countList > 0) {
    	  totalPage++;
      }
      
      /*if (page > 1){	// ���� ������
    	  System.out.print("<a href="'./product_list.jsp?page=" + (page - 1)'">����������</a>");
      }*/
	
      for (int iCount = startPage; iCount <= totalPage; iCount++){	// ���޾Ƽ� ������ ��ȣ ��� 
    	  if (iCount == page) {			// ���� ������ ����
    		  System.out.print("<b> "+iCount+"</b>; "); 
    	  } else {
    		  System.out.print(" "+iCount+" ");
    	  }
      }	
      
      /*if(page < totalPage){		// ���� ������
    	  System.out.print("<a href="'./product_list.jsp?page=" + (page + 1)'">����������</a>");
      }*/
      
      int startCount = (page-1) * countList +1;		// ���� �������� ���� ������ ù��° �Խñ�
      int endCount = page * countList;	// ���� �������� ���� ������ ������ �Խñ�
      
      SELECT ronum as rnum, a.ITEM_NUM, a.GENDER, a.CATEGORY, a.ITEM_TYPE, a.ITEM_NAME, a.ITEM_SIZE, a.COLOR, a.PRICE 
      FROM (SELECT ITEM_NUM, GENDER, CATEGORY, ITEM_TYPE, ITEM_NAME, ITEM_SIZE, COLOR, PRICE
    		  form products
    		  order by item_num)a;
      
      
      
      
      System.out.println("contList= " + countList);
      System.out.println("totalPage= " + totalPage);
      
      
      
      
      
      
  	} catch(Exception e) {
    	System.out.println("����Ŭ ���� ����:" + e);
  	} finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
  	}
    
    
%>
