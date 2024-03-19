<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="css/inventory.css">
<div id="container">
    <div id="content">
        <div id="top">
            <div id="searchForm">
                <div id="search">
                    <select name="selecttype" class="selectClass" id="selectId" onchange="tagSelect()">
                        <option disabled>==선택==</option>
                        <option>현재고</option>
                        <option selected>기간별재고</option>
                    </select>
                    <input type="text" name="itemName" class="textInput" id="selectItemName" placeholder="제품명 입력" value="">
                    <input type="button" value="검색" id="submitbtn" onclick="showReplyList(1)">
                </div>
                <div id="category2">
                    <ul>
                        <li><label class="labelText">카테고리</label><input type="text" name="itemCategory" class="textInput" id="itemCategory" placeholder="카테고리 입력" value=""></li>
                        <li>
                            <label class="labelText" style="margin-left: 20px">구분</label>
                            <label>전체</label>
                            <input type="radio" name="itemdivision" value="" checked>
                            <label>입고</label>
                            <input type="radio" name="itemdivision" value="입고">
                            <label>출고</label>
                            <input type="radio" name="itemdivision" value="출고">
                        </li>
                    </ul>
                    <ul style="margin-top: 20px">
                        <li>
                            <label class="labelText">기준날짜(시작)</label>
                            <input type="text" name="start" class="textInput" id="start" placeholder="날짜 입력" value="">
                            <input type="date" class="date" id="startDate" onchange="startDateMethod()">
                        </li>
                        <li>
                            <label class="labelText">기준날짜(종료)</label>
                            <input type="text" name="end" class="textInput" id="end" placeholder="날짜 입력" value="">
                            <input type="date" class="date" id="endDate" onchange="endDateMethod()">
                        </li>
                    </ul>
                </div>
            </div>
        </div>
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
                <div id="list">

                </div>

            </div>
            <div id="page"></div>
        </div>
    </div>
</div>


<%@ include file="../includes/footer.jsp" %>
<script type="text/javascript">
    var pagesize=10;

    var inventoryService = (function() {
    function getDateList(param,callback, error){
       var category = param.category || "010";
       var itemname = param.itemname || "010";
       var division = param.division || "010";
       var startDate = param.startDate || "010";
       var endDate = param.endDate || "010";
       var page = param.page || 1;

       $.getJSON("/search2/"+category+"/"+itemname+"/"+division+"/page/"+page+"/"+pagesize+"/date/"+startDate+"/"+endDate,

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

    function getSearchCount(param,callback, error){
       var category = param.category || "010";
       var itemname = param.itemname || "010";
       var division = param.division || "010";
       var startDate = param.startDate || "010";
       var endDate = param.endDate || "010";
       var page = param.page || 1;

       $.getJSON("/searchcount/"+category+"/"+itemname+"/"+division+"/date/"+startDate+"/"+endDate,

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

    return {
       getDateList:getDateList,
       getSearchCount:getSearchCount
    };
    })();

   var inventoryUL = $("#list");
   function showReplyList(pageNum) {
       var division = document.querySelector('input[name="itemdivision"]:checked').value;
       var category = document.getElementById('itemCategory').value;
       var selectItemName = document.getElementById('selectItemName').value;
       var startDate = document.getElementById("start").value;
       var endDate = document.getElementById("end").value;

       inventoryService.getDateList(
           { category: category,itemname:selectItemName,division:division, startDate:startDate, endDate:endDate ,page: pageNum || 1 },
           function(list) {

               if(list == null || list.length == 0){
                   inventoryUL.html("");
                   return;
               }

               var str = "";

               for(var i = 0, len = list.length || 0; i < len; i++) {
                   str += "<ul>";
                   str += "<li class='category' style='width: 10%'>"+list[i].import_date.substr(0,10)+"</li>";
                   str += "<li class='itemnum' style='width: 5%'>"+list[i].division+"</li>";
                   str += "<li class='itemnum' style='width: 10%'>"+list[i].item_num+"</li>";
                   str += "<li class='category' style='width: 15%'>"+list[i].category+"</li>";
                   str += "<li class='itemname' style='width: 50%'>"+list[i].item_name+"</li>";
                   str += "<li class='count' style='width: 10%'>"+list[i].import_quantity+"</li>";
                   str += "</ul>";
               }
               inventoryUL.html(str);
               listCount(division, category, selectItemName, startDate, endDate);
           }
       );
   }
   showReplyList(1);


   var lastScroll = 0;
   var inventoryPage = 2;


   function listCount(division, category, selectItemName, startDate, endDate) {
       inventoryService.getSearchCount(
           { category: category,itemname:selectItemName,division:division, startDate:startDate, endDate:endDate},
           function(list) {
                const inventoryMaxPageNum = Math.floor(list / pagesize)+1;

                $(document).scroll(function(e){
                    var currentScroll = $(this).scrollTop();
                    var documentHeight = $(document).height();

                    var nowHeight = $(this).scrollTop() + $(window).height();

                    if(currentScroll > lastScroll){
                        if((documentHeight < (nowHeight + (documentHeight * 0.1))) && inventoryPage <= inventoryMaxPageNum){
                            inventoryService.getDateList(
                               { category: category,itemname:selectItemName,division:division, startDate:startDate, endDate:endDate ,page: inventoryPage++ || 1 },
                               function(list) {

                                   var str = "";

                                   for(var i = 0, len = list.length || 0; i < len; i++) {
                                       str += "<ul>";
                                       str += "<li class='category' style='width: 10%'>"+list[i].import_date.substr(0,10)+"</li>";
                                       str += "<li class='itemnum' style='width: 5%'>"+list[i].division+"</li>";
                                       str += "<li class='itemnum' style='width: 10%'>"+list[i].item_num+"</li>";
                                       str += "<li class='category' style='width: 15%'>"+list[i].category+"</li>";
                                       str += "<li class='itemname' style='width: 50%'>"+list[i].item_name+"</li>";
                                       str += "<li class='count' style='width: 10%'>"+list[i].import_quantity+"</li>";
                                       str += "</ul>";
                                   }
                                   inventoryUL.append(str);
                               }
                            );
                        }
                    }
                    lastScroll = currentScroll;
                });
           }
       );
   }




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
            location.href='/inventory';
        } else if(optVal=="기간별재고"){
            location.href='/inventory2';
        }
    }
</script>