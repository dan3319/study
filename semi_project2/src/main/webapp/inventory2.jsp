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
		String itemdivision = request.getParameter("itemdivision");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		
		if(currentPage==null){
			currentPage="1";
		}
		if(itemName==null){
			itemName="";
		}
		if(itemCategory==null){
			itemCategory="";
		}
		
		if(itemdivision==null){
			itemdivision="";
		}
		
		if(itemdivision.equals("all")){
			itemdivision="";
			System.out.println(itemdivision);
		} else if(itemdivision.equals("store")){
			itemdivision="입고";
			System.out.println(itemdivision);
		} else if(itemdivision.equals("release")){
			itemdivision="출고";
			System.out.println(itemdivision);
		}
		if(start==null){
			start="";
		}
		if(end==null){
			end="";
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
                <form action="inventory2.jsp" id="searchForm" method="get">
                    <div id="search">
                        <select class="selectClass" id="selectId" onchange="tagSelect()">
                            <option disabled>==선택==</option>
                      		<option>현재고</option>
                            <option selected>기간별재고</option>
                        </select>
                        <input type="text" name="itemName" class="textInput" id="selectItemName" placeholder="제품명 입력" value="<%=itemName%>">
                        <input type="submit" value="검색" id="submitbtn">
                    </div>
                  	<div id="category2">
                        <ul>
                            <li><label for="" class="labelText">카테고리</label><input type="text" name="itemCategory" class="textInput" id="itemCategory" placeholder="카테고리 입력" value="<%=itemCategory%>"></li>
                            <li>
                           		<label for="" class="labelText" style="margin-left: 20px">구분</label>
                           		<%
                           			if(itemdivision.equals("")){
                           				%>
                           				<label for="">전체</label>
		                           		<input type="radio" name="itemdivision" value="all" checked>
		                           		<label for="">입고</label>
		                           		<input type="radio" name="itemdivision" value="store">
		                           		<label for="">출고</label>
		                           		<input type="radio" name="itemdivision" value="release">
                           				<%
                           			}else if(itemdivision.equals("입고")){
                           				%>
                           				<label for="">전체</label>
		                           		<input type="radio" name="itemdivision" value="all">
		                           		<label for="">입고</label>
		                           		<input type="radio" name="itemdivision" value="store" checked>
		                           		<label for="">출고</label>
		                           		<input type="radio" name="itemdivision" value="release">
                           				<%
                           			}else if(itemdivision.equals("출고")){
                           				%>
                           				<label for="">전체</label>
		                           		<input type="radio" name="itemdivision" value="all">
		                           		<label for="">입고</label>
		                           		<input type="radio" name="itemdivision" value="store">
		                           		<label for="">출고</label>
		                           		<input type="radio" name="itemdivision" value="release" checked>
                           				<%
                           			}
                           		%>
                            </li>
                        </ul>
                        <ul style="margin-top: 20px">
                        	<li>
                        		<label for="" class="labelText">기준날짜(시작)</label>
                        		<input type="text" name="start" class="textInput" id="start" placeholder="날짜 입력" value="<%=start%>">
                        		<input type="date" class="date" id="startDate" onchange="startDateMethod()">
                        	</li>
                        	<li>
                        		<label for="" class="labelText">기준날짜(종료)</label>
                        		<input type="text" name="end" class="textInput" id="end" placeholder="날짜 입력" value="<%=end%>">
                        		<input type="date" class="date" id="endDate" onchange="endDateMethod()">
                        	</li>
                        </ul>
                    </div>
                </form>
            </div>
            
            <%
            	String sql ="";
                        				
                if(start=="" && end==""){
              		sql ="SELECT (SELECT COUNT(*) "+
              				"FROM IMPORT i, PRODUCTS p "+ 
              				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%') "+
              				"+(SELECT COUNT(*) "+
              				"FROM EXPORT e, PRODUCTS p "+ 
              				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%') A "+
              				"FROM DUAL";
              	}else if(start!="" && end!=""){
              		sql ="SELECT (SELECT COUNT(*) "+
              				"FROM IMPORT i, PRODUCTS p "+ 
              				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%' AND i.IMPORT_DATE BETWEEN '"+start+"' AND '"+end+"') "+
              				"+(SELECT COUNT(*) "+
              				"FROM EXPORT e, PRODUCTS p "+ 
              				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%' AND E.EXPORT_DATE BETWEEN '"+start+"' AND '"+end+"') A "+
              				"FROM DUAL";
              	}else if(start=="" && end!=""){
              		sql ="SELECT (SELECT COUNT(*) "+
              				"FROM IMPORT i, PRODUCTS p "+ 
              				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%' AND i.IMPORT_DATE <= '"+end+"') "+
              				"+(SELECT COUNT(*) "+
              				"FROM EXPORT e, PRODUCTS p "+ 
              				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%' AND E.EXPORT_DATE <= '"+end+"') A "+
              				"FROM DUAL";
              	}else if(start!="" && end==""){
              		sql ="SELECT (SELECT COUNT(*) "+
              				"FROM IMPORT i, PRODUCTS p "+ 
              				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%' AND i.IMPORT_DATE >= '"+start+"') "+
              				"+(SELECT COUNT(*) "+
              				"FROM EXPORT e, PRODUCTS p "+ 
              				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
              				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%' AND E.EXPORT_DATE >= '"+start+"') A "+
              				"FROM DUAL";
               	}
            	pstmt = conn.prepareStatement(sql);
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
                    <p>기간별 재고 현황</p>
                </div>
              	<div id="subject">
                    <ul>
                        <li class="category" style="width: 10%">일자</li>
                        <li class="category" style="width: 5%">구분</li>
                        <li class="size" style="width: 10%">제품번호</li>
                        <li class="itemnum" style="width: 15%">카테고리</li>
                        <li class="itemname" style="width: 50%">제품명</li>
                        <li class="count" style="width: 10%">수량</li>
                    </ul>
               		<%
               		if(start=="" && end==""){
                  		sql ="(SELECT TO_CHAR(i.IMPORT_DATE,'yyyy-mm-dd') i_date,i.DIVISION, i.ITEM_NUM,p.CATEGORY ,p.ITEM_NAME ,i.IMPORT_QUANTITY  "+
                  				"FROM IMPORT i, PRODUCTS p "+ 
                  				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
                  				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%') "+
                  				"UNION ALL"+
                  				"(SELECT TO_CHAR(E.EXPORT_DATE,'YYYY-MM-DD') E_DATE, E.DIVISION, E.ITEM_NUM, P.CATEGORY, P.ITEM_NAME, E.EXPORT_QUANTITY   "+
                  				"FROM EXPORT e, PRODUCTS p "+
                  				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
                  						"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%') "+
                  				"OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROW ONLY";
                  	} else if(start!="" && end!=""){
                  		sql ="(SELECT TO_CHAR(i.IMPORT_DATE,'yyyy-mm-dd') i_date,i.DIVISION, i.ITEM_NUM,p.CATEGORY ,p.ITEM_NAME ,i.IMPORT_QUANTITY  "+
                  				"FROM IMPORT i, PRODUCTS p "+ 
                  				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
                  				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%' "+
                  				"AND I.IMPORT_DATE BETWEEN '"+start+"' AND '"+end+"') "+
                  				"UNION ALL"+
                  				"(SELECT TO_CHAR(E.EXPORT_DATE,'YYYY-MM-DD') E_DATE, E.DIVISION, E.ITEM_NUM, P.CATEGORY, P.ITEM_NAME, E.EXPORT_QUANTITY   "+
                  				"FROM EXPORT e, PRODUCTS p "+
                  				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
                  						"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%' "+
                  						"AND E.EXPORT_DATE BETWEEN '"+start+"' AND '"+end+"') "+
                  						"OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROW ONLY";
                  	} else if(start=="" && end!=""){
                  		sql ="(SELECT TO_CHAR(i.IMPORT_DATE,'yyyy-mm-dd') i_date,i.DIVISION, i.ITEM_NUM,p.CATEGORY ,p.ITEM_NAME ,i.IMPORT_QUANTITY  "+
                  				"FROM IMPORT i, PRODUCTS p "+ 
                  				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
                  				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%' "+
                  				"AND I.IMPORT_DATE <= '"+end+"') "+
                  				"UNION ALL"+
                  				"(SELECT TO_CHAR(E.EXPORT_DATE,'YYYY-MM-DD') E_DATE, E.DIVISION, E.ITEM_NUM, P.CATEGORY, P.ITEM_NAME, E.EXPORT_QUANTITY   "+
                  				"FROM EXPORT e, PRODUCTS p "+
                  				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
                  						"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%' "+
                  						"AND E.EXPORT_DATE <= '"+end+"') "+
                  						"OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROW ONLY";
                  	} else if(start!="" && end==""){
                  		sql ="(SELECT TO_CHAR(i.IMPORT_DATE,'yyyy-mm-dd') i_date,i.DIVISION, i.ITEM_NUM,p.CATEGORY ,p.ITEM_NAME ,i.IMPORT_QUANTITY  "+
                  				"FROM IMPORT i, PRODUCTS p "+ 
                  				"WHERE i.ITEM_NUM =p.ITEM_NUM "+
                  				"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND I.DIVISION LIKE '%"+itemdivision+"%' "+
                  				"AND I.IMPORT_DATE >= '"+start+"') "+
                  				"UNION ALL"+
                  				"(SELECT TO_CHAR(E.EXPORT_DATE,'YYYY-MM-DD') E_DATE, E.DIVISION, E.ITEM_NUM, P.CATEGORY, P.ITEM_NAME, E.EXPORT_QUANTITY   "+
                  				"FROM EXPORT e, PRODUCTS p "+
                  				"WHERE E.ITEM_NUM =P.ITEM_NUM "+
                  						"AND P.ITEM_NAME LIKE '%"+itemName+"%' AND P.CATEGORY LIKE '%"+itemCategory+"%' AND E.DIVISION LIKE '%"+itemdivision+"%' "+
                  						"AND E.EXPORT_DATE >= '"+start+"') "+
                  						"OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROW ONLY";
                   	}
               		
               		pstmt = conn.prepareStatement(sql);
      				rs=pstmt.executeQuery();
      				while(rs.next()){
      					%>
      					<ul>
	                        <li class="category" style="width: 10%"><%=rs.getString(1)%></li>
	                        <li class="category" style="width: 5%"><%=rs.getString(2)%></li>
	                        <li class="size" style="width: 10%"><%=rs.getString(3)%></li>
	                        <li class="itemnum" style="width: 15%"><%=rs.getString(4)%></li>
	                        <li class="itemname" style="width: 50%"><%=rs.getString(5)%></li>
	                        <li class="count" style="width: 10%"><%=rs.getInt(6)%></li>
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
		                      		<a class="pageNum pagebtn" href="inventory2.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&pagenum=<%=prev%>">이전</a>
		                      	</li> 
                           		<%
                           	}
                        %>  
                    	                       
                        <%
                        for(int i=firstNumber;i<=lastNumber;i++){
                    		if (i == Integer.parseInt(currentPage)) { 
                           		%>
                           		<li>
                        			<a class="pageNum" style="background-color: #8785A2; color: white;" href="inventory2.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&pagenum=<%=i%>"><%=i%></a>
                        		</li>
                           		<%
                            } else{
                            	%>
                                <li>
                        			<a class="pageNum" href="inventory2.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&itemdivision=<%=itemdivision%>&start=<%=start%>&end=<%=end%>&pagenum=<%=i%>"><%=i%></a>
                        		</li>		
                                <%
                            }
                    	}
                        %>  
                         
                       	<%
                           	if(pageGroup!=lastpageGroup && pageGroup!=1){
                           		%>
                           		<li>
		                       		<a class="pageNum pagebtn" href="inventory2.jsp?itemName=<%=itemName%>&itemCategory=<%=itemCategory%>&pagenum=<%=next%>">다음</a>
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
	    function startDateMethod(){
			var dateControl = document.getElementById("startDate").value;
			var itemDate = document.getElementById("start").value=dateControl;
		}
	    function endDateMethod(){
			var dateControl = document.getElementById("endDate").value;
			var itemDate = document.getElementById("end").value=dateControl;
		}
    
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