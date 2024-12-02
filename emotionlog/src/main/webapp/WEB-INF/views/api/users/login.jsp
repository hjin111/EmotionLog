<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Emotion Log🌱</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #99ddc8, #95bf74); 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #fff;
        }

        .login-container {
            background-color: rgba(40, 63, 59, 0.8); 
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
            transition: opacity 0.3s ease; 
        }

        .login-container h1 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form-group input:focus {
            border-color: #95bf74; 
            outline: none;
            box-shadow: 0 0 5px rgba(149, 191, 116, 0.5);
        }

        button {
            width: 100%;
            background-color: #659b5e;
            color: #fff;
            border: none;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #556f44; 
        }

        .footer {
            margin-top: 20px;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
        }

        .footer a {
            color: #99ddc8; 
            text-decoration: underline;
        }

        #errorModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 10px;
            color: #fff;
            text-align: center;
            z-index: 1000;
        }

        #errorModal button {
            margin-top: 10px;
            background-color: #95bf74;
            border: none;
            padding: 10px 20px;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }

        #errorModal button:hover {
            background-color: #659b5e;
        }

     
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); 
            z-index: 999; 
        }
    </style>
</head>
<body>
    <div class="login-container" id="loginContainer">
        <h1>Login</h1>
        <form action="/api/users/login" method="POST">
            <div class="form-group">
                <label for="username">ID</label>
                <input type="text" id="username" name="username" placeholder="Enter your id" required/>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required/>
            </div>
            <button type="submit">Login</button>
        </form>

        <div class="footer">
            <a href="/api/users/findusername" style="color: #fff; text-decoration: underline;">아이디 찾기 </a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/api/users/passwordupdate" style="color: #fff; text-decoration: underline;"> 비밀번호 변경</a>
        </div>
        <div class="footer">
            계정이 없으신가요? <a href="/api/users/join" style="color: #fff; text-decoration: underline;"> 가입하기</a>
        </div>
    </div>
    <div id="errorModal">
        <p>${error}</p>
        <button id="closeModal">Close</button>
    </div>

    <div id="overlay"></div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var loginError = "<c:out value='${error}'/>"; 

            if (loginError.trim().length > 0) { 
                $("#overlay").fadeIn();
                $("#errorModal").fadeIn();
                $("#loginContainer").css("opacity", "0.3"); 
            }

            $("#closeModal").click(function() {
                $("#overlay").fadeOut();
                $("#errorModal").fadeOut();
                $("#loginContainer").css("opacity", "1"); 
            });
        });
    </script>
</body>
</html>
