<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/sign_up.css">


<script defer src="/resources/js/jquery-3.7.1.min.js"></script>
<script defer src="/resources/js/sign_up.js"></script>

<title>Insert title here</title>

</head>
<body>
    <div class="conteiner">
                 <div class="title">
                    환영합니다!
                 </div>
        <div class="sign_up_box">
            <form action="/user/sign_up" name="userInfo" method="post" class="sign_up_input">

                 <input type="text" name="id" id="id" placeholder=" ID">
                 <button id="checkID" type="button">중복확인</button><br>
                 <span id="olmessage"></span>

                    <div class="success-message hide">사용할 수 있는 아이디입니다(중복체크 해주세요)</div>
				    <div class="failure-message hide">아이디는 4~12글자이어야 합니다</div>
				    <div class="failure-message2 hide">영어 또는 숫자만 가능합니다</div>

                  <fieldset>
                    <input type="password" name="pw" id="pw" placeholder=" PASSWORD">
                  </fieldset>
              
                    <div class="strongPassword-message hide">8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요</div>
              
                  <fieldset>
                    <input type="password" name="pw-retype" id="pw-retype" placeholder=" RE PASSWORD" />
                  </fieldset>
               
               	    <div class="mismatch-message hide">비밀번호가 일치하지 않습니다</div>
               	   	
                        <input type="text" name="name" id="name" placeholder=" NAME">
                        <input type="text" name="phone" id="phone" placeholder=" PHONE_NUMBER">
                        <input type="text" name="email" id="email" placeholder=" EMAIL">
                        <input type="submit" value="가입" class="submit_bt">
            </form>
        </div>        
    </div>

    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">알림</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p id="modalMessage">모달 메시지</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"></button>
                </div>
            </div>
        </div>
    </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
            function showModal(message) {
                $('#modalMessage').text(message);
                $('#myModal').modal('show');
            }
        </script>
</body>
</html>