<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.DBConfig"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String info = request.getParameter("info");
	String itemnum = request.getParameter("itemnum");
	String type = request.getParameter("type");
	String date = request.getParameter("date");
	String itemcount = request.getParameter("itemcount");
	
	int num = Integer.parseInt(itemnum);
	int count = Integer.parseInt(itemcount);
	Connection conn = null; 
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Exception exception = null;
	
	int searchcount=0;
	try{
		conn=DBConfig.getConnection();
		String sql="";
		
		
		if(type.equals("item")){
			if(info.equals("import")){
				sql = "SELECT SUM(IMPORT_QUANTITY) FROM IMPORT WHERE ITEM_NUM ="+num+" GROUP BY ITEM_NUM";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					searchcount+=rs.getInt(1);
				}
				
				sql = "INSERT INTO IMPORT "+
								"VALUES (import_seq.nextval, "+num+", ?,"+count+", "+
										(searchcount+count)+", "+
										"(SELECT PRICE*0.5  FROM PRODUCTS p WHERE ITEM_NUM ="+num+"), "+
										"(SELECT PRICE*0.5*0.1 FROM PRODUCTS p WHERE ITEM_NUM ="+num+"),'입고')";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				pstmt.executeUpdate();
			} else if(info.equals("export")){
				sql = "SELECT SUM(EXPORT_QUANTITY) FROM EXPORT WHERE ITEM_NUM = "+num+" GROUP BY ITEM_NUM";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					searchcount+=rs.getInt(1);
				}
				
				sql = "INSERT INTO EXPORT VALUES(EXPORT_SEQ.NEXTVAL,"+num+",?,"+count+", "+
						(searchcount+count)+", "+ 
						"(SELECT PRICE FROM PRODUCTS p WHERE ITEM_NUM ="+num+"),'출고')";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				pstmt.executeUpdate();
			}
		} else if(type.equals("order")){
			sql = "INSERT INTO sample VALUES("+num+",?,"+count+")";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.executeUpdate();
		}
		
		int numArray[];
		int numArray2[];
		int update[];
		int arraySize=0;
		int index=0;
		sql = "SELECT ITEM_NUM FROM IMPORT i GROUP BY ITEM_NUM ORDER BY ITEM_NUM";
		pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = pstmt.executeQuery();
		
		rs.last();
		arraySize=rs.getRow();
		rs.beforeFirst();
		numArray=new int[arraySize];
		numArray2=new int[arraySize];
		update = new int[arraySize];
		
		while(rs.next()){
			numArray[index]=rs.getInt(1);
			index++;
		}
		
		sql = "SELECT ITEM_NUM FROM ITEM_MANAGEMENT im GROUP BY ITEM_NUM ORDER BY ITEM_NUM";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		index=0;
		while(rs.next()){
			numArray2[index]=rs.getInt(1);
			index++;
		}
		
		
		
		for(int i=0;i<numArray.length;i++){
			for(int j=0;j<numArray2.length;j++){
				if(numArray[i]==numArray2[j]){
					update[i]=numArray[i];
					numArray[i]=0;
				}
			}
		}
		
		for(int i=0;i<numArray.length;i++){
			if(numArray[i]!=0){
				sql = "INSERT INTO ITEM_MANAGEMENT VALUES ("+numArray[i]+", (SELECT MAX(TOTAL_QUANTITY) FROM IMPORT i WHERE ITEM_NUM ="+numArray[i]+"),0,0)";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
			}
		}
		
		for(int i=0;i<update.length;i++){
			sql = "UPDATE ITEM_MANAGEMENT  SET IMPORT_QUANTITY = (SELECT MAX(TOTAL_QUANTITY) FROM IMPORT i WHERE ITEM_NUM ="+update[i]+") WHERE ITEM_NUM ="+update[i];
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}
		
		
		
		sql = "SELECT ITEM_NUM FROM ITEM_MANAGEMENT im GROUP BY ITEM_NUM ORDER BY ITEM_NUM";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		index=0;
		while(rs.next()){
			numArray2[index]=rs.getInt(1);
			index++;
		}
		
		for(int i=0;i<numArray2.length;i++){
			sql = "SELECT MAX(TOTAL_QUANTITY)  FROM EXPORT e WHERE ITEM_NUM ="+numArray2[i];
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			String totalQuantity = "";
			if(rs.next()){
				totalQuantity=rs.getString(1);
			}
			if(totalQuantity==null){
				totalQuantity="0";
			}
			
			sql = "UPDATE ITEM_MANAGEMENT SET "+
					"EXPORT_QUANTITY = "+Integer.parseInt(totalQuantity)+" WHERE ITEM_NUM ="+numArray2[i];
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}
		
		for(int i=0;i<numArray2.length;i++){
			sql = "UPDATE ITEM_MANAGEMENT SET "+
					"QUANTITY = IMPORT_QUANTITY-EXPORT_QUANTITY WHERE ITEM_NUM ="+numArray2[i];
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}
		
	}catch(Exception e){
		exception=e;
		System.out.println("에러 로그:"+e.getMessage());
	} finally{
		if(pstmt !=null){try{pstmt.close();}catch(SQLException e){}}
		if(conn !=null){try{conn.close();}catch(SQLException e){}}
	}
%>

<%
	if(exception==null){
		%>
		<script>
		alert('재고 등록 완료.');
		location.href='<%=request.getContextPath()%>/store.jsp';
		</script>
		<%	
	} else{
		%>
		공지사항 등록이 실패하였습니다. 시스템 관리자에게 문의하세요.<BR>
		오류내용:<%=exception.getMessage() %>
		<%
	}
%>