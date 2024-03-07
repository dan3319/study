<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.DBConfig"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 차트.js 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script defer type="text/javascript" src="js/chart.js"></script>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/index.css">
<link rel="icon" href="./image/favicon.ico" />
<link >
<title>의류 생산 관리 시스템</title>
</head>
<body>
<%@ include file="login_header.jsp" %>
	 <div id="container">
        <div id="content">
            <div id="lineChart">
            <%
            LocalDate now = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
            String formnow = now.format(formatter);
            
            
            String year = request.getParameter("year");
            if(year==null){
            	year=formnow;
            }
            Connection conn = null;
    		PreparedStatement pstmt = null; 
    		ResultSet rs = null;
    		
    		int totalSales = 0;
            %>
                <div class="title">
                	<select name="" id="years" onchange="yearChange()">
                <%
        		try{
        			conn=DBConfig.getConnection();
        			
        			String sql = "SELECT TO_CHAR(MIN(IMPORT_DATE),'YYYY'), TO_CHAR(SYSDATE,'YYYY')  FROM IMPORT i";
       				pstmt = conn.prepareStatement(sql);
       				rs=pstmt.executeQuery();
       				
       				int minYear =0;
       				int maxYear =0;
       				
       				if(rs.next()){
       					minYear = Integer.parseInt(rs.getString(1));
       					maxYear = Integer.parseInt(rs.getString(2));
       				}
       					while(minYear<=maxYear){
       							if(Integer.parseInt(year)==minYear){
   									%>
               						<option value="<%=minYear%>" selected><%=minYear%></option>
               						<%
   								} else{
   									%>
               						<option value="<%=minYear%>"><%=minYear%></option>
               						<%
   								}
       						minYear++;
       					}
       			%>
       				</select>
       			
       				<%
       				sql = "SELECT SUBSTR(EXDATE,6,8) SEARCHDATE, SUM(SALES) "+
       						"FROM "+
       						"(SELECT E.ITEM_NUM, TO_CHAR(EXPORT_DATE,'YYYY-MM') EXDATE,SUM(EXPORT_QUANTITY*PRICE)-SUM(EXPORT_QUANTITY *A.VAT) sales "+
       						"FROM EXPORT e, (SELECT ITEM_NUM, SUPPLY_PRICE+VAT VAT FROM IMPORT i GROUP BY ITEM_NUM,(SUPPLY_PRICE+VAT))A "+
       						"WHERE TO_CHAR(e.EXPORT_DATE,'YYYY')='"+year+"' AND E.ITEM_NUM =A.ITEM_NUM "+
       						"GROUP BY E.ITEM_NUM,TO_CHAR(EXPORT_DATE,'YYYY-MM')) "+
       						"GROUP BY EXDATE "+
       						"ORDER BY SEARCHDATE ";
       				pstmt = conn.prepareStatement(sql);
       				rs=pstmt.executeQuery();
       				int month=0;
       				int array[]=new int[12];
       				
       				
       				System.out.println();
       				while(rs.next()){
       					month=Integer.parseInt(rs.getString(1));
       					for(int i=1;i<=12;i++){
       						if(i==month){
       							array[i-1]=month;
       							totalSales+=rs.getInt(2);
       							%>
       							<input type="hidden" id="month<%=i%>" value="<%=rs.getInt(2)%>">
       							<%
       						}
       					}
       				}
       				
       				for(int i=1;i<=12;i++){
       					if(array[i-1]!=i){
       						%>
								<input type="hidden" id="month<%=i%>" value="0">
							<%
       					}
       				}
        		}catch(Exception e){
        			
        		}
                %>
                <div id="total">총 <%=String.format("%,d",totalSales)%>원</div>
                </div>
                <canvas id="myChart" width="1000px" height="600px"></canvas>
            </div>
        </div>
    </div>
  <%@ include file="footer.jsp" %>
    <script>
        const ctx = document.getElementById('myChart');
        var opt = document.getElementById("years");
        var optVal = opt.options[opt.selectedIndex].value;

        
        
        function yearChange() {
        	var optVal = opt.options[opt.selectedIndex].value;
            location.href='main.jsp?year='+optVal;
		}
        
        var jan = document.getElementById("month1").value;
        var feb = document.getElementById("month2").value;
        var mar = document.getElementById("month3").value;
        var apr = document.getElementById("month4").value;
        var may = document.getElementById("month5").value;
        var jun = document.getElementById("month6").value;
        var jul = document.getElementById("month7").value;
        var aug = document.getElementById("month8").value;
        var sep = document.getElementById("month9").value;
        var oct = document.getElementById("month10").value;
        var nov = document.getElementById("month11").value;
        var dec = document.getElementById("month12").value;
        
        new Chart(ctx, {
          type: 'line',
          data: {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            datasets: [{
              label: optVal,
              data: [jan, feb, mar, apr, may, jun,jul,aug,sep,oct,nov,dec],
              borderWidth: 1,
              borderColor: 'red',
              backgroundColor:'#9BD0F5',
              fill:{
            	  target:'origin'
              }
            }]
          },
          options: {
            responsive:true,
            plugins: {
              title: {
                  display: true,
                  text: '순매출 수익',
                  font:{
                    size:30,
                    family:'TTHakgyoansimMoheomgaB'
                  }
              }
            },
            scales:{
            	x:{
            		display:true,
            		title:{
            			display:true,
            			text:'매월',
            			font:{
            				size:20,
            				family:'TTHakgyoansimMoheomgaB'
            			}
            		},
            	},
            	y:{
            		display:true,
            		title:{
            			display:true,
            			text:'매출수익',
            			font:{
            				size:20,
            				family:'TTHakgyoansimMoheomgaB'
            			}
            		},
            	}
            },
            transitions:{
            	show:{
            		animations:{
            			x:{
            				from:0
            			}
            		}
            	},
            	hide:{
            		animations:{
            			x:{
            				to:0
            			}
            		}
            	}
            }
          }
        });   
      </script>
</body>
</html>