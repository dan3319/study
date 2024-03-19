<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/index.css">

<!-- 차트.js 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div id="container">
   <div id="content">
        <div id="lineChart">
            <div class="title">
                <select name="" id="years" onchange="yearChange()">
                    <c:forEach items="${year}" var="yearlist" varStatus="status">
                        <option value="${yearlist}" <c:if test='${status.last}'> selected </c:if>>${yearlist}</option>
                    </c:forEach>
                </select>
            <div id="total">총 원</div>
            <c:forEach items="${monthsum}" var="month">
                <input type="hidden" class="month" value="${month.division}">
                <input type="hidden" class="sum" value="${month.supply_price}">
            </c:forEach>
            <input type="hidden" id="yselect" value="<c:out value='${yearselect}' />">
            </div>
            <canvas id="myChart" width="1000px" height="600px"></canvas>
        </div>
    </div>
</div>

<script defer type="text/javascript" src="/resources/js/main.js"></script>
<script>
    document.title="메인페이지";
</script>

<%@ include file="../includes/footer.jsp" %>