<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <link rel="stylesheet" href="./css/find.css">
    <link rel="stylesheet" href="./css/reset.css">
    
</head>
<body>
<div class="conteiner">
    <form action="find_id_process.jsp" method="post" class="find_id_box">
        <h3>아이디 찾기</h3>
        <input type="text" id="find_id" name="find_id" placeholder="이름" />
        <br>
        <input type="email" id="find_email" name="find_email" placeholder="이메일" />
        <br>
        <input type="submit" value="찾기" class="find_but">
        <input type="button" value="뒤로가기" onclick="location.href='login.jsp'" class="back_but">
    </form>
    
     <form action="find_pw_process.jsp" method="post" class="find_pw_box">
        <h3>비밀번호 찾기</h3>
        <input type="text" id="find_pw_id" name="find_pw_id" placeholder="아이디" />
        <br>
        <input type="text" id="find_pw_name" name="find_pw_name" placeholder="이름" />
        <br>
        <input type="email" id="find_pw_email" name="find_pw_email" placeholder="이메일" />
        <br>
        <input type="submit" value="찾기" class="find_but">
        <input type="button" value="뒤로가기" onclick="location.href='login.jsp'" class="back_but">
    </form>
</div>    
</body>
</html>