<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/sign_up.css">
    <script defer src="./js/sign_up.js"></script>
    <script defer src="./js/jquery-3.7.1.min.js"></script>
</head>
<body>
    <div class="conteiner">
        <div class="title">
            환영합니다!
        </div>
        <div class="sign_up_box">
            <form action="sign_up_insert.jsp" name="userInfo" method="post" class="sign_up_input" onsubmit="return checkDuplicate()">
              <fieldset>	
                <input type="text" name="id" id="id" placeholder=" ID">
    			<button type="button" onclick="checkDuplicate()">중복확인</button>	
    			 	
              </fieldset>
              		              
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
               	   	
                <input type="text" name="koname" id="koname" placeholder=" NAME">
                <input type="text" name="pnum" id="pnum" placeholder=" PHONE_NUMBER">
                <input type="text" name="email" id="email" placeholder=" EMAIL">
                <input type="submit" value="가입" class="submit_bt">
                
            </form>
        </div>        
    </div>
</body>
</html>