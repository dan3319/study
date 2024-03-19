<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.lang.Exception, java.sql.SQLException"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<%@ include file="../includes/header.jsp" %>
<!-- 스타일 시트 -->
<link rel="stylesheet" href="/resources/css/orderList.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!-- 스크립트 -->
<script defer src="/resources/js/order.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


<div class="inner">
	<!-- 검색어 입력 -->
	<div class="top">
		<!-- 제품 이름 검색 -->
		<div class="serach-product">
			<form id='searchForm' action='./orderList' method='get'>
				<input type="date" class="datepicker" name="startDt" id="startDt">
				~ <input type="date" class="datepicker" name="endDt" id="endDt">
				<select name='type' />
				<option value="">선택</option>
				<option value="W"
					<c:out value="${criteria.type == 'W' ? 'selected' : ''}" />>작성자</option>
				<option value="O"
					<c:if test="${criteria.type == 'O'}">selected</c:if>>의뢰처</option>
				<option value="N"
					<c:out value="${criteria.type == 'N' ? 'selected' : ''}" />>제품</option>
				</select> <input type='text' name='keyword' value="" />
				<%-- <input type='hidden' name='pageNum' />
					<input type='hidden' name='amount' /> --%>
				<button id="search">GO</button>
			</form>
		</div>

		<span class="material-symbols-outlined" id="help">help</span>
		<div class="tip">
			<div>tip</div>
			<div>- 제품이름으로 검색할 수 있어요!</div>
			<div>- 주문번호,일자, 제품이름으로 의뢰서를 확인 및 수정 할 수 있어요.</div>
			<div>- 각 주문된 상태를 더블클릭해보세요!</div>
		</div>
	</div>

	<div class="wrapper">
		<div class="header">관리자 주문 목록</div>


		<div class="content-name">
			<div class="content_no">주문번호</div>
			<div>상태</div>
			<div>주문일자</div>
			<div>제품 이름</div>
			<div>주문수량</div>
			<div class="delete">삭제</div>
		</div>

		<c:forEach items="${orderVOList}" var="order">
			<div class="content-box">
				<div>
					<div class="content_no">
						<a
							href='./orderProductUpdateForm?num=<c:out value="${order.num}" />'
							style="color: black;"><c:out value="${order.num}" /></a>
					</div>
					<div class="status">
						<c:out value="${order.status}" />
					</div>
					<div class="content_date">
						<a
							href='./orderProductUpdateForm?num=<c:out value="${order.num}" />'
							style="color: black;"><c:out value="${order.date}" /></a>
					</div>
					<div class="content_name">
						<a
							href='./orderProductUpdateForm?num=<c:out value="${order.num}" />'
							style="color: black;"><c:out value="${order.name}" /></a>
					</div>
					<div class="quantity">
						<c:out value="${order.quantity}" />
					</div>
					<div class="delete">
						<button style="cursor: pointer; font-size: 10px;"
							onClick='javascript: noticeDelete(<c:out value="${order.num}" />);'>X</button>
					</div>

					<div class="requester" style="display: none">
						<c:out value="${order.requester}" />
					</div>
					<div class="ordernum" style="display: none">
						<c:out value="${order.num}" />
					</div>
				</div>
			</div>
		</c:forEach>


		<!-- 1-3. 글쓰기 버튼은 class="btn"로 <div>로 구역 설정 -->
		<div class="btn">
			<a href="/orderProductInsertForm">주문하기</a>
		</div>

		<!-- 페이지네이션 -->
		<ul class="pagination">
			<!-- 처음 버튼 -->
			<!-- <li class="paginate_button previous"><a href="#" style="color: black;">Previous</a></li> -->

			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li
					class='paginate_button ${pageMaker.cri.pageNum == num ? "active":""} '>
					<a
					href="/orderList?startDt=<c:out value= "${criteria.startDt}" />&endtDt=<c:out value= "${criteria.endDt}" />&type=<c:out value= "${criteria.type}" />&keyword=<c:out value= "${criteria.keyword}" />&pageNum=<c:out value= "${num}" />"
					style="color: black;">${num}</a>
				</li>
			</c:forEach>

			<!-- <li class="pagination_button next"><a href="#" style="color: black;">Next</a></li> -->
		</ul>

		<form id='actionForm' action="./orderList" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		</form>

	</div>
</div>

<!-- comments -->

<nav id="nav">
	<div class="wrap">
		<div class="orderInfo">
			<div class="status-info">
				<form action="./updateStatus" method="post" id="form1">
					<div>
						진행상태: <select name="status" id="status">
							<option value="진행중">진행중</option>
							<option value="완료">완료</option>
							<option value="중지">중지</option>
						</select>
						<div class="tip">tip 진행상태를 클릭해 변경할 수 있어요!</div>
					</div>

					<input type="text" name="num" id="num" value=""
						style="display: none;" />
					<button type="submit" value="update">
						<span class="material-symbols-outlined">done </span>
					</button>
				</form>
				<div class="requester">
					작성자 <input type="text" name="requester" id="requester" value=""
						readonly="readonly" />
				</div>
			</div>
		</div>


		<div class="content-info">
			<div class="content">내용 follow-up</div>
			<div class="commenter">작성자</div>
			<div class="comment_date">시간</div>
			<div class="ftip">tip 주문처리 현황을 볼 수 있어요!</div>
		</div>


		<c:forEach items="${replyVOList}" var="reply">
			<div class="content-info-box">
				<div>
					<div class="ordernum" style="display: none;">
						<c:out value="${reply.num}" />
					</div>
					<div class="content">
						<c:out value="${reply.content}" />
					</div>
					<div class="commenter">
						<c:out value="${reply.commenter}" />
					</div>
					<fmt:parseDate var="formattedDate" value="${reply.date}"
						pattern="yyyy-MM-dd HH:mm:ss" />
					<div class="comment_date">
						<fmt:formatDate value="${formattedDate}" pattern="yyyy-MM-dd" />
					</div>
				</div>
			</div>
		</c:forEach>


		<div class="follow-wrap">
			<form action="./commentInsert" method="post" id="form2"
				onSubmit="return false">
				<div class="followup">
					<div class="followup-right">
						<div class="ordernum">
							주문번호 <input type="text" name="num" id="num2"
								style="width: 80px; height: 25px;">
						</div>
						<div class="commenter">
							작성자 <input type="text" name="commenter" id="commenter"
								style="width: 100px; height: 25px;">
						</div>
						<button type="submit" value="" class="ok" id="ok"
							onClick='javascript:prevOkTextBox();'>OK</button>
					</div>
					<div class="content">
						<textarea name="content" id="content" cols="61" rows="5"
							placeholder="15자 내외로 입력해주세요."></textarea>
					</div>
				</div>
			</form>
		</div>
		<div>
			<span id="toggleButton" class="material-symbols-outlined">keyboard_tab_rtl</span>
		</div>
	</div>
</nav>

<%@ include file="../includes/footer.jsp" %>


<script> 
    document.title="주문 목록";
	var searchForm = $("#searchForm");
	$("#searchForm span").on("click",
		function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}
	
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			//searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
	
			searchForm.submit();
		});
	 
	 
	function noticeDelete(noticeNum) {
	    Swal.fire({
		title: '글을 삭제하시겠습니까???',
		text: "삭제후 다시 복구시킬 수 없습니다.",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '삭제',
		cancelButtonText: '취소'
	    }).then((result) => {
		if (result.isConfirmed) {
		    // "삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 됩니다.
		    var newForm = $('<form name="newForm" method="post" action="/orderProductDelete"></form>');
		    newForm.append($('<input/>', { type: 'hidden', name: 'num', value: noticeNum }));
		    newForm.appendTo('body');

		    // submit form
		    newForm.submit();
		}
	    });
	}
	
	function checkAllFields() {
	    return ($('#num').val() && $('#commenter').val() && $('#content').val());
	}

	function prevOkTextBox() {
	   //console.log($('#num').val());
	
	     if (!checkAllFields()) {
			Swal.fire({
			    title: '입력 오류',
			    text: '모든 정보를 입력하세요.',
			    icon: 'error',
			    confirmButtonColor: '#48088A'
			});
			return;
		    }
	
		 // 사용자가 등록을 원하는지 확인하는 창 표시 
	       Swal.fire({
		  title: '정말 게시하겠습니까?',
		 text: '게시후 삭제할 수 없습니다.',
		 icon: 'warning',
		
		 showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		 confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		 cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		 confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		 cancelButtonText: '취소', // cancel 버튼 텍스트 지정                      
		 reverseButtons: true, // 버튼 순서 거꾸로
		
	   }).then(result => {
	      if (result.isConfirmed) {
		  Swal.fire('게시가 완료되었습니다.', '', 'success');
		  setTimeout(function() {
		      document.getElementById('form2').submit();
		  }, 2000); // 2초 후에 폼 제출
	      }else if (result.isDismissed) { // 만약 모달창에서 cancel 버튼을 눌렀다면
		  Swal.fire('게시가 취소되었습니다.', '', 'info');
	       }
	   });
	
	} 	





var actionForm = $("#actionForm"); 	
	$(".pagenate_button a").on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).text()); 
		actionForm.submit();
	});


</script>
<%
// 캐시 만료를 통한 뒤로가기 방지
response.setHeader("Expires", "Thu, 27 Jul 2023 09:00:00 GMT"); // 현재시각보다 이전으로만 만료시간을 설정
response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, post-check=0, pre-check=0"); // str 로 "" 으로 넣는것보단, 상수형으로 넣어주는게 좋다.
response.setHeader("Pragma", "no-cache");
%>