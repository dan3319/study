<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/inventory.css">
<script type="text/javascript" src="/resources/js/jquery-3.7.1.min.js"></script>
<div id="container">
    <div id="content">
        <div id="top">
            <div id="searchForm">
                <div id="search">
                    <select name="selecttype" class="selectClass" id="selectId" onchange="tagSelect()">
                        <option disabled>==선택==</option>
                        <option selected>현재고</option>
                        <option>기간별재고</option>
                    </select>
                    <input type="text" name="itemName" class="textInput" id="selectItemName" placeholder="제품명 입력" value="">
                    <input type="button" value="검색" id="submitbtn" onclick="showReplyList(1)">
                </div>
        <div id="category">
                <ul>
                    <li><label for="" class="labelText">카테고리</label><input type="text" name="itemCategory" class="textInput" id="itemCategory" placeholder="카테고리 입력" value=""></li>
                    <li>
                        <label for="" class="labelText">사이즈</label>
                        <select class="selectClass" name="itemSize" id="itemSize">
                                <option selected value="i">- 선택 -</option>
                            <c:forEach items="${size}" var="size">
                                <option value="${size}">${size}</option>
                            </c:forEach>
                        </select>
                    </li>
                </ul>
            </div>
            </div>
        </div>
        <div id="bottom">
                <div id="title">
                    <p onclick="">현 재고 현황</p>
                </div>
            <div id="subject">
                <ul>
                    <li class="category" style="width: 10%">카테고리</li>
                    <li class="itemnum" style="width: 10%">제품번호</li>
                    <li class="itemname" style="width: 60%">제품명</li>
                    <li class="size" style="width: 5%">사이즈</li>
                    <li class="count" style="width: 15%">재고량</li>
                </ul>
                <div id="list">

                </div>
            </div>
            <div id="page"></div>
        </div>
    </div>
</div>

<script>
    function tagSelect() {
        var opt = document.getElementById("selectId");
        var optVal = opt.options[opt.selectedIndex].text;
        if(optVal=="현재고"){
            location.href='/inventory';
        } else if(optVal=="기간별재고"){
            location.href='/inventory2';
        }
    }
    var inventoryService = (function() {
    function getList(param, callback, error){
       var category = param.category || "010";
       var itemname = param.itemname || "010";
       var itemsize = param.itemsize || "010";
       var page = param.page || 1;
       $.getJSON("/search/"+category+"/"+itemname+"/"+itemsize+"/page/"+page+"/pagesize/10",

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
       getList:getList
    };
    })();



   var inventoryUL = $("#list");
   function showReplyList(pageNum) {
       var size = document.getElementById('itemSize').value;
       var category = document.getElementById('itemCategory').value;
       var selectItemName = document.getElementById('selectItemName').value;
       if(size=="i"){
            size="";
       }
       inventoryService.getList(
           { category: category,itemname:selectItemName,itemsize:size, page: pageNum || 1 },
           function(list) {

               if(list == null || list.length == 0){
                   inventoryUL.html("");
                   return;
               }

               var str = "";

               for(var i = 0, len = list.length || 0; i < len; i++) {
                   str += "<ul>";
                   str += "<li class='category' style='width: 10%'>"+list[i].category+"</li>";
                   str += "<li class='itemnum' style='width: 10%'>"+list[i].item_num+"</li>";
                   str += "<li class='itemname' style='width: 60%'>"+list[i].item_name+"</li>";
                   str += "<li class='size' style='width: 5%'>"+list[i].item_size+"</li>";
                   str += "<li class='count' style='width: 15%'>"+list[i].quantity+"</li>";
                   str += "</ul>";
               }
               inventoryUL.html(str);
           }
       );
   }
   showReplyList(1);


</script>
<%@ include file="../includes/footer.jsp" %>