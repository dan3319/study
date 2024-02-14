<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.DBConfig"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/inventory.css">
    <link rel="icon" href="./image/favicon.ico" />
    <title>Document</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String currentPage=request.getParameter("pagenum");
		String itemName = request.getParameter("itemName");
		String itemCategory = request.getParameter("itemCategory");
		String itemSize = request.getParameter("itemSize");
		if(currentPage==null){
			currentPage="1";
		}
		if(itemName==null){
			itemName="";
		}
		if(itemCategory==null){
			itemCategory="";
		}
		if(itemSize==null){
			itemSize="";
		}

		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		//페이징 변수
		int totalCount=0;
		int pageCount=5;
		int limit=10;
		int totalPage=0;
		int pageGroup=0;
		int firstNumber=0;
		int lastNumber=0;
		int row = 0;
		int lastpageGroup=0;
		int next=0;
		int prev=0;
		
		try{
			conn=DBConfig.getConnection();
	%>

    <div id="container">
    <%@ include file="login_header.jsp" %>
        <div id="content">
            <div id="top">
                <form action="inventory.jsp" id="searchForm" method="post">
                    <div id="search">
                        <select name="selecttype" class="selectClass" id="selectId" onchange="tagSelect()">
                            <option disabled>==선택==</option>
                            <option selected>현재고</option>
                            <option>기간별재고</option>
                        </select>
                        <input type="text" name="itemName" class="textInput" id="selectItemName" placeholder="제품명 입력" value="<%=itemName%>">
                        <input type="submit" value="검색" id="submitbtn">
                    </div>
                	<div id="category">
                        <ul>
                            <li><label for="" class="labelText">카테고리</label><input type="text" name="itemCategory" class="textInput" id="itemCategory" placeholder="카테고리 입력" value="<%=itemCategory%>"></li>
                            
                            <li>
                                <label for="" class="labelText">사이즈</label>
                                <select class="selectClass" name="itemSize" id="itemSize">
                                	<option value="" selected="selected"></option>
                               		<%
                               				String sql = "SELECT ITEM_SIZE  FROM PRODUCTS GROUP BY ITEM_SIZE";
                               				pstmt = conn.prepareStatement(sql);
                               				rs=pstmt.executeQuery();
                               				
                               				while(rs.next()){
                               					if(itemSize.equals(rs.getString(1).toUpperCase())){
                               						%>
	                               						<option selected><%=rs.getString(1).toUpperCase()%></option>
	                               					<%
                               					} else{
                               						%>
	                               						<option><%=rs.getString(1).toUpperCase()%></option>
	                               					<%
                               					}
                               				}
                               		%>
                                </select>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>    
            <%
        
	       		String sql2 = "SELECT COUNT(*) "+
	       				"FROM ITEM_MANAGEMENT im, PRODUCTS p "+
	       				"WHERE im.ITEM_NUM =P.ITEM_NUM "+
	       				"AND P.CATEGORY LIKE '%"+itemCategory+"%' AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.ITEM_SIZE LIKE '"+itemSize+"%' "+ 
	       				"ORDER BY IM.ITEM_NUM ";
  				pstmt = conn.prepareStatement(sql2);
  				rs=pstmt.executeQuery();
  				
  				if(rs.next()){
  					totalCount+=rs.getInt(1);
  				}
        
  				totalPage = (int)(totalCount/limit);
            	if(totalCount%limit>0){
            		totalPage+=1;
            	}
            
	            if(totalPage<Integer.parseInt(currentPage)){
					currentPage=Integer.toString(totalPage);
				}
	            pageGroup=Integer.valueOf(currentPage)/pageCount;

				if(pageGroup==0){
					pageGroup++;
				}
				
				lastNumber = pageGroup*pageCount;

				if(lastNumber>totalPage){
					lastNumber=totalPage;
				}

				firstNumber = lastNumber-(pageCount-1);
				
				next = lastNumber+1;
				prev = firstNumber-1;
				
				if(firstNumber<=0){
					firstNumber=1;
					prev=1;
				}
				
				int count=Integer.parseInt(currentPage)-1;
				
				row=limit*count;
            %>
            <div id="bottom">
                <div id="title">
                    <p>현 재고 현황</p>
                </div>
               			<div id="subject">
		                    <ul>
		                        <li class="category" style="width: 10%">카테고리</li>
		                        <li class="itemnum" style="width: 10%">제품번호</li>
		                        <li class="itemname" style="width: 60%">제품명</li>
		                        <li class="size" style="width: 5%">사이즈</li>
		                        <li class="count" style="width: 15%">재고량</li>
		                    </ul>
                		<%
                		sql2 = "SELECT P.CATEGORY ,IM.ITEM_NUM, P.ITEM_NAME ,P.ITEM_SIZE ,IM.QUANTITY "+
        	       				"FROM ITEM_MANAGEMENT im, PRODUCTS p "+
        	       				"WHERE im.ITEM_NUM =P.ITEM_NUM "+
        	       				"AND P.CATEGORY LIKE '%"+itemCategory+"%' AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.ITEM_SIZE LIKE '"+itemSize+"%' "+ 
        	       				"ORDER BY IM.ITEM_NUM OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROW ONLY";
          				pstmt = conn.prepareStatement(sql2);
          				rs=pstmt.executeQuery();
          				while(rs.next()){
          					%>
          					<ul>
		                        <li class="category" style="width: 10%"><%=rs.getString(1)%></li>
		                        <li class="itemnum" style="width: 10%"><%=rs.getInt(2)%></li>
		                        <li class="itemname" style="width: 60%"><%=rs.getString(3)%></li>
		                        <li class="size" style="width: 5%"><%=rs.getString(4)%></li>
		                        <li class="count" style="width: 15%"><%=rs.getInt(5)%></li>
		                    </ul>
          					<%
          				}
	       				%>
	       				</div>

                <div id="page">
                    <ul>
                    	<%
                           	if(pageGroup!=1){
                           		%>
                           		<li>
                       				<a class="pageNum pagebtn" href="inventory.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&itemSize=<%=itemSize%>&pagenum=<%=prev%>">이전</a>
                       			</li>
                           		<%
                           	}
                        %>                        
                        <%
                        for(int i=firstNumber;i<=lastNumber;i++){
                    		if (i == Integer.parseInt(currentPage)) { 
                            	%>
                            	<li>
	                        		<a class="pageNum" style="background-color: #8785A2; color: white;" href="inventory.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&itemSize=<%=itemSize%>&pagenum=<%=i%>"><%=i%></a>
	                        	</li>
                            	<%
                        	} else{
                          		%>
                              	<li>
	                        		<a class="pageNum" href="inventory.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&itemSize=<%=itemSize%>&pagenum=<%=i%>"><%=i%></a>
	                        	</li>	
                              	<%
                          	}
                    	}
                        %>  
                        <%
                           	if(pageGroup!=lastpageGroup && pageGroup!=1){
                           		%>
                           		<li>
                       				<a class="pageNum pagebtn" href="inventory.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&itemSize=<%=itemSize%>&pagenum=">다음</a>
                       			</li>
                           		<%
                           	}
                        %> 
                    </ul>
                </div>
                <% 
					}catch(Exception e){
						
					}
                %>
            </div>
        </div>
    </div>
     <%@ include file="footer.jsp" %>
    <script type="text/javascript">
    	function tagSelect() {
    		var opt = document.getElementById("selectId");
            var optVal = opt.options[opt.selectedIndex].text;
            if(optVal=="현재고"){
            	location.href='inventory.jsp';
            } else if(optVal=="기간별재고"){
            	location.href='inventory2.jsp';
            }
		}
    </script>
</body>
</html>