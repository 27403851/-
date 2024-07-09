<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<html>
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/purecss@3.0.0/build/pure-min.css">
	<link rel="stylesheet" href="/JavaWeb/css/buttons.css">
	<link rel="stylesheet" href="/JavaWeb/css/register.css">
    <meta charset="UTF-8">
    <title>註冊頁面</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    
    <section>
    <h2>會員註冊</h2>
    <hr>
        <form action="register" method="POST" id="registerForm">
            <label for="username">帳號:</label>
            <input type="text" id="username" name="username" required><br><br>
            
            <label for="password">密碼:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <label for="email">信箱:</label>
            <input type="email" id="email" name="email" required><br><br>
            
            <input type="submit" value="註冊" id="demo1">
            <input type="button" value="清除" onclick="clearForm()">
        </form>
    </section>
    
	<!-- SweetAlert and Script -->
    <script>
        function clearForm() {
            document.getElementById("registerForm").reset();
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            let message = '<%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>';
            if (message && message.trim().length > 0) {
                let icon;
                if (message === "註冊成功") {
                    icon = 'success';
                    Swal.fire({
                        icon: icon,
                        title: 'Registration Result',
                        text: message,
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "/JavaWeb/login"; // 替换为实际的登录页面URL
                        }
                    });
                } else if (message === "資料庫錯誤") {
                    icon = 'error';
                    Swal.fire({
                        icon: icon,
                        title: 'Registration Result',
                        text: message,
                        confirmButtonText: 'OK'
                    });
                } else {
                    icon = 'warning';
                    Swal.fire({
                        icon: icon,
                        title: 'Registration Result',
                        text: message,
                        confirmButtonText: 'OK'
                    });
                }
            }
        });
    </script>
    
</body>
</html>
