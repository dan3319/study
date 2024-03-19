<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/store.css">
<script type="text/javascript" src="/resources/js/jquery-3.7.1.min.js"></script>
<div class="container">
    <div class="content">
        <div id="info">
            <div id="title">
                <span>입출고 등록</span>
            </div>
            <div id="formInsert">
                <input type="hidden" name="type" value="타입">
                <ul class="subject">
                            <li class="line">
                                <div class="lab">구분</div>
                                <label for="import" class="choice">입고</label>
                                <input type="radio" id="import" name="info" value="입고" checked>
                                <label for="import" class="choice">출고</label>
                                <input type="radio" id="export" name="info" value="출고">
                            </li>
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
                    <input type="button" value="입력" id="sub" onclick="checkTest()">
                </div>
            </div>
        </div>
        <div id="search">
            <div class="searchText">

                <input type="text" name="itemNameSearch" id="itemSearchId" class="text" placeholder="제품명 입력" value="">
                <button id="searchbtn" onclick="itemSearch(1)">검색</button>
            </div>

            <div class="result">
                <div id="resultTable">
                    <table id="tableSelect">


                    </table>
                </div>
                <div id="page">
                    <ul id="pageNumber">

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
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
        //값 보내줄 구간
        var value = document.querySelector('input[name="info"]:checked').value;
        var itemDate = $('#item_date').val();
        var quantity = $('#quantity').val();
        var itemNum = $('#item_num').val();
        dataInsert(value, itemDate,quantity,itemNum);
    }

    function dataInsert(value, itemDate,quantity,itemNum){
        StoreService.add(
        {item_num:itemNum, import_date:itemDate, import_quantity:quantity, division:value},
        function(result){}
        );
        alert("입력되었습니다.");
        var itemDate = $('#item_date').val("");
        var quantity = $('#quantity').val("");
        document.getElementById('item_num2').innerHTML="";
        document.getElementById('item_name2').innerHTML="";
        document.getElementById('item_size2').innerHTML="";
        group();
    }

    function group(){
        StoreService.group(function(data){
            console.log(data);
        });
    }

    function itemSearch(pageNum){
        var item = document.getElementById('itemSearchId').value;
        var searchUL =$("#tableSelect");
        StoreService.getList(
                { search:item || "010", page:pageNum || 1 },
                function(list) {
                    if(list==null || list.length==0){
                        searchUL.html("");
                        return;
                    }
                    var str="";
                    str+="<tr class='resultCulum'>";
                    str+="<th class='resultRow resultTitle radio'>선택</th>";
                    str+="<th class='resultRow resultTitle type'>종류</th>";
                    str+="<th class='resultRow resultTitle name'>제품명</th>"
                    str+="<th class='resultRow resultTitle size'>사이즈</th>";
                    str+="</tr>";

                    for(var i=0, len= list.length || 0; i < len; i++) {
                        str+="<tr class='resultCulumn'>";
                        str+="<td class='resultRow selectRow'>"+list[i].item_num+"</td>";
                        str+="<td class='resultRow selectRow'>"+list[i].item_type+"</td>";
                        str+="<td class='resultRow selectRow'>"+list[i].item_name+"</td>";
                        str+="<td class='resultRow selectRow'>"+list[i].item_size+"</td>";
                        str+="</tr>";

                    }
                    searchUL.html(str);
                    var table = document.getElementById('tableSelect');
                    var rowList = table.rows;
                    rowClicked(rowList);
                    createPage(item, pageNum);
                }
            );
    }

    function createPage(item, pageNum){
        var pageUL =$("#pageNumber");


        StoreService.maxPage(
            { search:item || "010"},
            function(list) {
                if(pageNum<=0){
                    pageNum=1;
                }
                if(pageNum>list){
                    pageNum=list;
                }
                var str2="";
                str2+="<li><span class='pageNum pagebtn' onclick='itemSearch("+(pageNum-1)+")'>이전</span></li>";
                for(var i=0, len= list || 0; i < len; i++) {
                    if((i+1)==pageNum){
                        str2+="<li><span class='pageNum' style='background-color: #40A2D8' onclick='itemSearch("+(i+1)+")'>"+(i+1)+"</span></li>";
                    } else {
                        str2+="<li><span class='pageNum' onclick='itemSearch("+(i+1)+")'>"+(i+1)+"</span></li>";
                    }
                }
                str2+="<li><span class='pageNum pagebtn' onclick='itemSearch("+(pageNum+1)+")'>다음</span></li>";
                pageUL.html(str2);
            }
        );
    }

    var StoreService=(function(){

        function managementAdd(add,callback,error){
            $.ajax({
                type:'post',
                url:'/new',
                data:JSON.stringify(add),
                contentType:"application/json; charset=UTF-8",
                success:function(result,status,xhr){
                    if(callback){
                        callback(result);
                    }
                },
                error:function(xhr,status,er){
                    if(error){
                        error(er);
                    }
                }
            });
        }



        function getList(param, callback, error){
            var search = param.search || "";
            var page = param.page || 1;
            $.getJSON("/board/"+search+"/pageNum/"+page+"/pageSize/10",
                function(data){
                    if(callback){
                        callback(data);
                    }
            }).fail(function(xhr,status,err){
                if(error){
                    error();
                }
            });
        }



        function maxPage(param, callback, error){
            var search = param.search || "";
            $.getJSON("/"+search+"/pageSize/10",
                function(data){
                    if(callback){
                        callback(data);
                    }
            }).fail(function(xhr,status,err){
                if(error){
                    error();
                }
            });
        }

        function group(callback,error){
            $.get("/group",
            function(result){
                if(callback){
                    callback(result);
                }
            }).fail(function(xhr,status,err){
                if(error){
                    error();
                }
            });
        }

        return{
            getList:getList,
            maxPage:maxPage,
            add:managementAdd,
            group:group
        };
    })();

        function dateMethod() {
            var dateControl = document.querySelector('input[type="date"]').value;
            var itemDate = document.getElementById("item_date").value=dateControl;
        }

        function rowClicked(rowList) {
                for(i=1;i<rowList.length;i++){
                    var row = rowList[i];

                    row.onclick = function () {
                        return function () {
                                var num = this.cells[0].innerHTML;
                                var name =this.cells[2].innerHTML;
                                var size = this.cells[3].innerHTML;
                                document.getElementById('item_num').value=num;
                                document.getElementById('item_num2').innerHTML=num;
                                document.getElementById('item_name').value=name;
                                document.getElementById('item_name2').innerHTML=name;
                                document.getElementById('item_size').value=size;
                                document.getElementById('item_size2').innerHTML=size;
                        };
                    }(row);
                }
            }

</script>
<%@ include file="../includes/footer.jsp" %>