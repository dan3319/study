<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="./css/reset.css">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <script defer src="./js/jquery-3.7.1.min.js"></script>
    <script defer src="./js/login.js"></script>
</head>
<body>
<div class="conteiner">
    <div class="withe_box">
            <h3 class="tirle">Login</h3>
            <form action="login_form.jsp" id="form1" class="log_box" method="post">
              <div class="id_box">  
                <input type="text" name="iputid" id="iputid" class="id_put" />
                    <span class="material-symbols-outlined">
                        person
                    </span>
              </div>
              <div class="pw_box">       
                <input type="password" name="iputpw" id="iputpw" class="pw_put" />
                    <span class="material-symbols-outlined">
                        visibility_off
                    </span>
              </div>
                <input type="submit" value="Login" name="log_but" id="log_but" class="log_but" />
            </form>
            

        <div class="check">
          <span class="input_wrap">
	          	<input type="checkbox" id="checkId" name="checkId">
	          	<label for="checkId"><span></span></label>
	          	아이디 저장
          </span>   
            <div class="check_pw">
                <a href="find_id_pw.jsp" class="ck_pw">아이디 / 비밀번호 찾기</a><br>    
            </div>
            <div class="check_id">
                <a href="sign_up.jsp" class="ck_id">계정생성</a> 
            </div>
            </div>   
        </div>
    </div>
</body>
</html>