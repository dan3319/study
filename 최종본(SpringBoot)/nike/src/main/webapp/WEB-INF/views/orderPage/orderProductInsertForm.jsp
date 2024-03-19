<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<%@ include file="../includes/header.jsp" %>
<!-- 스타일 시트 -->
<link rel="stylesheet" href="/resources/css/orderProduct.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css">
<!-- 스크립트 -->
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

	<div class="inner">
		<!-- 검색어 입력 -->
		<div class="top">
			<div class="serach-bar">
				<a href="./orderList"> <span class="material-symbols-outlined">
						arrow_back </span></a>
				<h2>주문 목록</h2>
			</div>
		</div>
		<!-- 주문내용 -->
		<div class="wrapper">
			<div class="title">
				<h2>주문 의뢰서</h2>
			</div>

			<!-- 폼 구현 -->
			<form action="./orderProductInsert" method="post" id="form1"
				onSubmit="return false" enctype="multipart/form-data">
				<div class="wrapper-content">
					<!--이미지 업로더-->
					<div class="firstline">
						<div class="img-file">
							<input type="file" class="btn file-input" name="fileContent"
								id="fileContent"> <label class="img-file-label"
								for="img-file" style="width: 30px"></label>
						</div>
						<div class="requester">
							작성자: <input type="text" name="requester" id="requester">
						</div>
					</div>


					<div class="item primary-info">
						<div class="brand-name">
							브랜드: <input type="text" name="brand" id="brand">
						</div>
						<div class="item-type">
							종류: <select name="type" id="type">
								<option value="none" selected>=== 선택 ===</option>
								<option value="셔츠">셔츠</option>
								<option value="긴팔">긴팔</option>
								<option value="반팔">반팔</option>
								<option value="후디">후디</option>
								<option value="폴로">폴로</option>
							</select>
						</div>
						<div class="order-place">
							의뢰처: <input type="text" name="place" id="place" placeholder="">
						</div>
					</div>

					<div class="item second-info">
						<div class="itemname">
							제품 이름: <input type="text" name="name" id="name" placeholder="">
						</div>
						<div class="item-size">
							사이즈: <select name="size" id="size">
								<option value="none" selected>=== 선택 ===</option>
								<option value="xs">XS</option>
								<option value="s">S</option>
								<option value="m">M</option>
								<option value="l">L</option>
								<option value="xl">XL</option>
							</select>
						</div>
						<div class="quantity">
							주문수량: <input type="number" name="quantity" id="quantity">
						</div>
					</div>

					<div class="item last-info">
						<div>
							가슴: <input type="number" name="chest" id="chest" placeholder="cm">
						</div>
						<div>
							총장: <input type="number" name="front" id="front" placeholder="cm">
						</div>
						<div>
							소매길이: <input type="number" name="sleeve" id="sleeve"
								placeholder="cm">
						</div>
						<div>
							어깨단면: <input type="number" name="back" id="back" placeholder="cm">
						</div>
						<div>
							소매단면: <input type="number" name="arm" id="arm" placeholder="cm">
						</div>
					</div>

					<div class="comment">
						<div class="item-request">
							<div class="comment-text">작업시 요청사항(100자 내외):</div>
							<textarea name="requirements" id="requirements" cols="30"
								rows="10"></textarea>
						</div>
						<div class="product-details">
							<div class="comment-text">옷 소재(100자 내외):</div>
							<textarea name="details" id="details" cols="30" rows="10"></textarea>
						</div>
					</div>
					<div class="submit-button">
						<div class="btn btn-w">
							<input type="submit" value="작성" class="btn btn-w"
								onClick="prevCheckTextBox()" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

<%@ include file="../includes/footer.jsp" %>

	<script>
	
	function showErrorPopup(title) {
	    Swal.fire({
	        title: title,
	        icon: 'error',
	        confirmButtonColor: '#3085d6',
	        confirmButtonText: '확인'
	    });
	}
	
	function prevCheckTextBox() { 
			
 		 if (!$('#requester').val()) {
 	        showErrorPopup('작성자를 입력하세요. 모든 정보를 입력해주세요');
 	        $('#requester').focus();
 	        return;
 	    }

 	    if ($('#requester').val().length > 5) {
 	        showErrorPopup('이름을 5자 내외로 입력해주세요. 모든 정보를 입력해주세요');
 	        $('#requester').focus();
 	        return;
 	    }

 	    if (!$('#brand').val()) {
 	        showErrorPopup('브랜드를 입력하세요. 모든 정보를 입력해주세요');
 	        $('#brand').focus();
 	        return;
 	    }

 	    if (!$('#quantity').val()) {
 	        showErrorPopup('수량을 입력하세요. 모든 정보를 입력해주세요');
 	        $('#quantity').focus();
 	        return;
 	    }
 	    
   	 Swal.fire({
   	    title: '등록 하시겠습니까?',
   	    text: '',
   	    icon: 'warning',
   	    showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
   	    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
   	    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
   	    confirmButtonText: '확인', // confirm 버튼 텍스트 지정
   	    cancelButtonText: '취소', // cancel 버튼 텍스트 지정                      
   	    reverseButtons: true, // 버튼 순서 거꾸로
   	}).then(result => {
   	    if (result.isConfirmed) {
   	        Swal.fire('등록 되었습니다.', '', 'success');
   	        setTimeout(function() {
   	         document.getElementById('form1').submit();
   	        }, 2000); // 2초 후에 폼 제출
   	    } else if (result.isDismissed) { // 만약 모달창에서 cancel 버튼을 눌렀다면
   	        Swal.fire('등록이 취소되었습니다.', '', 'info');
					}
   	    
    });   
}
   	</script>
	<%
	// 캐시 만료를 통한 뒤로가기 방지
	response.setHeader("Expires", "Thu, 27 Jul 2023 09:00:00 GMT"); // 현재시각보다 이전으로 만료시간을 설정
	response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, post-check=0, pre-check=0"); // str 로 "" 으로 넣는것보단, 상수형으로 넣어주는게 좋다. 
	response.setHeader("Pragma", "no-cache");
	%>

</body>
</html>