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
    <link rel="stylesheet" href="css/store.css">
    <link rel="icon" href="./image/favicon.ico" />
    <script type="text/javascript" src="./js/jquery-3.7.1.min.js"></script>
    <title>의류 생산 시스템:입고</title>
</head>
<body>
    <div class="container">
    <%@ include file="login_header.jsp" %>
        <div class="content">
            <div id="info">
                <div id="title">
                    <span>입출고 등록</span>
                </div>
                <%
                Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
                
                String type = request.getParameter("selecttype");
                String num = request.getParameter("num");
                String itemSearch = request.getParameter("itemSearch");
                
                if(num==null){
                	num="0";
                }
                
                if(type==null){
                	type="item";
                }
                if(itemSearch==null){
                	itemSearch="";
                }
				
				try{
					conn=DBConfig.getConnection();
					
                %>
                
                
                
                <form action="storeInsert.jsp" id="formInsert" method="get" onsubmit="return false">
                	<input type="hidden" name="type" value="<%=type%>">
                    <ul class="subject">
                    	<%
                    		if(type.equals("item")){
                    			%>
                    			<li class="line">
			                        <div class="lab">구분</div>
			                        <label for="import" class="choice">입고</label>
			                        <input type="radio" id="import" name="info" value="import" checked>
			                        <label for="import" class="choice">출고</label>
			                        <input type="radio" id="export" name="info" value="export">
		                        </li>
                    			<%
                    		}
                    	%>
                        <li class="line">
	                        <div class="lab">입고일</div>
	                        <input type="text" name="date" class="text" id="item_date" placeholder="날짜 입력">
	                        <input type="date" id="date" onchange="dateMethod()">
                        </li>
                        <li class="line">
	                        <div class="lab">수량</div>
	                        <input type="text" name="itemcount" class="text" id="quantity" placeholder="수량 입력">
                        </li>
                        <li class="line">
	                        <div class="lab">제품 번호</div>
	                        <input type="hidden" name="itemnum" class="text" id="item_num" placeholder="제품 번호 입력">
	                        <div id="item_num2" class="subjectbox"></div>
                        </li>
                        <li class="line">
	                        <div class="lab">제품명</div>
	                        <input type="hidden" name="itemname" class="text" id="item_name" placeholder="제품명 입력">
	                        <div id="item_name2" class="subjectbox"></div>
                        </li>
                        <li class="line">
	                        <div class="lab">사이즈</div>
	                        <input type="hidden" name="itemsize" class="text" id="item_size" placeholder="사이즈 입력">
	                        <div id="item_size2" class="subjectbox"></div>
                        </li>
                    </ul>
                    <div id="ok">
                        <input type="submit" value="입력" id="sub" onclick="checkTest()">
                    </div>
                </form>
            </div>
            
            
            <%
	          	//페이징 처리
	            String currentPage=request.getParameter("pagenum");
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
            
	            if(currentPage==null){
	    			currentPage="1";
	    		}
            %>
            
            <div id="search">
                <div class="searchText">
                	<select name="" id="searchselect" onchange="selectType()">
                	<% 
                		if(type.equals("item")){
                			%>
                        	<option value="item" selected>제품</option>
                        	<option value="order">주문 의뢰서</option>
                			<%
                		}else if(type.equals("order")){
                			%>
                        	<option value="item">제품</option>
                        	<option value="order" selected>주문 의뢰서</option>
                			<%
                		}else{
                			%>
                        	<option value="item">제품</option>
                        	<option value="order">주문 의뢰서</option>
                			<%
                		}
                		
                		
                	%>
                	</select>
                    <input type="text" name="itemNameSearch" id="itemSearchId" class="text" placeholder="제품명 입력" value="<%=itemSearch%>">
                    <button id="searchbtn" onclick="itemSearch()">검색</button>
                </div>

                <div class="result">
                    <div id="resultTable">
                        <table id="tableSelect">
                            <tr class="resultCulum">
                               <%
                               		if(type.equals("item")){
                               			String sql2 = "SELECT count(*) FROM products  WHERE ITEM_NAME LIKE '%"+itemSearch+"%'";
                            			pstmt = conn.prepareStatement(sql2);
                            			rs = pstmt.executeQuery();
                            			if(rs.next()){
                            				totalCount+=rs.getInt(1);
                            			}
                               			%>
                               				<th class="resultRow resultTitle radio">선택</th>
		                                	<th class="resultRow resultTitle type">종류</th>
		                                	<th class="resultRow resultTitle name">제품명</th>
		                                	<th class="resultRow resultTitle size">사이즈</th>
                               			<%
                               		}else if(type.equals("order")){
                               			String sql = "SELECT count(*) FROM order_product  WHERE ITEM_NAME LIKE '%"+itemSearch+"%'";
                            			pstmt = conn.prepareStatement(sql);
                            			rs = pstmt.executeQuery();
                            			if(rs.next()){
                            				totalCount+=rs.getInt(1);
                            			}
                               			%>
                               				<th class="resultRow resultTitle radio">선택</th>
                                			<th class="resultRow resultTitle type">종류</th>
                                			<th class="resultRow resultTitle name">제품명</th>
                                			<th class="resultRow resultTitle size">사이즈</th>
                                			<th class="resultRow resultTitle">수량</th>
                               			<%
                               		}
                               %>
                               <%
                               totalPage = (int)(totalCount/limit);
	                       		if(totalCount%limit>0){
	                       			totalPage+=1;
	                       		}
	                       		
	                       		if(totalPage<Integer.parseInt(currentPage)){
	                       			currentPage=Integer.toString(totalPage);
	                       		}
	                       		
	                       		pageGroup=Integer.valueOf(currentPage)/pageCount;
	                       		lastpageGroup=totalPage/pageCount;
	                       		
	                       		if(pageGroup==0){
	                       			pageGroup++;
	                       		}
	                       		
	                       		if(lastpageGroup==0){
	                       			lastpageGroup++;
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
	                       		
	                       		int count = Integer.parseInt(currentPage)-1;
	                       		row = limit*count;
                               %>
                            </tr>
                            <%
									if(type.equals("item")){
										String sql = "SELECT item_num, item_type, item_name, item_size  FROM products  WHERE ITEM_NAME LIKE '%"+itemSearch+"%' order by item_num OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROWS ONLY";
										pstmt = conn.prepareStatement(sql);
										
										rs = pstmt.executeQuery();

										while(rs.next()){

											%>
												<tr class="resultCulumn">
					                                <td class="resultRow selectRow"><%=rs.getString(1) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(2) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(3) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(4) %></td>
					                            </tr>
											<%
										}
									} else if(type.equals("order")){
										String sql2 = "SELECT order_num, item_type, item_name, item_size,quantity FROM order_product  WHERE ITEM_NAME LIKE '%"+itemSearch+"%' order by ORDER_NUM OFFSET "+row+" ROWS FETCH NEXT "+limit+" ROWS ONLY";
										pstmt = conn.prepareStatement(sql2);
										
										rs = pstmt.executeQuery();

										while(rs.next()){

											%>
												<tr class="resultCulumn">
					                                <td class="resultRow selectRow"><%=rs.getString(1) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(2) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(3) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(4) %></td>
					                                <td class="resultRow selectRow"><%=rs.getString(5) %></td>
					                            </tr>
											<%
										}
									}
									
								
        					%>
                            
                        </table>
                    </div>
                    <div id="page">
                        <ul>
                            <%
                            	if(pageGroup!=1){
                            		%>
                            		<li><a class="pageNum pagebtn" href="store.jsp?selecttype=<%=type%>&itemSearch=<%=itemSearch%>&pagenum=<%=prev%>">이전</a></li>
                            		<%
                            	}
                            %>
                        
                            <%
                            	for(int i=firstNumber;i<=lastNumber;i++){
                            		if (i == Integer.parseInt(currentPage)) { 
                            		%>
                            		<li>
                            			<a class="pageNum" href="store.jsp?selecttype=<%=type%>&itemSearch=<%=itemSearch%>&pagenum=<%=i%>" style="background-color: #40A2D8"><%=i%></a>
                            		</li>
                            		<%
                            		} else{
                            			%>
                                		<li>
                                			<a class="pageNum" href="store.jsp?selecttype=<%=type%>&itemSearch=<%=itemSearch%>&pagenum=<%=i%>"><%=i%></a>
                                		</li>
                                		<%
                            		}
                            	}
                            %>
                            <%
                            	if(pageGroup!=lastpageGroup && pageGroup !=1){
                            		%>
                            			<li><a class="pageNum pagebtn" href="store.jsp?selecttype=<%=type%>&itemSearch=<%=itemSearch%>&pagenum=<%=next%>">다음</a></li>
                            		<%
                            	}
                            %> 
                        </ul>
                    </div>
                    <%
						}catch(SQLException e){
							System.out.println("에러 로그:"+e.getMessage());
						}
                    %>
                </div>
            </div>
        </div>
    </div>
     <%@ include file="footer.jsp" %>
    <script type="text/javascript">
    	function selectType(){
    		var opt = document.getElementById("searchselect");
            var optVal = opt.options[opt.selectedIndex].value;
            location.href='store.jsp?selecttype='+optVal;
    	}
    
    	function dateMethod() {
			var dateControl = document.querySelector('input[type="date"]').value;
			var itemDate = document.getElementById("item_date").value=dateControl;
		}
    	
    	function itemSearch() {
			var itemSearchId = document.getElementById("itemSearchId").value;
			var opt = document.getElementById("searchselect");
            var optVal = opt.options[opt.selectedIndex].value;
            
			location.href='store.jsp?itemSearch='+itemSearchId+'&selecttype='+optVal;
		}
    	
    	function rowClicked() {
    		var opt = document.getElementById("searchselect");
            var optVal = opt.options[opt.selectedIndex].value;
            
    		var table = document.getElementById('tableSelect');
    		var rowList = table.rows;
    		
    		for(i=1;i<rowList.length;i++){
    			var row = rowList[i];
    			
    			row.onclick = function () {
					return function () {
						if(optVal=="item"){
							var num = this.cells[0].innerHTML;
							var name =this.cells[2].innerHTML;
							var size = this.cells[3].innerHTML;
							
							document.getElementById('item_num').value=num;
							document.getElementById('item_num2').innerHTML=num;
							document.getElementById('item_name').value=name;
							document.getElementById('item_name2').innerHTML=name;
							document.getElementById('item_size').value=size;
							document.getElementById('item_size2').innerHTML=size;
						} else if(optVal=="order"){
							var num = this.cells[0].innerHTML;
							var name =this.cells[2].innerHTML;
							var size = this.cells[3].innerHTML;
							var quantity= this.cells[4].innerHTML;
							
							document.getElementById('item_num').value=num;
							document.getElementById('item_num2').innerHTML=num;
							document.getElementById('item_name').value=name;
							document.getElementById('item_name2').innerHTML=name;
							document.getElementById('item_size').value=size;
							document.getElementById('item_size2').innerHTML=size;
							
							document.getElementById('quantity').value=quantity;
						}
						
					};
				}(row);
    		}
		}
    	window.onload = rowClicked();
    	
    	function checkTest() {
    		if(!$('#item_date').val()){
    			alert('날짜를 입력하세요.');
    			$('#item_date').focus();
    			
    			return;
    		}
    		
    		if(!$('#quantity').val()){
    			alert('수량을 입력하세요.');
    			$('#quantity').focus();
    			
    			return;
    		}
    		if(!$('#item_num').val()){
    			alert('상품을 선택하세요.');
    			$('#item_num').focus();
    			
    			return;
    		}
    		document.getElementById('formInsert').submit();
		}
    </script>
</body>
</html>