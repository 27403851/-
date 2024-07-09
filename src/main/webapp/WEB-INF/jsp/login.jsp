<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
    <link rel="stylesheet" href="/JavaWeb/css/buttons.css">
    <link rel="stylesheet" href="/JavaWeb/css/login.css">
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    
    <div>
        <form action="login" method="POST">
            <h2>登入頁面</h2>
            <hr>
            <label for="username">帳號:</label>
            <input type="text" id="username" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required><br><br>
            
            <label for="password">密碼:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <p>${message}</p>
            
            <input type="submit" value="登入">
            <input type="button" value="清除" onclick="clearForm()">
        </form>        
    </div>
    
    <script>
        function clearForm() {
            document.getElementById("username").value = "";
            document.getElementById("password").value = "";
        }
    </script>
    
</body>
</html>
