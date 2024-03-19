<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Result</title>
</head>
<body>
     <script>
        var message = "<%= request.getAttribute("message") %>";
        var joinUrl = "<%= request.getAttribute("join") %>";
        alert(message);
        window.location.href = joinUrl;
    </script>
</body>
</html>